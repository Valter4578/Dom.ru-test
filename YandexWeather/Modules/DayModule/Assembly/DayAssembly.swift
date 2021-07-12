//
//  DayAssembly.swift
//  YandexWeather
//
//  Created by Максим Алексеев on 11.07.2021.
//

import Foundation

class DayAssembly {
    func assemble(with viewController: DayViewController, forecast: DayForecast) {
        let presenter = DefaultDayPresenter(view: viewController)
        let interactor = DefaultDayInteractor()
        let router = DefaultDayRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        presenter.forecast = forecast
    }
}
