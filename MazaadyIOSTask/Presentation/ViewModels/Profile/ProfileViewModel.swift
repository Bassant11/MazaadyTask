//
//  ProfileViewModel.swift
//  MazaadyIOSTask
//
//  Created by Mac on 12/04/2025.
//

import Foundation
import RxSwift
import RxCocoa

class ProfileViewModel {
    
    private let useCase: ProductsUseCase
    private let disposeBag = DisposeBag()
    
    let isLoading = BehaviorRelay<Bool>(value: false)
    let products: BehaviorRelay<[Product]> = BehaviorRelay(value: [])
    let userInfo: BehaviorRelay<UserInfoModel> = BehaviorRelay(value: UserInfoModel(id: 1, name: "", image: "", userName: "", followingCount: 0, followersCount: 0, countryName: "", cityName: ""))
    let tags: BehaviorRelay<[TagModel]> = BehaviorRelay(value: [])
    let Ads: BehaviorRelay<[AdsModel]> = BehaviorRelay(value: [])
    let error: BehaviorRelay<NetworkError?> = BehaviorRelay(value: nil)
    let searchText = BehaviorRelay<String>(value: "")
    var filteredProducts: Observable<[Product]> {
        return Observable.combineLatest(products.asObservable(), searchText.asObservable())
            .map { products, query in
                guard !query.isEmpty else { return products }
                return products.filter { $0.name.lowercased().contains(query.lowercased()) }
            }
    }

        
        init(useCase: ProductsUseCase) {
            self.useCase = useCase
        }
        
        func loadAllData(forceRefresh: Bool = false) {
            let dispatchGroup = DispatchGroup()
            isLoading.accept(true)
            
            dispatchGroup.enter()
            loadProducts(dispatchGroup: dispatchGroup, forceRefresh: forceRefresh)
            
            dispatchGroup.enter()
            loadUserInfo(dispatchGroup: dispatchGroup, forceRefresh: forceRefresh)
            
            dispatchGroup.enter()
            loadAds(dispatchGroup: dispatchGroup, forceRefresh: forceRefresh)
            
            dispatchGroup.enter()
            loadTags(dispatchGroup: dispatchGroup, forceRefresh: forceRefresh)
            
            dispatchGroup.notify(queue: .main) { [weak self] in
                self?.isLoading.accept(false)
                print("All data has been loaded.")
            }
        }
        
        func loadProducts(dispatchGroup: DispatchGroup, forceRefresh: Bool) {
            useCase.execute(forceRefresh: forceRefresh)
                .observe(on: MainScheduler.instance)
                .subscribe(onNext: { [weak self] result in
                    switch result {
                    case .success(let products):
                        self?.products.accept(products)
                        self?.error.accept(nil)
                    case .failure(let networkError):
                        self?.error.accept(networkError)
                    }
                    dispatchGroup.leave()
                }, onError: { [weak self] error in
                    self?.error.accept(error as? NetworkError)
                    dispatchGroup.leave()
                })
                .disposed(by: disposeBag)
        }
        
        func loadUserInfo(dispatchGroup: DispatchGroup, forceRefresh: Bool) {
            useCase.executeUserInfo(forceRefresh: forceRefresh)
                .observe(on: MainScheduler.instance)
                .subscribe(onNext: { [weak self] result in
                    switch result {
                    case .success(let info):
                        self?.userInfo.accept(info)
                        self?.error.accept(nil)
                    case .failure(let networkError):
                        self?.error.accept(networkError)
                    }
                    dispatchGroup.leave()
                }, onError: { [weak self] error in
                    self?.error.accept(error as? NetworkError)
                    dispatchGroup.leave()
                })
                .disposed(by: disposeBag)
        }
        
        func loadAds(dispatchGroup: DispatchGroup, forceRefresh: Bool) {
            useCase.executeAds(forceRefresh: forceRefresh)
                .observe(on: MainScheduler.instance)
                .subscribe(onNext: { [weak self] result in
                    switch result {
                    case .success(let adsResponse):
                        self?.Ads.accept(adsResponse.advertisements)
                        self?.error.accept(nil)
                    case .failure(let networkError):
                        self?.error.accept(networkError)
                    }
                    dispatchGroup.leave()
                }, onError: { [weak self] error in
                    self?.error.accept(error as? NetworkError)
                    dispatchGroup.leave()
                })
                .disposed(by: disposeBag)
        }
        
        func loadTags(dispatchGroup: DispatchGroup, forceRefresh: Bool) {
            useCase.executeTags(forceRefresh: forceRefresh)
                .observe(on: MainScheduler.instance)
                .subscribe(onNext: { [weak self] result in
                    switch result {
                    case .success(let tagsResponse):
                        self?.tags.accept(tagsResponse.tags)
                        self?.error.accept(nil)
                    case .failure(let networkError):
                        self?.error.accept(networkError)
                    }
                    dispatchGroup.leave()
                }, onError: { [weak self] error in
                    self?.error.accept(error as? NetworkError)
                    dispatchGroup.leave()
                })
                .disposed(by: disposeBag)
        }
    
    }
