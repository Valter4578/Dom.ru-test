//
//  DayInteractor.swift
//  YandexWeather
//
//  Created by Максим Алексеев on 11.07.2021.
//

import Foundation

protocol DayInteractor {
    
}

class DefaultDayInteractor: DayInteractor {
    // MARK:- Dependencies
    weak var presenter: DayPresenter! 
}
