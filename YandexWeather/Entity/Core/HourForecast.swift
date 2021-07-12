//
//  HourForecast.swift
//  YandexWeather
//
//  Created by Максим Алексеев on 10.07.2021.
//

import Foundation

struct HourForecast {
    let hour: String
    let iconName: String
    let temp: Int
}

extension HourForecast {
    func toDb() -> DBHourForecast {
        let dbHourForecast = DBHourForecast()
        dbHourForecast.hour = hour
        dbHourForecast.iconName = iconName
        dbHourForecast.temp = temp
        return dbHourForecast
    }
}
