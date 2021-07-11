//
//  WeekTableViewCell.swift
//  YandexWeather
//
//  Created by Максим Алексеев on 10.07.2021.
//

import UIKit
import WebKit

final class WeekTableViewCell: UITableViewCell {
    // MARK:- View
    lazy var tempLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var iconImageView: UIImageView = {
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
        addSubview(tempLabel)
        NSLayoutConstraint.activate([
            tempLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            tempLabel.topAnchor.constraint(equalTo: topAnchor),
            tempLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            tempLabel.trailingAnchor.constraint(equalTo: iconImageView.leadingAnchor, constant: -5)
        ])
    }
}
