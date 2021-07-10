//
//  WeekRouter.swift
//  YandexWeather
//
//  Created by Максим Алексеев on 10.07.2021.
//

import Foundation

protocol WeekRouter {
    
}

class DefaultWeekRouter: WeekRouter {
    // MARK:- Properties 
    weak var viewController: WeekViewController!
    
    // MARK:- Inits
    init(viewController: WeekViewController) {
        self.viewController = viewController
    }
    
    
}
