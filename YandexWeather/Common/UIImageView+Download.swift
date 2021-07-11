//
//  UIImageView+Download.swift
//  YandexWeather
//
//  Created by Максим Алексеев on 11.07.2021.
//

import UIKit
import SVGKit

extension UIImageView {
    func load(from url: URL) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            do {
                let data = try Data(contentsOf: url)
                let svgImage = SVGKImage(data: data)
                if let image = svgImage?.uiImage {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            } catch {
                print(error)
            }
        }
    }
}
