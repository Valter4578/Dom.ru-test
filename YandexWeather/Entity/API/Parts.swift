//
//  Parts.swift
//  YandexWeather
//
//  Created by Максим Алексеев on 10.07.2021.
//

import Foundation

struct Parts: Codable {
    let dayShort: Day
    let nightShort: Day
}

extension Parts {
    enum CodingKeys: String, CodingKey {
        case dayShort = "day_short"
        case nightShort = "night_short"
    }
}
