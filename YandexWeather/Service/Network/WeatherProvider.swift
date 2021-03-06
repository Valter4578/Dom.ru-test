//
//  WeatherProvider.swift
//  YandexWeather
//
//  Created by Максим Алексеев on 10.07.2021.
//

import Foundation
import Moya

enum WeatherProvider {
    case hourWeater(Coordinates)
}

extension WeatherProvider: TargetType {
    var baseURL: URL {
        guard let url = URL(string: "https://api.weather.yandex.ru/v2") else { fatalError("Incorrect url") }
        return url
    }
    
    var path: String {
        return "/forecast"
    }
    
    var method: Moya.Method {
        return Method.get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .hourWeater(let coordinates):
            var params: [String: Any] = [:]
            params["hours"] = true
            params["lang"] = "ru_RU"
            params["lat"] = coordinates.lon
            params["lon"] = coordinates.lon
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json", "X-Yandex-API-Key": "1207387e-2f08-43e5-a4a4-b58bea4baea9"]
    }
}


