//
//  ProductsUseCae.swift
//  MazaadyIOSTask
//
//  Created by Mac on 12/04/2025.
//

import RxSwift

protocol ProductsUseCase
{
    func execute() -> Observable<Result<[Product],NetworkError>>
    
}

class DefaultProductUseCase: ProductsUseCase {
    private let repository: ProductRepository
    
    init(repository: ProductRepository) {
        self.repository = repository
    }
    
    func execute() -> Observable<Result<[Product], NetworkError>> {
        return Observable.create { observer in
            self.repository.getProducts { result in
                switch result {
                case .success(let products):
                    observer.onNext(.success(products))  // Success: pass the products
                    observer.onCompleted()  // Complete the observer
                case .failure(let error):
                    observer.onNext(.failure(error))  // Failure: pass the error
                    observer.onCompleted()  // Complete the observer
                }
            }
            
            return Disposables.create()
        }
    }
}
