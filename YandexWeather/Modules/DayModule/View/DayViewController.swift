//
//  DayViewController.swift
//  YandexWeather
//
//  Created by Максим Алексеев on 11.07.2021.
//

import UIKit

protocol DayView: class {
    func configureTitle(_ title: String)
}

class DayViewController: UIViewController, DayView {
    // MARK:- Dependencies
    var assembly = DayAssembly()
    var presenter: DayPresenter!
    
    // MARK:- Properties
    var forecast: DayForecast? 
    
    // MARK:- Views
    lazy var forecastTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ForecastTableViewCell.self, forCellReuseIdentifier: presenter.cellId)
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
    
    // MARK:- Configure
    func configureTitle(_ title: String) {
        navigationController?.title = title
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
}

// MARK:- UITableViewDataSource
extension DayViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: presenter.cellId, for: indexPath) as? ForecastTableViewCell else { fatalError("Couldn't dequeue ForecastTableViewCell") }
        cell.forecastLabel.text = presenter.getFormattedCellText(for: indexPath.row)
        cell.iconImageView.load(from: presenter.getIconUrl(for: indexPath.row))
        return cell
    }
}
