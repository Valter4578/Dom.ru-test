//
//  WeekViewController.swift
//  YandexWeather
//
//  Created by Максим Алексеев on 10.07.2021.
//

import UIKit

class WeekViewController: UIViewController {
    // MARK:- Dependencies
    var presenter: WeekPresenterProtocol!
    var assembly: WeekAssemblyProtocol!
    
    // MARK:- Private properties
    private let cellId = "WeekTableViewCellId"
    
    // MARK:- Views
    lazy var forecastTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.register(ForecastTableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.dataSource = self
        return tableView
    }()
    
    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        assembly.assemble(with: self)
        setupTableView()
        presenter.configureView()
    }
    
    // MARK:- Setup
    func setupTableView() {
        view.addSubview(forecastTableView)
        NSLayoutConstraint.activate([
            forecastTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            forecastTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            forecastTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            forecastTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

// MARK:- UITableViewDataSource
extension WeekViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? ForecastTableViewCell else { return UITableViewCell() }
        
        cell.configureLabel(with: presenter.getForrmatedCellTitle(for: indexPath.row))
        cell.configureImageView(with: presenter.getImageUrl(for: indexPath.row))
        
        return cell
    }    
}

// MARK:- UITableViewDelegate
extension WeekViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.didSelectCell(with: indexPath.row)
    }
}

// MARK:- WeekViewProtocol
extension WeekViewController: WeekViewProtocol {
    func configureTitle(_ title: String) {
        self.title = title
    }
    
    func showAlert(with text: String) {
        let alertController = UIAlertController(title: "Error", message: text, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
    func reloadData() {
        forecastTableView.reloadData()
    }
    
}
