//
//  SearchSucessView.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 05.05.2023.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class SearchLoadedView: UIView {
    
    private var cities: [GeoModelDomain] = []
    
    private var _event = PublishRelay<Event>()
    
    private let searchView = SearchView()
    
    private let disposeBag = DisposeBag()
    
    private let searchField: UITextField = {
        let field = UITextField()
        let padding = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.leftView = padding
        field.leftViewMode = .always
        field.placeholder = "Search Location".uppercased()
        field.layer.cornerRadius = 20
        field.backgroundColor = .systemGray4
        return field
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(cancelSearch), for: .touchUpInside)
        return button
    }()
    
    private let collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero,
                                          collectionViewLayout: layout)
        collection.backgroundColor = UIColor.clear
        collection.register(CollectionViewCell.self,
                            forCellWithReuseIdentifier: CollectionViewCell.cellId)
        return collection
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        collectionConfig()
        bindText()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(searchView)
        searchView.addSubview(closeButton)
        searchView.addSubview(searchField)
        searchView.addSubview(collection)
        
        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
                .inset(28)
            make.right.equalToSuperview()
                .inset(23)
        }
        
        searchField.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
                .inset(55)
            make.top.equalTo(closeButton.snp.bottom)
                .inset(12)
            make.height.equalTo(44)
        }
        
        collection.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(searchField.snp.bottom)
                .offset(30)
            make.bottom.equalToSuperview()
        }
        
        searchView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(snp.centerY)
        }
    }
    
    private func collectionConfig() {
        collection.delegate = self
        collection.dataSource = self
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        collection.contentInset = UIEdgeInsets(top: 10, left: 10,
                                               bottom: 0, right: 10)
    }
    
    private func bindText() {
        searchField.rx.text
            .asObservable()
            .subscribe(onNext: {[weak self] text in
                if text == "" { return }
                guard let self = self else { return }
                self._event.accept(.searchDidChange(text: (text ?? "") ))
            })
            .disposed(by: disposeBag)
    }
    
    @objc private func cancelSearch() {
        _event.accept(.cancelSearch)
    }
}

extension SearchLoadedView: UICollectionViewDelegate,
                             UICollectionViewDataSource,
                             UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Items in section. There should be [arrayWithData].count
        cities.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        // put your cell here
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CollectionViewCell.cellId,
            for: indexPath
        ) as? CollectionViewCell
        else { return UICollectionViewCell()}
        cell.configureCell(city: cities[indexPath.row].name, country: cities[indexPath.row].country)
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(width: collectionView.bounds.width - 20, height: 40)
    }
    
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        _event.accept(.citySelected(city: cities[indexPath.row]))
    }
}

extension SearchLoadedView {
    
    enum Event {
        case citySelected(city: GeoModelDomain)
        case searchDidChange(text: String)
        case cancelSearch
    }
    
    var event: Observable<Event> {
        _event.asObservable()
    }
    
    func render(cities: [GeoModelDomain]) {
        self.cities = cities
        collection.reloadData()
    }
}
