


import Foundation

enum APIEndpoint {

    case getUserInfo
    case getProducts
    case getAds
    case getTags

    var path: String {
        switch self {
        case .getUserInfo:
            return "/products"
        case .getProducts:
            return "/products"
        case .getAds:
            return ""
        case .getTags:
            return ""
        }
    }
}

