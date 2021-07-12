//
//  WeekInteractor.swift
//  YandexWeather
//
//  Created by Максим Алексеев on 10.07.2021.
//

import Foundation

class WeekInteractor: WeekInteractorProtocol {
    // MARK:- Dependencies
    weak var presenter: WeekPresenterProtocol!
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
        obtainForecast()
    
        guard let coordinates = coordinates else { return }
        networkService.getForecast(coordinates: coordinates) { result in
            switch result {
            case .success(let forecastInfo):
                let dayForecasts = forecastInfo.asDayForecasts()
                let dbDayForecasts = dayForecasts.map { $0.toDb() }
                self.save(forecasts: dbDayForecasts)
                self.presenter.handleForecast(dayForecasts)
            case .failure(let error):
                self.presenter.handleError(error)
            }
        }
    }
    
    // MARK:- Private functions
    private func obtainForecast() {
        DispatchQueue.global(qos: .utility).async {
            let dbDayForecasts = self.databaseService.fetch(of: DBDayForecast.self)
            if !dbDayForecasts.isEmpty {
                let dayForecasts = dbDayForecasts
                    .map { $0.toCore() }
                    .sorted(by: { $0.day < $1.day } )
                self.presenter.handleForecast(dayForecasts)
            }
        }
    }
    
    private func save(forecasts: [DBDayForecast]) {
        DispatchQueue.global(qos: .utility).async {
            self.databaseService.deleteAll()
            self.databaseService.save(objects: forecasts)
        }
    }
    
    // MARK:- Init
    required init(presenter: WeekPresenterProtocol, networkService: NetworkService, databaseService: DatabaseService, locationService: LocationService) {
        self.presenter = presenter
        self.networkService = networkService
        self.databaseService = databaseService
        self.locationService = locationService
        self.locationService.delegate = self
    }
}

extension WeekInteractor: LocationServiceDelegate {
    func locationDidUpdate(lat: Double, lon: Double) {
        guard coordinates?.lat != lat, coordinates?.lon != lon else { return }
        coordinates = Coordinates(lat: lat, lon: lon)
    }
}
