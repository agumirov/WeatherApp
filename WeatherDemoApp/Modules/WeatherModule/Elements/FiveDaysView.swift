//
//  FiveDaysView.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 27.04.2023.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa

class FiveDaysView: UIView {
    
    private lazy var weatherList: [WeekModelDomain] = []
    
    private let fiveDaysLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(
            name: Resources.Font.bold,
            size: Resources.Font.regular3
        )
        label.textAlignment = .center
        label.textColor = .black
        label.text = "The Next 5 days"
        return label
    }()
    
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
       
    private let disposeBag = DisposeBag()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 5
        stack.distribution = .fillEqually
        stack.alignment = .fill
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setupViews()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let rect = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: UIRectCorner(arrayLiteral: .topRight, .topLeft),
            cornerRadii: CGSize(
                width: Resources.Constraints.fiveDaysRadius,
                height: Resources.Constraints.fiveDaysRadius
            )
        )
        
        UIColor.white.set()
        path.fill()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(stackView)
        addSubview(fiveDaysLabel)
        
        stackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
                .inset(15)
        }
        
        fiveDaysLabel.snp.makeConstraints { make in
            make.bottom.equalTo(stackView.snp.top)
                .inset(-26)
            make.left.equalTo(stackView.snp.left)
        }
    }
    
    private func updateUI(with weatherList: [WeekModelDomain]) {
        for day in weatherList {
            let weekDayView = WeekDayView()
            weekDayView.configView(
                weatherImage: day.weatherImage,
                day: day.day,
                temperature: day.temperature
            )
            
            stackView.addArrangedSubview(weekDayView)
            
            weekDayView.snp.makeConstraints { make in
                make.height.equalTo(weekDayView.snp.width)
            }
        }
    }

    func configureView(data: [WeekModelDomain]) {
        updateUI(with: data)
    }
}
