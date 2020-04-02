//
//  AyncImageView.swift
//  Gojek Demo
//
//  Created by Amol Prakash on 02/04/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import UIKit

var imageCache = NSCache<NSString, UIImage>()
class AyncImageView: UIImageView {
    private var currentURL: String?
    
    func loadAsyncFrom(urlString: String?, placeholder: UIImage) {
        guard let urlString = urlString else {
            self.image = placeholder
            return
        }
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            self.image = cachedImage
            return
        }
        self.image = placeholder
        self.currentURL = urlString
        guard let requestURL = URL(string: urlString) else {
            self.image = placeholder
            return
        }
        
        URLSession.shared.dataTask(with: requestURL) { (data, response, error) in
            DispatchQueue.main.async { [weak self] in
                guard error == nil,
                    self?.currentURL == urlString,
                    let imageData = data,
                    let imageToPresent = UIImage(data: imageData) else {
                        self?.image = placeholder
                        return
                }
                self?.image = imageToPresent
                imageCache.setObject(imageToPresent, forKey: urlString as NSString)
            }
        }.resume()
    }
}
