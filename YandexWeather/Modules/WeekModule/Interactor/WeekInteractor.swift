//
//  WeekInteractor.swift
//  YandexWeather
//
//  Created by Максим Алексеев on 10.07.2021.
//

import Foundation

protocol WeekInteractor {
    func getWeather()
}

class DefaultWeekInteractor: WeekInteractor {
    // MARK:- Dependencies
    weak var presenter: WeekPresenter! 
    private let networkService: NetworkService!
    private let databaseService: DatabaseService!
    private let locationService: LocationService!
    
    // MARK:- Private properties
    private var coordinates: Coordinates? {
        didSet {
            getWeather()
        }
    }
    
    // MARK:- Functions
    func getWeather() {
        DispatchQueue.global(qos: .utility).async {
            let dbDayForecasts = self.databaseService.fetch(of: DBDayForecast.self)
            if !dbDayForecasts.isEmpty {
                let dayForecasts = dbDayForecasts.map { $0.toCore() }
                self.presenter.handleForecast(dayForecasts)
            }
        }
    
        guard let coordinates = coordinates else { return }
        networkService.getForecast(coordinates: coordinates) { result in
            switch result {
            case .success(let forecastInfo):
                DispatchQueue.global(qos: .utility).async {
                    self.databaseService.deleteAll()
                    let dbDayForecasts = forecastInfo.asDayForecasts().map { $0.toDb() }
                    self.databaseService.save(objects: dbDayForecasts)
                }
                let dayForecasts = forecastInfo.asDayForecasts()
                self.presenter.handleForecast(dayForecasts)
            case .failure(let error):
                self.presenter.handleError(error)
            }
        }
    }
    
    // MARK:- Private functions
    
    // MARK:- Init
    required init(presenter: WeekPresenter, networkService: NetworkService, databaseService: DatabaseService, locationService: LocationService) {
        self.presenter = presenter
        self.networkService = networkService
        self.databaseService = databaseService
        self.locationService = locationService
        self.locationService.delegate = self
    }
}

extension DefaultWeekInteractor: LocationServiceDelegate {
    func locationDidUpdate(lat: Double, lon: Double) {
        guard coordinates?.lat != lat, coordinates?.lon != lon else { return }
        coordinates = Coordinates(lat: lat, lon: lon)
    }
}
