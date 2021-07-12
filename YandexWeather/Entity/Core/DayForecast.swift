//
//  DayForecast.swift
//  YandexWeather
//
//  Created by Максим Алексеев on 10.07.2021.
//

import Foundation

struct DayForecast {
    let day: String
    let dayIconUrl: String
    let dayTemperature: Int
    let hours: [HourForecast]
}

extension DayForecast {
    func toDb() -> DBDayForecast {
        let dbDayForecast = DBDayForecast()
        dbDayForecast.dayIconName = dayIconUrl
        dbDayForecast.day = day
        dbDayForecast.dayTemperature = dayTemperature
        
        hours.forEach {
            dbDayForecast.hours.append($0.toDb())
        }
        
        return dbDayForecast
    }
}
