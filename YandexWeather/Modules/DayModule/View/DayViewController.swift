//
//  DayViewController.swift
//  YandexWeather
//
//  Created by Максим Алексеев on 11.07.2021.
//

import UIKit

class DayViewController: UIViewController {
    // MARK:- Dependencies
    var assembly: DayAssemblyProtocol!
    var presenter: DayPresenterProtocol!
    
    // MARK:- Private Properties
    private let cellId = "DayTableViewCellId"
    
    // MARK:- Views
    lazy var forecastTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ForecastTableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
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

extension DayViewController: UITableViewDelegate  {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK:- UITableViewDataSource
extension DayViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? ForecastTableViewCell else { fatalError("Couldn't dequeue ForecastTableViewCell") }
        cell.configureLabel(with: presenter.getFormattedCellText(for: indexPath.row))
        cell.configureImageView(with: presenter.getIconUrl(for: indexPath.row))
        return cell
    }
}

// MARK:- DayViewProtocol 
extension DayViewController: DayView {
    func configureTitle(_ text: String) {
        self.title = text
    }
}
