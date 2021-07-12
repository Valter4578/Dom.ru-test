//
//  DBHourForecast.swift
//  YandexWeather
//
//  Created by Максим Алексеев on 12.07.2021.
//

import Foundation
import RealmSwift

//struct HourForecast {
//    let hour: String
//    let iconUrl: String
//    let temp: Int
//}

@objcMembers
class DBHourForecast: Object {
    dynamic var _id: ObjectId = ObjectId.generate()
    dynamic var hour: String = ""
    dynamic var iconName: String = ""
    dynamic var temp: Int = Int()
    
    override class func primaryKey() -> String? {
        return "_id"
    }
}

extension DBHourForecast {
    func toCore() -> HourForecast {
        return HourForecast(hour: hour,
                            iconName: iconName,
                            temp: temp)
    }
}
