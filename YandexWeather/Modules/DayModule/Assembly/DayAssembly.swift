//
//  DayAssembly.swift
//  YandexWeather
//
//  Created by Максим Алексеев on 11.07.2021.
//

import Foundation

class DayAssembly: DayAssemblyProtocol {
    func assemble(with viewController: DayViewController, forecast: DayForecast) {
        let presenter = DayPresenter(view: viewController)
        let interactor = DayInteractor()
        let router = DayRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        presenter.forecast = forecast
    }
}
