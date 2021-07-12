//
//  DayPresenter.swift
//  YandexWeather
//
//  Created by Максим Алексеев on 11.07.2021.
//

import Foundation

class DayPresenter: DayPresenterProtocol {
    // MARK:- Dependencies
    var interactor: DayInteractorProtocol!
    weak var view: DayView!
    var router: DayRouterProtocol!
    
    // MARK:- Properties
    var forecast: DayForecast?
    
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
        guard let url = URL(string: forecast.hours[index].iconUrl) else { return nil }
        return url
    }
    
    // MARK:- Private functions 
    private func getTitle() -> String {
        let formatter = DateFormatter()
        guard let forecast = forecast else { return "" }
        return formatter.weekday(from: forecast.day) ?? ""
    }
}
