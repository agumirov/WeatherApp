//
//  GeoRepositoryImpl.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 11.05.2023.
//

import Foundation

class GeoRepositoryImpl: GeoRepository {
    
    // MARK: - Properties
    private let networkService: NetworkService
    
    // MARK: - Init
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    // MARK: - Methods
    func getGeoData(cityName: String) async throws -> [GeoModelDomain] {
        let apiModelArray = try await networkService.getGeoData(cityName: cityName)
        let domainModelArray = apiModelArray.map { apiModel in
            GeoModelDomain(from: apiModel)
        }
        return domainModelArray
    }
}
