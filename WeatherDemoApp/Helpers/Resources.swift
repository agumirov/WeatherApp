//
//  Constaints.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 25.04.2023.
//

import Foundation

enum Resources {
    static var screenWidth: CGFloat = 0.0
    static var screenHeight: CGFloat = 0.0
    
    private static let layoutWidth = 414.0
    private static let layoutHeight = 896.0
    
    private static let proportionWidth = screenWidth / layoutWidth
    private static let proportionHeight = screenHeight / layoutHeight
    
    private enum ScreenSide {
        case width
        case height
    }
    
    enum Constraints {
        
        static let searchLogoSize = getSize(side: .height, size: 30)
        static let searchLogoRight = getSize(side: .width, size: 25)
        
        static let dateTop = getSize(side: .height, size: 86)
        
        static let cloudImageSide = getSize(side: .height, size: 75)
        
        static let temperatureViewTop = getSize(side: .height, size: 18)
        static let temperatureViewLeft = getSize(side: .width, size: 85)
        
        static let attTitleTop = getSize(side: .height, size: 31)
        
        static let attValueTop = getSize(side: .height, size: 8)
        
        static let weekDayRadius = getSize(side: .height, size: 20)
        static let weekDaySide = getSize(side: .height, size: 75)
        
        static let fiveDaysRadius = getSize(side: .height, size: 60)
        
        static let searchViewRadius = getSize(side: .height, size: 60)
    }
    
    enum Font {
        
        static let title4 = getSize(side: .height, size: 100)
        static let title3 = getSize(side: .height, size: 40)
        static let title2 = getSize(side: .height, size: 24)
        static let title1 = getSize(side: .height, size: 20)
        
        static let regular3 = getSize(side: .height, size: 14)
        static let regular2 = getSize(side: .height, size: 12)
        static let regular1 = getSize(side: .height, size: 10)
        
        static let regular = "Asap-Medium"
        static let bold = "Asap-Bold"
        static let thin = "Asap-Thin"
    }
}

extension Resources {
    private static func getSize(side: ScreenSide, size: Double) -> CGFloat {
        switch side {
        case .height:
            return size * proportionHeight
        case .width:
            return size * proportionWidth
        }
    }
}
