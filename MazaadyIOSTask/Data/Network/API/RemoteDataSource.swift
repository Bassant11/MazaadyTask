
//
//  ProductsRepository.swift
//  MazaadyIOSTask
//
//  Created by Mac on 12/04/2025.

import Alamofire
import Foundation

class NetworkManager {

    
    private let baseURL = "https://stagingapi.mazaady.com/api/interview-tasks"
        
    // Generic GET request method
    func get<T: Decodable>(_ endpoint: APIEndpoint, responseType: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) {
        let url = baseURL + endpoint.path
        
        AF.request(url, method: .get)
            .validate() // Validate that status code is 200-299
            .responseDecodable(of: T.self) { response in
                print(response.result,"RESPONSE")
                switch response.result {
                case .success(let decodedData):
                    completion(.success(decodedData))
                case .failure(let error):
                    // Handle the error by mapping it to custom NetworkError
                    let networkError = self.mapError(error, response: response.response)
                    completion(.failure(networkError))
                }
            }
    }
    
    // Function to handle POST requests (example for sending data)
    func post<T: Decodable, U: Encodable>(_ endpoint: APIEndpoint, body: U, responseType: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) {
        let url = baseURL + endpoint.path
        
        AF.request(url, method: .post, parameters: body, encoder: JSONParameterEncoder.default)
            .validate()
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let decodedData):
                    completion(.success(decodedData))
                case .failure(let error):
                    // Handle the error by mapping it to custom NetworkError
                    let networkError = self.mapError(error, response: response.response)
                    completion(.failure(networkError))
                }
            }
    }
    
    // Function to map Alamofire error to custom NetworkError
    private func mapError(_ error: AFError, response: HTTPURLResponse?) -> NetworkError {
        // Check for status code errors
        if let statusCode = response?.statusCode {
            switch statusCode {
            case 400:
                return .badURL
            case 401:
                return .unauthorized
            case 500...599:
                return .serverError
            default:
                return .serverError
            }
        }
        
        // Handle other Alamofire errors
        if let underlyingError = error.underlyingError {
            return .networkFailure(underlyingError)
        }
        
        return .noData
    }
}


//// Network Layer
//protocol NetworkManagerProtocol {
//    func get<T: Decodable>(_ endpoint: APIEndpoint, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void)
//    func post<T: Decodable, U: Encodable>(_ endpoint: APIEndpoint, body: U, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void)
//}
