//
//  FlowNavigation.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 25.04.2023.
//

import Foundation
import UIKit

protocol Navigation: AnyObject {
    var coordinator: Coordinator? { get set }
}

class AppNavigation: UINavigationController, Navigation {
    
    var coordinator: Coordinator?
    
    private var isFlowStarted = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !isFlowStarted {
            isFlowStarted = true
            coordinator?.start()
        }
    }
}
