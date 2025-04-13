//
//  ProductsUseCae.swift
//  MazaadyIOSTask
//
//  Created by Mac on 12/04/2025.
//

import RxSwift

protocol ProductsUseCase
{
    func execute(forceRefresh: Bool) -> Observable<Result<[Product],NetworkError>>
    func executeUserInfo(forceRefresh: Bool) -> Observable<Result<UserInfoModel,NetworkError>>
    func executeAds(forceRefresh: Bool) -> Observable<Result<AdvertisementsResponse,NetworkError>>
    func executeTags(forceRefresh: Bool) -> Observable<Result<TagsResponse,NetworkError>>

    
}

class DefaultProductUseCase: ProductsUseCase {
    
    private let repository: ProductRepository
    private let cacheService: CacheService
    
    init(repository: ProductRepository, cacheService: CacheService) {
        self.repository = repository
        self.cacheService = cacheService
    }
    
    // Products
    func execute(forceRefresh: Bool = false) -> Observable<Result<[Product], NetworkError>> {
        if !forceRefresh, let cachedProducts = cacheService.loadCachedProducts() {
            return Observable.just(.success(cachedProducts))  // Return cached data if not forced refresh
        }
        
        return Observable.create { observer in
            self.repository.getProducts { result in
                switch result {
                case .success(let products):
                    // Cache the fresh products and save the timestamp
                    self.cacheService.saveProductsToCache(products)
                    self.cacheService.saveProductsFetchTime(Date())  // Save the time of fetch
                    observer.onNext(.success(products))  // Success: pass the products
                    observer.onCompleted()
                case .failure(let error):
                    observer.onNext(.failure(error))  // Failure: pass the error
                    observer.onCompleted()
                }
            }
            return Disposables.create()
        }
    }
    
    // User Info
    func executeUserInfo(forceRefresh: Bool = false) -> Observable<Result<UserInfoModel, NetworkError>> {
        if !forceRefresh, let cachedUserInfo = cacheService.loadCachedUserInfo() {
            return Observable.just(.success(cachedUserInfo))  // Return cached data if not forced refresh
        }
        
        return Observable.create { observer in
            self.repository.getUserInfo { result in
                switch result {
                case .success(let info):
                    // Cache the fresh user info and save the timestamp
                    self.cacheService.saveUserInfoToCache(info)
                    self.cacheService.saveUserInfoFetchTime(Date())  // Save the time of fetch
                    observer.onNext(.success(info))
                    observer.onCompleted()
                case .failure(let error):
                    observer.onNext(.failure(error))
                    observer.onCompleted()
                }
            }
            return Disposables.create()
        }
    }
    
    // Ads
    func executeAds(forceRefresh: Bool = false) -> Observable<Result<AdvertisementsResponse, NetworkError>> {
        if !forceRefresh, let cachedAds = cacheService.loadCachedAds() {
            return Observable.just(.success(cachedAds))  // Return cached data if not forced refresh
        }
        
        return Observable.create { observer in
            self.repository.getAds { result in
                switch result {
                case .success(let ads):
                    // Cache the fresh ads and save the timestamp
                    self.cacheService.saveAdsToCache(ads)
                    self.cacheService.saveAdsFetchTime(Date())  // Save the time of fetch
                    observer.onNext(.success(ads))
                    observer.onCompleted()
                case .failure(let error):
                    observer.onNext(.failure(error))
                    observer.onCompleted()
                }
            }
            return Disposables.create()
        }
    }
    
    // Tags
    func executeTags(forceRefresh: Bool = false) -> Observable<Result<TagsResponse, NetworkError>> {
        if !forceRefresh, let cachedTags = cacheService.loadCachedTags() {
            return Observable.just(.success(cachedTags))  // Return cached data if not forced refresh
        }
        
        return Observable.create { observer in
            self.repository.getTags { result in
                switch result {
                case .success(let tags):
                    // Cache the fresh tags and save the timestamp
                    self.cacheService.saveTagsToCache(tags)
                    self.cacheService.saveTagsFetchTime(Date())  // Save the time of fetch
                    observer.onNext(.success(tags))
                    observer.onCompleted()
                case .failure(let error):
                    observer.onNext(.failure(error))
                    observer.onCompleted()
                }
            }
            return Disposables.create()
        }
    }
}
