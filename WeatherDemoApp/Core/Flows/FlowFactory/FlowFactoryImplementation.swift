//
//  FlowFactoryImplementation.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 25.04.2023.
//

import Foundation
import UIKit

class FlowFactoryImplementation: FlowFactory {
    
    func startMainFlow() -> (UIViewController) {
        
        let navigationController = MainFlowNavigation()
        
        _ = MainFlowCoordinator(
            navigationController: navigationController)
        
        return navigationController
    }
}
