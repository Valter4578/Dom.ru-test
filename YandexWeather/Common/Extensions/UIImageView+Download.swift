//
//  UIImageView+Download.swift
//  YandexWeather
//
//  Created by Максим Алексеев on 11.07.2021.
//

import UIKit
import SVGKit

var imageCache = NSCache<NSString, AnyObject>()

extension UIImageView {
    func load(from url: URL?) {
        guard let url = url else { return }
        
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) as? UIImage {
            self.image = cachedImage
            return
        }
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            do {
                let data = try Data(contentsOf: url)
                let svgImage = SVGKImage(data: data)
                if let image = svgImage?.uiImage {
                    DispatchQueue.main.async {
                        imageCache.setObject(image, forKey: url.absoluteString as NSString)
                        self?.image = image
                    }
                }
            } catch {
                print(error)
            }
        }
    }
}
