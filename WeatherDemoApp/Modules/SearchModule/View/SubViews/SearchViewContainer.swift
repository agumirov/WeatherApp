//
//  SearchViewContainer.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 02.05.2023.
//

import Foundation
import UIKit
import RxSwift

class SearchViewContainer: UIView {
    
    private let loadedView = SearchLoadedView()
    
    private let errorView = SearchErrorView()
    
    private let loadingView = LoadingScreen()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    private func setupUI() {
        addSubview(loadedView)
        addSubview(errorView)
        addSubview(loadingView)
        
        loadedView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        loadingView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        errorView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
   
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func render(state: SearchViewController.State) {
        switch state {
        case .initial:
            errorView.isHidden = true
            loadingView.isHidden = true
            loadedView.isHidden = false
            loadedView.render(cities: [])
        case .loading:
            errorView.isHidden = true
            loadingView.isHidden = false
            loadedView.isHidden = true
        case .failure:
            errorView.isHidden = false
            loadingView.isHidden = true
            loadedView.isHidden = true
        case let .loaded(cities):
            errorView.isHidden = true
            loadingView.isHidden = true
            loadedView.isHidden = false
            loadedView.render(cities: cities)
        }
    }
}

extension SearchViewContainer {
    
    enum Event {
        case citySelected(city: GeoModelDomain)
        case showCityList(value: String)
        case cancelSearch
    }
    
    var event: Observable<Event> {
        Observable.merge(
            loadedView.event
                .map({ event in
                    switch event {
                    case let .citySelected(city):
                        return .citySelected(city: city)
                    case let .searchDidChange(text):
                        return .showCityList(value: text)
                    case .cancelSearch:
                        return .cancelSearch
                    }
                }),
            
            errorView.event
                .map({ event in
                    switch event {
                    case .retry:
                        return .showCityList(value: "")
                    }
                })
        )
    }
}
