//
//  SceneDelegate.swift
//  WeatherDemoApp
//
//  Created by G G on 14.05.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let factory: FlowFactory = DIContainer.standart.resolve()
        let view = factory.startMainFlow()
        
        Resources.screenWidth = windowScene.screen.bounds.width
        Resources.screenHeight = windowScene.screen.bounds.height
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = view
        window?.makeKeyAndVisible()
    }
}
