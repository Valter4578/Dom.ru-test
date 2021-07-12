//
//  WeekProtocols.swift
//  YandexWeather
//
//  Created by Максим Алексеев on 12.07.2021.
//

import Foundation

protocol WeekAssemblyProtocol {
    func assemble(with viewController: WeekViewController)
}

protocol WeekRouterProtocol {
    func openDetail(with forecast: DayForecast)
}

protocol WeekInteractorProtocol {
    func getWeather()
}

protocol WeekPresenterProtocol: AnyObject {
    var numberOfCells: Int { get }
    
    func configureView()
    func getForrmatedCellTitle(for index: Int) -> String
    func getImageUrl(for index: Int) -> URL?
    func handleForecast(_ forecasts: [DayForecast])
    func handleError(_ error: Error)
    func didSelectCell(with index: Int)
}

protocol WeekViewProtocol: AnyObject {
    func configureTitle(_ title: String)
    func reloadData()
    func showAlert(with text: String)
}
