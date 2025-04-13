//
//  RegisterRepositories.swift
//  MazaadyIOSTask
//
//  Created by Mac on 12/04/2025.
//
import Swinject


import SwinjectAutoregistration

extension Container {
    
    func registerRepositories() {
        autoregister(NetworkManager.self, initializer: NetworkManager.init)
        autoregister(ProductRepository.self, initializer: DefaultProductRepository.init)
    }
}



extension Container {
    func registerDependencies() {
        registerViewModels()
        registerRepositories()
        registerUseCases()
    }
}
