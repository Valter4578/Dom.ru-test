//
//  ForecastInfo.swift
//  YandexWeather
//
//  Created by Максим Алексеев on 10.07.2021.
//

import Foundation

struct ForecastInfo: Codable {
    let forecasts: [Forecast]
}

extension ForecastInfo {
    func asDayForecasts() -> [DayForecast] {
        return forecasts.map {
            DayForecast(day: $0.date,
                        dayIconName: $0.parts.dayShort.icon,
                        dayTemperature: $0.parts.dayShort.temp,
                        hours: $0.hours.map {
                            HourForecast(hour: $0.hour,
                                             iconName: $0.icon,
                                             temp: $0.temp)
                        })
        }
    }
}
