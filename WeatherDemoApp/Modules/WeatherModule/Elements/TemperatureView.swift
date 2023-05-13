//
//  TemperatureView.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 26.04.2023.
//

import Foundation
import UIKit

class TemperatureView: UIView {
    
    private let cloudImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(
            name: Resources.Font.thin,
            size: Resources.Font.title4
        )
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setupViews()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let cornerRadius = min(bounds.height, bounds.width)
        let path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        
        UIColor.white.set()
        path.fill()
    }
    
    private func setupViews() {
        
        addSubViews(subViews: [
            cloudImage, temperatureLabel
        ])
        
        
        cloudImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.height.equalTo(Resources.Constraints.cloudImageSide)
            make.top.equalToSuperview()
        }
        
        temperatureLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configView(
        imageURL: String,
        temperature: String
    ) {
        self.cloudImage.loadImage(from: imageURL)
        self.temperatureLabel.text = temperature
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
