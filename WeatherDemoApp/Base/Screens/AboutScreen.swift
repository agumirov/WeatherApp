//
//  AboutScreen.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 29.04.2023.
//

import Foundation
import UIKit

class AboutScreen: UIViewController {
    
    let loaderView = LoadingView()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        navigationController?.isNavigationBarHidden = true
        
        view.addSubview(loaderView)
        showLoadingView()
    }
    
    private func showLoadingView() {
        let loader = LoadingView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.addSubview(loader)
        loader.center = view.center
        var opacityValue = 1.0
        var isVisible = true
        
        let timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
            
            if isVisible {
                opacityValue -= 1 / 100
            } else {
                opacityValue += 1 / 100
            }
            
            if opacityValue <= 0 {
                isVisible = false
            }
            
            if opacityValue >= 1 {
                isVisible = true
            }
            
            loader.alpha = opacityValue
        }
//
//        let worker = DispatchWorkItem {
//            self.viewModel?.viewAskedForTransition()
//        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            timer.invalidate()
            self.startTransition(loader: loader)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {})
//            worker.notify(queue: .main, execute: {
//                loader.removeFromSuperview()
//            })
        })
    }
    
    private func startTransition(loader: LoadingView) {
        loader.alpha = 1.0
        UIView.animate(withDuration: 1, delay: 0) {
            loader.frame = CGRect(x: 0, y: 0, width: 1000, height: 1000)
            loader.center = self.view.center
        }
    }
}
