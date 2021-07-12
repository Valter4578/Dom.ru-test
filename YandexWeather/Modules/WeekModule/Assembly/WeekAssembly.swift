//
//  WeekAssembly.swift
//  YandexWeather
//
//  Created by Максим Алексеев on 10.07.2021.
//

import Foundation

class WeekAssembly: WeekAssemblyProtocol {
    // MARK:- Functions
    func assemble(with viewController: WeekViewController) {
        let presenter = WeekPresenter(view: viewController)
        let networkService = DefaultNetworkService()
        let databaseService = DefaultDatabaseService()
        let locationService = LocationService()
        let interactor = WeekInteractor(presenter: presenter,
                                               networkService: networkService,
                                               databaseService: databaseService,
                                               locationService: locationService)
        
        let router = WeekRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
