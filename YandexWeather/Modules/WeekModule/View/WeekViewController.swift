//
//  WeekViewController.swift
//  YandexWeather
//
//  Created by Максим Алексеев on 10.07.2021.
//

import UIKit

protocol WeekView: class {
    func configureTitle(_ title: String)
    func reloadData()
    func showAlert(with text: String)
}

class WeekViewController: UIViewController, WeekView {
    // MARK:- Dependencies
    var presenter: WeekPresenter!
    var assembly = WeekAssembly()
    
    // MARK:- Private properties
    
    // MARK:- Properties
    
    // MARK:- Views
    lazy var forecastTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: presenter.cellId)
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
    
    // MARK:- WeekView
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
    // MARK:- Functions
}

// MARK:- UITableViewDataSource
extension WeekViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: presenter.cellId, for: indexPath)
        let forecast = presenter.forecasts[indexPath.row]
        cell.textLabel?.text = "\(forecast.day) - \(forecast.dayTemperature)"
        return cell
    }    
}

// MARK:- UITableViewDelegate
extension WeekViewController: UITableViewDelegate {
    
}

