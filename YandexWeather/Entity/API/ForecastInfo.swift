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
                        dayIconUrl: "https://yastatic.net/weather/i/icons/blueye/color/svg/\($0.parts.dayShort.icon).svg",
                        dayTemperature: $0.parts.dayShort.temp,
                        hours: $0.hours.map {
                            HourForecast(hour: $0.hour,
                                             iconUrl: "https://yastatic.net/weather/i/icons/blueye/color/svg/\($0.icon).svg",
                                             temp: $0.temp)
                        })
        }
    }
}
