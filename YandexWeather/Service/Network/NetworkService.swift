//
//  NetworkService.swift
//  YandexWeather
//
//  Created by Максим Алексеев on 10.07.2021.
//

import Foundation
import Moya

protocol NetworkService {
    func getHourForecast(coordinates: Coordinates,complete: @escaping (Result<ForecastInfo, Error>) -> ())
}

class DefaultNetworkService: NetworkService {
    // MARK:- Private properties
    private var provider = MoyaProvider<WeatherService>()
    
    // MARK:- Functions
    func getHourForecast(coordinates: Coordinates,complete: @escaping (Result<ForecastInfo, Error>) -> ()) {
        provider.request(.hourWeater(coordinates)) { response in
            switch response {
            case .success(let result):
                do {
                    let forecast = try JSONDecoder().decode(ForecastInfo.self, from: result.data)
                    complete(.success(forecast))
                } catch {
                    print(error)
                    complete(.failure(error))
                }
            case .failure(let error):
                print(error)
                complete(.failure(error))
            }
        }
    }
}
