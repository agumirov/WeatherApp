//
//  ImageCache.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 30.04.2023.
//

import Foundation
import UIKit

enum ImageCache {
    static let shared = NSCache<NSString, UIImage>()
}
