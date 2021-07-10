//
//  Forcast.swift
//  YandexWeather
//
//  Created by Максим Алексеев on 10.07.2021.
//

import Foundation

struct Forecast: Codable {
    let date: String
    let parts: Parts
    let hours: [Hour]
}
