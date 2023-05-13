//
//  CollectionViewCell.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 29.04.2023.
//

import Foundation
import UIKit

class CollectionViewCell: UICollectionViewCell {
    static let cellId = "CollectionViewCell"
    
    private let city: UILabel = {
        let label = UILabel()
        label.text = "Error message here"
        label.font = UIFont(name: Resources.Font.regular, size: Resources.Font.title1)
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    private let country: UILabel = {
        let label = UILabel()
        label.text = "Error message here"
        label.font = UIFont(name: Resources.Font.regular, size: Resources.Font.title1)
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(city)
        contentView.addSubview(country)
        
        city.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
                .inset(10)
        }
        
        country.snp.makeConstraints { make in
            make.right.top.bottom.equalToSuperview()
                .inset(10)
        }
    }
    
    func configureCell(city: String, country: String) {
        self.city.text = city
        self.country.text = country
    }
}
