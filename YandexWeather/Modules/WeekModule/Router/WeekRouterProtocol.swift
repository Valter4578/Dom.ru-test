//
//  WeekRouter.swift
//  YandexWeather
//
//  Created by Максим Алексеев on 10.07.2021.
//

import Foundation


class DefaultWeekRouter: WeekRouterProtocol {
    // MARK:- Properties 
    weak var viewController: WeekViewController!
    
    // MARK:- Inits
    init(viewController: WeekViewController) {
        self.viewController = viewController
    }
    
    // MARK:- Functions
    func openDetail(with forecast: DayForecast) {
        let dayViewController = DayViewController()
        dayViewController.assembly = DayAssembly() 
        dayViewController.assembly.assemble(with: dayViewController, forecast: forecast)
        viewController.navigationController?.pushViewController(dayViewController, animated: true)
    }
}
