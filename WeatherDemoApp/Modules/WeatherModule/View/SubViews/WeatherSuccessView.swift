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
    
    // MARK: - Properties
    private var _event = PublishRelay<WeatherViewEvent>()
    private var _weather: WeatherModelDomain?
    private let disposeBag = DisposeBag()
    private let searchLogo = UIButton()
    private let dateLabel = UILabel()
    private let cityLabel = UILabel()
    private let countryLabel = UILabel()
    private let windStatusLabel = UILabel()
    private let windSpeedLabel = UILabel()
    private let visibilityLabel = UILabel()
    private let visibilityRangeLabel = UILabel()
    private let humidityLabel = UILabel()
    private let humidityValueLabel = UILabel()
    private let airPressureLabel = UILabel()
    private let airPressureValueLabel = UILabel()
    private let fiveDaysView = FiveDaysView()
    private let temperatureView = TemperatureView()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    private func setupUI() {
        setupSearchLogo()
        setupDateLabel()
        setupCityLabel()
        setupCountryLabel()
        setupTemperatureView()
        setupWindStatusLabel()
        setupWindSpeedLabel()
        setupVisibilityLabel()
        setupVisibilityRangeLabel()
        setupHumidityLabel()
        setupHumidityValueLabel()
        setupAirPressureLabel()
        setupAirPressureValueLabel()
        fiveDaysViewSetup()
    }
    
    func renderUI(
        data: WeatherModelDomain,
        date: String,
        weekWeather: [WeekModelDomain]
    ) {
        _weather = data
        setData(date: date, weekWeather: weekWeather)
    }
    
    // MARK: - Config data
    private func setData(date: String, weekWeather: [WeekModelDomain]) {
        
        guard let weather = _weather else { return }
        dateLabel.text = date
        cityLabel.text = weather.name
        countryLabel.text = weather.country
        temperatureView.configView(imageURL: "https://openweathermap.org/img/wn/\(weather.icon).png",
                                   temperature: "\(Int(weather.temperature))°C")
        temperatureView.layer.cornerRadius = self.temperatureView.bounds.width / 2
        windSpeedLabel.text = String(weather.windspeed)
        visibilityRangeLabel.text = String(weather.visibility)
        humidityValueLabel.text = String(weather.humidity)
        airPressureValueLabel.text = String(weather.pressure)
        fiveDaysView.configureView(data: weekWeather)
    }
}

// MARK: - Config elements and constraints
extension WeatherSuccessView {
    
    private func setupSearchLogo() {
        addSubview(searchLogo)
        
        searchLogo.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchLogo.tintColor = .black
        searchLogo.rx.tap
            .bind { [weak self] in
                self?._event.accept(.search)
            }
            .disposed(by: disposeBag)
        searchLogo.contentEdgeInsets = UIEdgeInsets(top: 25,
                                                    left: 0,
                                                    bottom: 25,
                                                    right: 0)
        
        searchLogo.snp.makeConstraints { make in
            make.top.right.equalToSuperview().inset(30)
        }
    }
    
