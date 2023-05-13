//
//  FlowCoordinator.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 25.04.2023.
//

import Foundation

protocol Coordinator: AnyObject {
    func start()
    func delete()
}

class AppCoordinator<N: Navigation>: Coordinator {
    func delete() {}
    
    weak var navigationController: N?
    
    init(navigationController: N) {
        self.navigationController = navigationController
        navigationController.coordinator = self
    }
    
    func start() {}
}
