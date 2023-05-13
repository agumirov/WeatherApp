//
//  SearchErrorView.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 05.05.2023.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

class SearchErrorView: UIView {
    
    private var _event = PublishRelay<ErrorEvent>()
    
    let errorMessage: UILabel = {
        let label = UILabel()
        label.text = "Error message here"
        label.font = UIFont(
            name: Resources.Font.regular,
            size: Resources.Font.title3
        )
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupGradient()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupGradient() {
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [
            UIColor(hexString: "#30A2C5").cgColor,
            UIColor(hexString: "#000000").cgColor
        ]
        layer.insertSublayer(gradient, at: 0)
    }
    
    private func setupUI() {
        addSubview(errorMessage)
        
        errorMessage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension SearchErrorView {
    
    enum ErrorEvent {
        case retry
    }
    
    var event: Observable<ErrorEvent> {
        _event.asObservable()
    }
}
