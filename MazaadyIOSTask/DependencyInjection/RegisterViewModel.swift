//
//  RegisterViewModel.swift
//  MazaadyIOSTask
//
//  Created by Mac on 12/04/2025.
//
import Swinject
import SwinjectAutoregistration

extension Container {
    
    func registerViewModels() {
        autoregister(ProfileViewModel.self, initializer: ProfileViewModel.init)
    }
}
