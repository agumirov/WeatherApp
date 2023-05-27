//
//  WeekDayView.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 27.04.2023.
//

import Foundation
import UIKit

class WeekDayView: UIView {
    // MARK: - Properties
    private let dayLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(
            name: Resources.Font.regular,
            size: Resources.Font.regular1
        )
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(
            name: Resources.Font.regular,
            size: Resources.Font.regular1
        )
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    private let weatherImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let squareView = UIView()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.borderColor = UIColor.systemGray6.cgColor
        layer.borderWidth = 2
        layer.cornerRadius = Resources.Constraints.weekDayRadius
        backgroundColor = .red
        backgroundColor = .clear
        setupViews()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let rect = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
        let path = UIBezierPath(roundedRect: rect, cornerRadius: Resources.Constraints.weekDayRadius)
        
        UIColor.systemGray4.set()
        path.fill()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    private func setupViews() {
        addSubViews(subViews: [
            weatherImage, temperatureLabel, dayLabel
        ])
        
        dayLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
                .offset(-15)
            make.horizontalEdges.equalToSuperview()
        }
        
        weatherImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(13)
            make.size.equalTo(30)
        }
        
        temperatureLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(weatherImage.snp.bottom).offset(6)
        }
    }
    
    func configView(
        weatherImage: String,
        day: String,
        temperature: String
    ) {
        self.weatherImage.loadImage(from: weatherImage)
        self.dayLabel.text = day
        self.temperatureLabel.text = temperature
    }
}
