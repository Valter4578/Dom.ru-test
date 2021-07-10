//
//  WeekAssembly.swift
//  YandexWeather
//
//  Created by Максим Алексеев on 10.07.2021.
//

import Foundation

class WeekAssembly {
    // MARK:- Functions
    func assemble(with viewController: WeekViewController) {
        let presenter = DefaultWeekPresenter(view: viewController)
        let networkService = DefaultNetworkService()
        let databaseService = DefaultDatabaseService()
        let locationService = LocationService()
        let interactor = DefaultWeekInteractor(presenter: presenter, networkService: networkService, databaseService: databaseService, locationService: locationService)
        let router = DefaultWeekRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
