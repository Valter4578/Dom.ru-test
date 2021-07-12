//
//  ForecastTableViewCell.swift
//  YandexWeather
//
//  Created by Максим Алексеев on 12.07.2021.
//

import UIKit

final class ForecastTableViewCell: UITableViewCell {
    // MARK:- View
    private lazy var forecastLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK:- Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupImageView()
        setupLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Configure
    func configureLabel(with text: String) {
        forecastLabel.text = text
    }
    
    func configureImageView(with url: URL?) {
        iconImageView.load(from: url)
    }
    
    // MARK:- Setup
    private func setupImageView() {
        addSubview(iconImageView)
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: topAnchor),
            iconImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            iconImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 100),
        ])
    }
    
    private func setupLabel() {
        addSubview(forecastLabel)
        NSLayoutConstraint.activate([
            forecastLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            forecastLabel.topAnchor.constraint(equalTo: topAnchor),
            forecastLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            forecastLabel.trailingAnchor.constraint(equalTo: iconImageView.leadingAnchor, constant: -5)
        ])
    }
}
