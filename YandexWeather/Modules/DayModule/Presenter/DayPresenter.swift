//
//  DayPresenter.swift
//  YandexWeather
//
//  Created by Максим Алексеев on 11.07.2021.
//

import Foundation

protocol DayPresenter: class {
    var cellId: String { get }
    var forecast: DayForecast? { get set }
    var numberOfCells: Int { get }
    
    func configureView()
    func getFormattedCellText(for index: Int) -> String
    func getIconUrl(for index: Int) -> URL?
}

class DefaultDayPresenter: DayPresenter {
    // MARK:- Dependencies
    var interactor: DayInteractor!
    weak var view: DayView!
    var router: DayRouter!
    
    // MARK:- Properties
    var forecast: DayForecast?
    
    var cellId: String {
        return "DayTableViewCell"
    }
    
    var numberOfCells: Int {
        guard let forecast = forecast else { return 0 }
        return forecast.hours.count
    }
    
    // MARK:- Inits
    required init(view: DayView) {
        self.view = view 
    }
    
    // MARK:- Functions
    func configureView() {
        view.configureTitle(getTitle())
    }
    
    func getFormattedCellText(for index: Int) -> String {
        guard let forecast = forecast else { return "" }
        let hour = forecast.hours[index]
        return "\(hour.hour): \(hour.temp)"
    }
    
    func getIconUrl(for index: Int) -> URL? {
        guard let forecast = forecast else { return nil }
        let hour = forecast.hours[index]
        guard let url = URL(string: "https://yastatic.net/weather/i/icons/blueye/color/svg/\(hour.iconName).svg") else { return nil }
        return url
    }
    
    // MARK:- Private functions 
    private func getTitle() -> String {
        let formatter = DateFormatter()
        guard let forecast = forecast else { return "" }
        return formatter.weekday(from: forecast.day) ?? ""
    }
}
