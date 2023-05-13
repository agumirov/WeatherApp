//
//  UIViewController+Extension.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 02.05.2023.
//

import Foundation
import UIKit

extension UIViewController {
    func addChild(viewController: UIViewController) {
        viewController.willMove(toParent: self)
        view.addSubview(viewController.view)
        addChild(viewController)
        viewController.didMove(toParent: self)
    }
    
    func removeChild(viewController: UIViewController) {
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
        viewController.didMove(toParent: nil)
    }
    
    func removeAllChildViewControllers() {
        children.forEach({ removeChild(viewController: $0) })
    }
    
    func removePreviousChildAndAdd(viewController: UIViewController?) {
        guard let viewController = viewController else {
            return
        }
        
        removeAllChildViewControllers()
        addChild(viewController: viewController)
    }
}
