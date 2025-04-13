//
//  ErrorHandling.swift
//  MazaadyIOSTask
//
//  Created by Mac on 12/04/2025.
//

import Foundation

enum APIEndpoint {

    case getUserInfo
    case getProducts
    case getAds
    case getTags

    var path: String {
        switch self {
        case .getUserInfo:
            return "/user"
        case .getProducts:
            return "/products"
        case .getAds:
            return "/advertisements"
        case .getTags:
            return "/tags"
        }
    }
}

