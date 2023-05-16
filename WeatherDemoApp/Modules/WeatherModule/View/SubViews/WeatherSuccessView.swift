//
//  ViewController.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 25.04.2023.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class WeatherSuccessView: UIView {
    
    private var _event = PublishRelay<WeatherViewEvent>()
    
    private var _weather: WeatherModelDomain?
    
    private let searchLogo: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private let temperatureView = TemperatureView()
    
    private let fiveDaysView = FiveDaysView()
    
    private let dateLabel = CustomLabel(font: Resources.Font.regular,
                                        size: Resources.Font.regular3,
                                        text: "Today, May 7th, 2021", color: .white)
    
    private let city = CustomLabel(font: Resources.Font.bold,
                                   size: Resources.Font.title3,
                                   text: "Barcelona", color: .white)
    
    private let country = CustomLabel(font: Resources.Font.regular,
                                      size: Resources.Font.title1,
                                      text: "Spain", color: .white)
    
    private let windStatus = CustomLabel(font: Resources.Font.bold,
                                         size: Resources.Font.regular3,
                                         text: "Wind status", color: .white)
    
    private let windSpeed = CustomLabel(font: Resources.Font.regular,
                                        size: Resources.Font.title1,
                                        text: "7 mph", color: .white)
    
    private let visibility = CustomLabel(font: Resources.Font.regular,
                                         size: Resources.Font.regular3,
                                         text: "Visibility", color: .white)
    
    private let visibilityRange = CustomLabel(font: Resources.Font.regular,
                                              size: Resources.Font.title1,
                                              text: "6.4 miles", color: .white)
    
    private let humidity = CustomLabel(font: Resources.Font.regular,
                                       size: Resources.Font.regular3,
                                       text: "Humidity", color: .white)
    
    private let humidityValue = CustomLabel(font: Resources.Font.regular,
                                            size: Resources.Font.title1,
                                            text: "85%", color: .white)
    
    private let airPressure = CustomLabel(font: Resources.Font.regular,
                                          size: Resources.Font.regular3,
                                          text: "Air pressure", color: .white)
    
    private let airPressureValue = CustomLabel(font: Resources.Font.regular,
                                               size: Resources.Font.title1,
                                               text: "998 mb", color: .white)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubViews(subViews: [
            searchLogo, dateLabel, city,
            country, temperatureView, windStatus,
            windSpeed, visibility, visibilityRange,
            humidity, humidityValue, airPressure,
            airPressureValue, fiveDaysView
        ])
        
        searchLogo.addTarget(self, action: #selector(searchCity), for: .touchUpInside)
        searchLogo.snp.makeConstraints { make in
            make.top.right.equalToSuperview()
                .inset(30)
            make.size.equalTo(75)
        }
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .medium
        
        dateLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
                .offset(10)
        }
        
        city.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(dateLabel.snp.bottom)
        }
        
        country.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(city.snp.bottom)
        }
        
        temperatureView.snp.makeConstraints { make in
            make.top.equalTo(country.snp.bottom)
                .offset(Resources.Constraints.temperatureViewTop)
            make.left.right.equalToSuperview()
                .inset(Resources.Constraints.temperatureViewLeft)
            make.height.equalTo(temperatureView.snp.width)
        }
        
        windStatus.snp.makeConstraints { make in
            make.top.equalTo(temperatureView.snp.bottom)
                .offset(Resources.Constraints.attTitleTop)
            make.left.equalToSuperview()
            make.right.equalTo(snp.centerX)
        }
        
        windSpeed.snp.makeConstraints { make in
            make.top.equalTo(windStatus.snp.bottom)
                .offset(Resources.Constraints.attValueTop)
            make.centerX.equalTo(windStatus.snp.centerX)
        }
        
        visibility.snp.makeConstraints { make in
            make.top.equalTo(temperatureView.snp.bottom)
                .offset(Resources.Constraints.attTitleTop)
            make.right.equalToSuperview()
            make.left.equalTo(snp.centerX)
        }
        
        visibilityRange.snp.makeConstraints { make in
            make.top.equalTo(visibility.snp.bottom)
                .offset(Resources.Constraints.attValueTop)
            make.centerX.equalTo(visibility.snp.centerX)
        }
        
        humidity.snp.makeConstraints { make in
            make.centerX.equalTo(windStatus.snp.centerX)
            make.top.equalTo(windSpeed.snp.bottom).offset(20)
        }
        
        humidityValue.snp.makeConstraints { make in
            make.top.equalTo(humidity.snp.bottom)
                .offset(Resources.Constraints.attValueTop)
            make.centerX.equalTo(humidity.snp.centerX)
        }
        
        airPressure.snp.makeConstraints { make in
            make.centerX.equalTo(visibility.snp.centerX)
            make.top.equalTo(visibilityRange.snp.bottom).offset(20)
        }
        
        airPressureValue.snp.makeConstraints { make in
            make.top.equalTo(airPressure.snp.bottom)
                .offset(Resources.Constraints.attValueTop)
            make.centerX.equalTo(airPressure.snp.centerX)
        }
        
        fiveDaysView.snp.makeConstraints { make in
            make.top.equalTo(humidityValue.snp.bottom)
                .offset(30)
            make.bottom.left.right.equalToSuperview()
        }
    }
   
    
    @objc private func searchCity() {
        _event.accept(.search)
    }
    
    func renderUI(data: WeatherModelDomain) {
        _weather = data
        setData()
    }
    
    private func setData() {
        
        guard let weather = _weather else { return }
        
        dateLabel.text = weather.date
        
        city.text = weather.name
        
        country.text = weather.country
        
        temperatureView.configView(
            imageURL: "https://openweathermap.org/img/wn/\(weather.icon).png",
            temperature: "\(Int(weather.temperature))°C"
        )
        temperatureView.layer.cornerRadius = self.temperatureView.bounds.width / 2
        
        windSpeed.text = String(weather.windspeed)
        
        visibilityRange.text = String(weather.visibility)
        
        humidityValue.text = String(weather.humidity)
        
        airPressureValue.text = String(weather.pressure)
        
        fiveDaysView.configureView(data: weather.list)
    }
}

extension WeatherSuccessView {
    
    enum WeatherViewEvent {
        case search
    }
    
    var event: Observable<WeatherViewEvent> {
        _event.asObservable()
    }
}