    private func setupDateLabel() {
        addSubview(dateLabel)
        
        dateLabel.font = UIFont(name: Resources.Font.regular, size: Resources.Font.regular3)
        dateLabel.textColor = .white
        dateLabel.text = "Today, May 7th, 2021"
        
        dateLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
                .offset(10)
        }
    }

    private func setupCityLabel() {
        addSubview(cityLabel)
        
        cityLabel.font = UIFont(name: Resources.Font.bold, size: Resources.Font.title3)
        cityLabel.textColor = .white
        cityLabel.text = "Barcelona"
        
        cityLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(dateLabel.snp.bottom)
        }
    }

    private func setupCountryLabel() {
        addSubview(countryLabel)
        
        countryLabel.font = UIFont(name: Resources.Font.regular, size: Resources.Font.title1)
        countryLabel.textColor = .white
        countryLabel.text = "Spain"
        
        countryLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(cityLabel.snp.bottom)
        }
    }

    private func setupTemperatureView() {
        addSubview(temperatureView)
        
        temperatureView.snp.makeConstraints { make in
            make.top.equalTo(countryLabel.snp.bottom)
                .offset(Resources.Constraints.temperatureViewTop)
            make.left.right.equalToSuperview()
                .inset(Resources.Constraints.temperatureViewLeft)
            make.height.equalTo(temperatureView.snp.width)
        }
    }
    
    private func setupWindStatusLabel() {
        addSubview(windStatusLabel)
        
        windStatusLabel.font = UIFont(name: Resources.Font.bold, size: Resources.Font.regular3)
        windStatusLabel.textAlignment = .center
        windStatusLabel.textColor = .white
        windStatusLabel.text = "Wind status"
        
        windStatusLabel.snp.makeConstraints { make in
            make.top.equalTo(temperatureView.snp.bottom).offset(Resources.Constraints.attTitleTop)
            make.left.equalToSuperview()
            make.right.equalTo(snp.centerX)
        }
    }

    private func setupWindSpeedLabel() {
        addSubview(windSpeedLabel)
        
        windSpeedLabel.font = UIFont(name: Resources.Font.regular, size: Resources.Font.title1)
        windSpeedLabel.textColor = .white
        windSpeedLabel.text = "7 mph"
        
        windSpeedLabel.snp.makeConstraints { make in
            make.top.equalTo(windStatusLabel.snp.bottom).offset(Resources.Constraints.attValueTop)
            make.centerX.equalTo(windStatusLabel.snp.centerX)
        }
    }

    private func setupVisibilityLabel() {
        addSubview(visibilityLabel)
        
        visibilityLabel.font = UIFont(name: Resources.Font.regular, size: Resources.Font.regular3)
        visibilityLabel.textColor = .white
        visibilityLabel.text = "Visibility"
        visibilityLabel.textAlignment = .center
        
        visibilityLabel.snp.makeConstraints { make in
            make.top.equalTo(temperatureView.snp.bottom).offset(Resources.Constraints.attTitleTop)
            make.right.equalToSuperview()
            make.left.equalTo(snp.centerX)
        }
    }

    private func setupVisibilityRangeLabel() {
        addSubview(visibilityRangeLabel)
        
        visibilityRangeLabel.font = UIFont(name: Resources.Font.regular, size: Resources.Font.title1)
        visibilityRangeLabel.textColor = .white
        visibilityRangeLabel.text = "6.4 miles"
        
        visibilityRangeLabel.snp.makeConstraints { make in
            make.top.equalTo(visibilityLabel.snp.bottom).offset(Resources.Constraints.attValueTop)
            make.centerX.equalTo(visibilityLabel.snp.centerX)
        }
    }
    
    private func setupHumidityLabel() {
        addSubview(humidityLabel)
        
        humidityLabel.font = UIFont(name: Resources.Font.regular, size: Resources.Font.regular3)
        humidityLabel.textColor = .white
        humidityLabel.text = "Humidity"
        
        humidityLabel.snp.makeConstraints { make in
            make.centerX.equalTo(windStatusLabel.snp.centerX)
            make.top.equalTo(windSpeedLabel.snp.bottom).offset(20)
        }
    }

    private func setupHumidityValueLabel() {
        addSubview(humidityValueLabel)
        
        humidityValueLabel.font = UIFont(name: Resources.Font.regular, size: Resources.Font.title1)
        humidityValueLabel.textColor = .white
        humidityValueLabel.text = "85%"
        
        humidityValueLabel.snp.makeConstraints { make in
            make.top.equalTo(humidityLabel.snp.bottom).offset(Resources.Constraints.attValueTop)
            make.centerX.equalTo(humidityLabel.snp.centerX)
        }
    }

    private func setupAirPressureLabel() {
        addSubview(airPressureLabel)
        
        airPressureLabel.font = UIFont(name: Resources.Font.regular, size: Resources.Font.regular3)
        airPressureLabel.textColor = .white
        airPressureLabel.text = "Air pressure"
        
        airPressureLabel.snp.makeConstraints { make in
            make.centerX.equalTo(visibilityLabel.snp.centerX)
            make.top.equalTo(visibilityRangeLabel.snp.bottom).offset(20)
        }
    }

    private func setupAirPressureValueLabel() {
        addSubview(airPressureValueLabel)
        
        airPressureValueLabel.font = UIFont(name: Resources.Font.regular, size: Resources.Font.title1)
        airPressureValueLabel.textColor = .white
        airPressureValueLabel.text = "998 mb"
        
        airPressureValueLabel.snp.makeConstraints { make in
            make.top.equalTo(airPressureLabel.snp.bottom).offset(Resources.Constraints.attValueTop)
            make.centerX.equalTo(airPressureLabel.snp.centerX)
        }
    }
    
    private func fiveDaysViewSetup() {
        addSubview(fiveDaysView)
        
        fiveDaysView.snp.makeConstraints { make in
            make.top.equalTo(humidityValueLabel.snp.bottom)
                .offset(50)
            make.bottom.left.right.equalToSuperview()
        }
    }
}

// MARK: - Event handling
extension WeatherSuccessView {
    
    enum WeatherViewEvent {
        case search
    }
    
    var event: Observable<WeatherViewEvent> {
        _event.asObservable()
    }
}
