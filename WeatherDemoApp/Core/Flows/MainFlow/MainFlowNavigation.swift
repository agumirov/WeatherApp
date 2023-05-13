//
//  File.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 28.04.2023.
//

import Foundation
import UIKit

class MainFlowNavigation: AppNavigation {
 
    override func viewDidLoad() {
        super.viewDidLoad()
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        UINavigationBar.appearance().standardAppearance = appearance
        isNavigationBarHidden = false
        // navigation settings
        
        isNavigationBarHidden = true
        isToolbarHidden = true
    }
}
