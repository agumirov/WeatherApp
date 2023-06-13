//
//  MainViewContainer.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 02.05.2023.
//

import Foundation
import UIKit
import RxSwift

class WeatherViewContainer: UIView {
    
    // MARK: - Properties
    private let successView = WeatherSuccessView()
    private let errorView = WeatherErrorView()
    private let loadingView = LoadingScreen()
    private let disposeBag = DisposeBag()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    // MARK: - Methods
    private func setupUI() {
        
        addSubview(errorView)
        addSubview(loadingView)
        addSubview(successView)
        
        successView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        loadingView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        errorView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Events and States handling
extension WeatherViewContainer {
    
    enum Event {
        case searchSelected
    }
    
    enum WeatherState {
        case initial
        case loading
        case success(weatherModel: WeatherModelDomain,
                     date: String,
                     weekWeather: [WeekModelDomain])
        case error
    }
    
    var event: Observable<Event> {
        Observable.merge(
            successView.event
                .asObservable()
                .map { event in
                    switch event {
                    case .search:
                        return .searchSelected
                    }
                },
            
            errorView.event
                .asObservable()
                .map({ event in
                    switch event {
                    case .retrySearch:
                        return .searchSelected
                    }
                })
        )
    }
    
    func render(state: WeatherState) {
        switch state {
        case .initial:
            errorView.isHidden = true
            loadingView.isHidden = true
            successView.isHidden = false
        case .loading:
            errorView.isHidden = true
            loadingView.isHidden = false
            successView.isHidden = true
        case let .success(data, date, weekWeather):
            errorView.isHidden = true
            loadingView.isHidden = true
            successView.isHidden = false
            successView.renderUI(data: data,
                                 date: date,
                                 weekWeather: weekWeather)
        case .error:
            errorView.isHidden = false
            loadingView.isHidden = true
            successView.isHidden = true
        }
    }
}
