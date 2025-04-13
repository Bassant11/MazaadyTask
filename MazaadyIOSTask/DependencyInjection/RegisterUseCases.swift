//
//  RegisterUseCases.swift
//  MazaadyIOSTask
//
//  Created by Mac on 12/04/2025.
//

import Swinject
import SwinjectAutoregistration

extension Container {
    
    func registerUseCases() {
        autoregister(ProductsUseCase.self, initializer: DefaultProductUseCase.init)
    }
}
