//
//  HourForecast.swift
//  YandexWeather
//
//  Created by Максим Алексеев on 10.07.2021.
//

import Foundation

struct HourForecast {
    let hour: String
    let iconUrl: String
    let temp: Int
}

extension HourForecast {
    func toDb() -> DBHourForecast {
        let dbHourForecast = DBHourForecast()
        dbHourForecast.hour = hour
        dbHourForecast.iconName = iconUrl
        dbHourForecast.temp = temp
        return dbHourForecast
    }
}
