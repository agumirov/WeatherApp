//
//  UIImageView + Extension.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 30.04.2023.
//

import Foundation
import UIKit

extension UIImageView {
    
    private func imageCache(urlString: String, image: UIImage) {
        ImageCache.shared.setObject(image, forKey: urlString as NSString)
    }
    
    func loadImage(from urlString: String) {
        
        if let cachedImage = ImageCache.shared.object(forKey: urlString as NSString) {
            self.image = cachedImage
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        let queue = DispatchQueue.global()
        
        var image: UIImage?
        
        let workItem = DispatchWorkItem {
            guard let data = try? Data(contentsOf: url) else { return }
            image = UIImage(data: data)
        }
        
        queue.async(execute: workItem)
        
        workItem.notify(queue: .main, execute: { [ weak self] in
            self?.imageCache(urlString: urlString, image: image ?? UIImage())
            self?.image = image
        })
    }
}
