//
//  MainFlowCoordinator.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 25.04.2023.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa


class MainFlowCoordinator<N>: AppCoordinator<N> where N: MainFlowNavigation {
    
    private let disposeBag = DisposeBag()
    
    override func start() {
        super.start()
        checkStoredData()
    }
}

extension MainFlowCoordinator {
    
    //    func finish
    //    showMainScreen
    func showWeatherScreen(geoData: GeoModelDomain) {
        
        let weatherModule = WeatherModuleBuilder.buildWeatherModule(
            payLoad: .init(geoData: geoData),
            dependencies: .init(networkService: DIContainer.standart.resolve())
        )
        
        weatherModule.output
            .subscribe { [weak self] event in
                switch event {
                case .showSearchScreen:
                    self?.showSearchScreen()
                }
            }
            .disposed(by: disposeBag)
        
        navigationController?.viewControllers = [weatherModule.view]
    }
    
    func showSearchScreen() {
        let searchModule = SearchModuleBuilder.buildSearchModule(
            dependencies: .init(networkService: DIContainer.standart.resolve()),
            payload: .init())
        
        searchModule.output
            .asObservable()
            .subscribe { [weak self] event in
                switch event {
                case let .routeToWeatherModule(geoData):
                    self?.showWeatherScreen(geoData: geoData)
                case .abortSearch:
                    self?.popVC()
                }
            }
            .disposed(by: disposeBag)
        
        navigationController?.pushViewController(searchModule.view, animated: false)
    }
    
    private func popVC() {
        navigationController?.popViewController(animated: false)
    }
}

extension MainFlowCoordinator {
    
    enum CoordinatorEvents {
        case pushWeatherScreen(geoData: GeoModelDomain)
        case pushSearchScreen
        case popVC
    }
    
    private func checkStoredData() {
        
        let storedData = StoreManager.shared.fetchData()
        
        if storedData.isEmpty {
            showSearchScreen()
        } else {
            
            for data in storedData {
                print(data)
            }
            guard let storedData = storedData.last else { return }
            showWeatherScreen(geoData: GeoModelDomain(name: storedData.city ?? "",
                                                      country: storedData.country ?? "",
                                                      latitude: storedData.latitude as! Double,
                                                      longitude: storedData.longitude as! Double))
        }
    }
}
