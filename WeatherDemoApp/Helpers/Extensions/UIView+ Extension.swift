//
//  UIViewController + Extension.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 28.04.2023.
//

import Foundation
import UIKit

extension UIView {
    public func addSubViews(subViews: [UIView]) {
        for view in subViews {
            addSubview(view)
        }
    }
}
