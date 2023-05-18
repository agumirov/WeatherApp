//
//  FlowFactoryImplementation.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 25.04.2023.
//

import Foundation
import UIKit

class FlowFactoryImplementation: FlowFactory {
    
    func startMainFlow(isStoredDataAvailable: Bool) -> (UIViewController) {
        
        let navigationController = MainFlowNavigation()
        
        let mainFlowCoordinator = MainFlowCoordinator(
            navigationController: navigationController)
        mainFlowCoordinator.start(isStoredDataAvailable: isStoredDataAvailable)
        
        return navigationController
    }
}
