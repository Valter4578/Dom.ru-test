//
//  DayRouter.swift
//  YandexWeather
//
//  Created by Максим Алексеев on 11.07.2021.
//

import Foundation

class DayRouter: DayRouterProtocol {
    // MARK:- Properties
    weak var viewController: DayViewController!
    
    // MARK:- Init
    required init(viewController: DayViewController) {
        self.viewController = viewController
    }
}
