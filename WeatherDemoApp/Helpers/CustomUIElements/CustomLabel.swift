//
//  CustomButton.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 26.04.2023.
//

import Foundation
import UIKit

class CustomLabel: UILabel {
    
    init(font: String, size: Double, text: String, color: UIColor) {
        super.init(frame: CGRect())
        
        self.text = text
        self.font = UIFont(name: font, size: size)
        self.textAlignment = .center
        textColor = color
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
