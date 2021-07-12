//
//  DayProtocols.swift
//  YandexWeather
//
//  Created by Максим Алексеев on 12.07.2021.
//

import Foundation

protocol DayRouterProtocol {
    var viewController: DayViewController! { get set }
}

protocol DayPresenterProtocol: AnyObject {
    var numberOfCells: Int { get }
    
    func configureView()
    func getFormattedCellText(for index: Int) -> String
    func getIconUrl(for index: Int) -> URL?
}

protocol DayInteractorProtocol {
    var presenter: DayPresenterProtocol! { get set }
}

protocol DayView: AnyObject {
    func configureTitle(_ title: String)
}

protocol DayAssemblyProtocol {
    func assemble(with viewController: DayViewController, forecast: DayForecast)
}
