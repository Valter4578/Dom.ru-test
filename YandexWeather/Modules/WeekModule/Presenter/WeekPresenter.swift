//
//  WeekPresenter.swift
//  YandexWeather
//
//  Created by Максим Алексеев on 10.07.2021.
//

import Foundation

protocol WeekPresenter: class {
    var cellId: String { get }
    var forecasts: [DayForecast] { get }
    
    func configureView()
    func handleForecast(_ forecast: ForecastInfo)
    func handleError(_ error: Error) 
}

class DefaultWeekPresenter: WeekPresenter {
    // MARK:- Dependencies
    weak var view: WeekView!
    var interactor: WeekInteractor!
    var router: WeekRouter! 
    
    // MARK:- Properties
    var cellId: String {
        return "WeekCellId"
    }
    
    private(set) var forecasts: [DayForecast] = []

    // MARK:- Inits
    required init(view: WeekView) {
        self.view = view
    }
    
    // MARK:- Functions
    func configureView() {
        view.configureTitle("Week forecast")
    }
    
    func handleForecast(_ forecast: ForecastInfo) {
        forecasts = forecast.asDayForecasts()
        view.reloadData()
    }
    
    func handleError(_ error: Error) {
        view.showAlert(with: error.localizedDescription)
    }
}
