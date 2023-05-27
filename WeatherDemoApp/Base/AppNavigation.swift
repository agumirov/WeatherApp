//
//  FlowNavigation.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 25.04.2023.
//

import Foundation
import UIKit

class AppNavigation: UINavigationController {
    
    var coordinator: AppCoordinator?
    private var isFlowStarted = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !isFlowStarted {
            isFlowStarted = true
            coordinator?.start()
        }
    }
}
