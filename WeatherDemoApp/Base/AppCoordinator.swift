//
//  FlowCoordinator.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 25.04.2023.
//

import Foundation

class AppCoordinator {
    
    var navigationController: AppNavigation
    
    init(navigationController: AppNavigation) {
        self.navigationController = navigationController
        navigationController.coordinator = self
    }
    
    func start() {}
}
