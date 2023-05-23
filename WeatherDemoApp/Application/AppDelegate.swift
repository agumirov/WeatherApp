//
//  AppDelegate.swift
//  WeatherDemoApp
//
//  Created by G G on 14.05.2023.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: Properties
    var window: UIWindow?
    private var flowFactory: FlowFactory!
    private var networkService: NetworkService!
    private var weatherStorageManager: WeatherStorageManager!
    
    // MARK: App lifecycle
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        registerDependencies()
        getWindowSize()
        transformerRegistration()
        startAppFlow()
        
        return true
    }
    
    private func registerDependencies() {
        flowFactory = FlowFactoryImplementation()
        networkService = NetworkServiceImplementation()
        weatherStorageManager = WeatherStorageManagerImpl()
        
        DIContainer.standart.register(flowFactory!)
        DIContainer.standart.register(networkService!)
        DIContainer.standart.register(weatherStorageManager!)
    }
    
    private func startAppFlow() {
        let view = flowFactory.startMainFlow()
        window?.rootViewController = view
    }
    
    private func getWindowSize() {
        guard let windowScene = window?.windowScene else { return }
        
        Resources.screenWidth = windowScene.screen.bounds.width
        Resources.screenHeight = windowScene.screen.bounds.height
    }
    
    private func transformerRegistration() {
        ValueTransformer.setValueTransformer(WeekModelTransformer(), forName: NSValueTransformerName(rawValue: "WeekModelDomainValueTransformer"))
    }
}
