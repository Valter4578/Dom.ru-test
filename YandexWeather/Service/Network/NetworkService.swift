//
//  NetworkService.swift
//  YandexWeather
//
//  Created by Максим Алексеев on 10.07.2021.
//

import Foundation
import Moya

protocol NetworkService {
    func getHourForecast(complete: @escaping (ForecastInfo) -> ())
    func getWeekForecase(complete: @escaping (ForecastInfo) -> ())
}

class DefaultNetworkService {
    // MARK:- Private properties
    private var provider = MoyaProvider<WeatherService>()
    
    // MARK:- Functions
    func getHourForecast(lat: Double, lon: Double,complete: @escaping (Result<ForecastInfo, Error>) -> ()) {
        provider.request(.hourWeater(lat, lon)) { response in
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
    
    func getWeekForecase(lat: Double, lon: Double, complete: @escaping (Result<ForecastInfo, Error>) -> ()) {
        provider.request(.weakWeather(lat, lon)) { response in
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
