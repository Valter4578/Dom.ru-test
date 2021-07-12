//
//  DateFormatter.swift
//  YandexWeather
//
//  Created by Максим Алексеев on 11.07.2021.
//

import Foundation

extension DateFormatter {
    func weekday(from stringDate: String) -> String? {
        dateFormat = "yyyy-MM-dd"
        guard let date = date(from: stringDate) else { return nil }
        
        let day = Calendar.current.component(.weekday, from: date)
        let dayOfTheWeek = Calendar.current.weekdaySymbols[day - 1]
        return dayOfTheWeek
    }
}
