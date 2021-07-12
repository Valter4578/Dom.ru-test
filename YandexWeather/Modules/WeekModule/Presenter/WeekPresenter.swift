//
//  WeekPresenter.swift
//  YandexWeather
//
//  Created by Максим Алексеев on 10.07.2021.
//

import UIKit

class WeekPresenter: WeekPresenterProtocol {
    // MARK:- Dependencies
    weak var view: WeekViewProtocol!
    var interactor: WeekInteractorProtocol!
    var router: WeekRouterProtocol! 
    
    // MARK:- Properties
    private(set) var forecasts: [DayForecast] = []

    // MARK:- Inits
    required init(view: WeekViewProtocol) {
        self.view = view
    }
    
    // MARK:- Functions
    func configureView() {
        view.configureTitle("Week forecast")
    }
    
    func getImageUrl(for index: Int) -> URL? {
        let imageUrl = forecasts[index].dayIconUrl
        guard let url = URL(string: imageUrl) else { return nil }
        return url
    }
    
    func getForrmatedCellTitle(for index: Int) -> String {
        let formatter  = DateFormatter()
        let forecast = forecasts[index]

        guard let dayOfTheWeek = formatter.weekday(from: forecast.day) else { return "" }
        return "\(dayOfTheWeek): \(forecast.dayTemperature)"
     }
    
    func handleForecast(_ forecasts: [DayForecast]) {
        DispatchQueue.main.async {
            self.forecasts = forecasts
            self.view.reloadData()
        }
    }
    
    func handleError(_ error: Error) {
        view.showAlert(with: error.localizedDescription)
    }
    
    func didSelectCell(with index: Int) {
        router.openDetail(with: forecasts[index])
    }
}
