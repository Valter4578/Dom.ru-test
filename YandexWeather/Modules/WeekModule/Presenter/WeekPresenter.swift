//
//  WeekPresenter.swift
//  YandexWeather
//
//  Created by Максим Алексеев on 10.07.2021.
//

import UIKit

protocol WeekPresenter: class {
    var cellId: String { get }
    var forecasts: [DayForecast] { get }
    
    func configureView()
    func getForrmatedCellTitle(for index: Int) -> String?
    func getImageUrl(for index: Int) -> URL?
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
    
    func getImageUrl(for index: Int) -> URL? {
        let imageName = forecasts[index].dayIconUrl
        guard let url = URL(string: "https://yastatic.net/weather/i/icons/blueye/color/svg/\(imageName).svg") else { return nil }
        
        return url
    }
    
    func getForrmatedCellTitle(for index: Int) -> String? {
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let forecast = forecasts[index]
        guard let date = formatter.date(from: forecast.day) else { return nil }
        
        let day = Calendar.current.component(.weekday, from: date)
        let dayOfTheWeek = Calendar.current.weekdaySymbols[day - 1]
        return "\(dayOfTheWeek): \(forecast.dayTemperature)"
     }
    
    func handleForecast(_ forecast: ForecastInfo) {
        forecasts = forecast.asDayForecasts()
        view.reloadData()
    }
    
    func handleError(_ error: Error) {
        view.showAlert(with: error.localizedDescription)
    }
}
