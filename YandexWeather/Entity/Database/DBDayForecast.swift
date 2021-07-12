//
//  DBDayForecast.swift
//  YandexWeather
//
//  Created by Максим Алексеев on 12.07.2021.
//

import Foundation
import RealmSwift

@objcMembers
class DBDayForecast: Object {
    dynamic var _id: ObjectId = ObjectId.generate()
    dynamic var day: String = ""
    dynamic var dayIconName: String = ""
    dynamic var dayTemperature: Int = Int()
    dynamic var hours = RealmSwift.List<DBHourForecast>()
    
    override class func primaryKey() -> String? {
        return "_id"
    }
}

extension DBDayForecast {
    func toCore() -> DayForecast {
        return DayForecast(day: day,
                           dayIconName: dayIconName,
                           dayTemperature: dayTemperature,
                           hours: hours.map { $0.toCore() } )
    }
}
