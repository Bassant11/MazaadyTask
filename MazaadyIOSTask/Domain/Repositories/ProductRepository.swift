//
//  ProductRepository.swift
//  MazaadyIOSTask
//
//  Created by Mac on 12/04/2025.
//


import Foundation

protocol ProductRepository {
    
    func getProducts(completion: @escaping (Result<[Product], NetworkError>) -> Void)
    func getUserInfo(completion: @escaping (Result<UserInfoModel, NetworkError>) -> Void)
    func getAds(completion: @escaping (Result<[AdsModel], NetworkError>) -> Void)
    func getTags(completion: @escaping (Result<[TagsModel], NetworkError>) -> Void)

}
