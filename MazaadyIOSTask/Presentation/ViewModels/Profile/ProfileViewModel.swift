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
        let error: BehaviorRelay<NetworkError?> = BehaviorRelay(value: nil)

    
    init(useCase: ProductsUseCase) {
            self.useCase = useCase
        }
        
        func loadProducts() {
            isLoading.accept(true)
            useCase.execute()
                .observe(on: MainScheduler.instance)
                .subscribe(onNext: { [weak self] result in
                    self?.isLoading.accept(false)
                    switch result {
                    case .success(let products):
                        self?.products.accept(products)
                        self?.error.accept(nil)
                    case .failure(let networkError):
                        self?.isLoading.accept(false)
                        self?.error.accept(networkError)
                    }
                }, onError: { [weak self] error in
                    self?.error.accept(error as? NetworkError)
                })
                .disposed(by: disposeBag)
        }
    }
    
