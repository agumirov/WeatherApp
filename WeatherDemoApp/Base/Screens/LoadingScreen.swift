//
//  LoadingScreen.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 28.04.2023.
//

import Foundation
import UIKit

class LoadingScreen: UIView {
    let loaderView = LoadingView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        
        addSubview(loaderView)
        showLoadingView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func showLoadingView() {
        let loader = LoadingView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        addSubview(loader)
        loader.center = center
        var opacityValue = 1.0
        var isVisible = true
        
        _ = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
            
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
    }
}

class LoadingView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let cornerRadius = min(bounds.height, bounds.width)
        let path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        
        UIColor.red.set()
        path.fill()
    }
}
