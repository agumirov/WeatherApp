//
//  UIViewController + Extension.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 28.04.2023.
//

import Foundation
import UIKit

extension UIView {
    public func addSubViews(_ subViews: UIView...) {
        subViews.forEach { addSubview($0) }
    }
}
