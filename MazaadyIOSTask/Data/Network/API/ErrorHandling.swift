//
//  ErrorHandling.swift
//  MazaadyIOSTask
//
//  Created by Mac on 12/04/2025.
//

import Alamofire

enum NetworkError: Error {
    case badURL
    case noData
    case decodingError
    case serverError
    case unauthorized
    case networkFailure(Error)
    
    var localizedDescription: String {
        switch self {
        case .badURL:
            return "Invalid URL"
        case .noData:
            return "No data received from the server."
        case .decodingError:
            return "Failed to decode the response."
        case .serverError:
            return "Server error occurred."
        case .networkFailure(let error):
            return "Network failure: \(error.localizedDescription)"
        case .unauthorized:
            return "Unauthorized request. Please check your credentials."
        }
    }
}
