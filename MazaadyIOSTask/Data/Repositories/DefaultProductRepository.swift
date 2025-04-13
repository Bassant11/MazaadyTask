//
//  ProductsRepository.swift
//  MazaadyIOSTask
//
//  Created by Mac on 12/04/2025.
//

import Foundation




class DefaultProductRepository {
    
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
}
    
extension DefaultProductRepository : ProductRepository {
    func getUserInfo(completion: @escaping (Result<UserInfoModel, NetworkError>) -> Void) {
        networkManager.get(.getUserInfo, responseType: UserInfoModel.self) { result in
            switch result {
            case .success(let info):
                completion(.success(info))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getAds(completion: @escaping (Result<[AdsModel], NetworkError>) -> Void) {
        networkManager.get(.getAds, responseType: [AdsModel].self) { result in
            switch result {
            case .success(let ads):
                completion(.success(ads))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getTags(completion: @escaping (Result<[TagsModel], NetworkError>) -> Void) {
        networkManager.get(.getTags, responseType: [TagsModel].self) { result in
            switch result {
            case .success(let tags):
                completion(.success(tags))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
        // Get Products
    func getProducts(completion: @escaping (Result<[Product], NetworkError>) -> Void) {
            networkManager.get(.getProducts, responseType: [Product].self) { result in
                switch result {
                case .success(let products):
                    completion(.success(products))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
}




