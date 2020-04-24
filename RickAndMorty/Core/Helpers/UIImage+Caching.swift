//
//  UIImage+Caching.swift
//  RickAndMorty
//
//  Created by Adam Makhfoudi on 24/04/2020.
//  Copyright © 2020 Adam Makhfoudi. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    func cacheImage(urlString: String){
        guard let url = URL(string: urlString) else { return }

        image = UIImage(named: "placeholder")

        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }

        URLSession.shared.dataTask(with: url) {
            data, response, error in

            guard let data = data else { return }

            DispatchQueue.main.async {
                if let imageToCache = UIImage(data: data) {
                    imageCache.setObject(imageToCache, forKey: urlString as AnyObject)
                    self.image = imageToCache
                }
            }
        }.resume()
    }
}
