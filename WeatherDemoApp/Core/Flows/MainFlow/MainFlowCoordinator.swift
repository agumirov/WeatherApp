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
    
    private var _event: CoordinatorEvents? = nil {
        willSet {
            switch newValue {
            case let .pushWeatherScreen(geoData):
                showWeatherScreen(geoData: geoData)
            case .pushSearchScreen:
                showSearchScreen()
            case .none:
                break
            case .popVC:
                navigationController?.popViewController(animated: false)
            }
        }
    }
    
    override init(navigationController: N) {
        super.init(navigationController: navigationController)
    }
    
    override func start() {
        super.start()
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

extension MainFlowCoordinator {
    
    //    func finish
    //    showMainScreen
    func showWeatherScreen(geoData: GeoModelDomain) {
        
        let (view, viewModel) = WeatherModuleBuilder.buildWeatherModule(geoData: geoData)
        
        viewModel.output.event
            .asObservable()
            .subscribe { [weak self] event in
                switch event {
                case .showSearchScreen:
                    self?.showSearchScreen()
                }
            }
            .disposed(by: disposeBag)
        
        navigationController?.viewControllers = [view]
    }
    
    func showSearchScreen() {
        let (view, viewModel) = SearchModuleBuilder.buildSearchModule()
        
        viewModel.output.event
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
        
        navigationController?.pushViewController(view, animated: false)
    }
    
    private func popVC() {
        navigationController?.popViewController(animated: true)
    }
}

extension MainFlowCoordinator {
    
    enum CoordinatorEvents {
        case pushWeatherScreen(geoData: GeoModelDomain)
        case pushSearchScreen
        case popVC
    }
}
