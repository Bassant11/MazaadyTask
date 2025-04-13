////
////  EndPoint.swift
////  Testaty
////
////  Created by Hesham Donia on 18/09/2022.
////
//
//import Foundation
//
//public enum HTTPMethodType: String {
//    case get     = "GET"
//    case head    = "HEAD"
//    case post    = "POST"
//    case put     = "PUT"
//    case patch   = "PATCH"
//    case delete  = "DELETE"
//}
//
//public enum BodyEncoding {
//    case jsonSerializationData
//    case stringEncodingAscii
//}
//
//public class Endpoint : Requestable{
//    
//    public let path: String
//    public let isFullPath: Bool
//    public let method: HTTPMethodType
//    public let headerParamaters: [String: String]
//    public let queryParametersEncodable: Encodable?
//    public let queryParameters: [String: Any]
//    public let bodyParamatersEncodable: Encodable?
//    public let bodyParamaters: [String: Any]
//    public let bodyEncoding: BodyEncoding
//    public let responseDecoder: ResponseDecoder
//    public var fullURL : String = ""
//    
//    init(path: String,
//         isFullPath: Bool = false,
//         method: HTTPMethodType,
//         headerParamaters: [String: String] = [:],
//         queryParametersEncodable: Encodable? = nil,
//         queryParameters: [String: Any] = [:],
//         bodyParamatersEncodable: Encodable? = nil,
//         bodyParamaters: [String: Any] = [:],
//         bodyEncoding: BodyEncoding = .jsonSerializationData,
//         responseDecoder: ResponseDecoder = JSONResponseDecoder()) {
//        self.path = path
//        self.isFullPath = isFullPath
//        self.method = method
//        self.headerParamaters = headerParamaters
//        self.queryParametersEncodable = queryParametersEncodable
//        self.queryParameters = queryParameters
//        self.bodyParamatersEncodable = bodyParamatersEncodable
//        self.bodyParamaters = bodyParamaters
//        self.bodyEncoding = bodyEncoding
//        self.responseDecoder = responseDecoder
//    }
//}
//
//public protocol Requestable {
//    var path: String { get }
//    var isFullPath: Bool { get }
//    var method: HTTPMethodType { get }
//    var headerParamaters: [String: String] { get }
//    var queryParametersEncodable: Encodable? { get }
//    var queryParameters: [String: Any] { get }
//    var bodyParamatersEncodable: Encodable? { get }
//    var bodyParamaters: [String: Any] { get }
//    var bodyEncoding: BodyEncoding { get }
//  
//    func urlRequest(with networkConfig: ApiDataNetworkConfig) throws -> (URLRequest , [String: Any])
//}
//
//public protocol ResponseRequestable: Requestable {
//    associatedtype Response
//
//    var responseDecoder: ResponseDecoder { get }
//}
//
//enum RequestGenerationError: Error {
//    case components
//}
//
//extension Requestable {
//    
//    func url(with config: ApiDataNetworkConfig) throws -> URL {
//
//        let baseURL = config.baseURL.absoluteString.last != "/" ? config.baseURL.absoluteString + "/" : config.baseURL.absoluteString
//        let endpoint = isFullPath ? path : baseURL.appending(path)
//      
//        guard var urlComponents = URLComponents(string: endpoint) else { throw RequestGenerationError.components }
//        var urlQueryItems = [URLQueryItem]()
//
//        let queryParameters = try queryParametersEncodable?.toDictionary() ?? self.queryParameters
//        queryParameters.forEach {
//            
//            
//            if $0.value is String {
//                if let stringValue = $0.value as? String {
//                    if stringValue.count > 0 {
//                        urlQueryItems.append(URLQueryItem(name: $0.key, value: "\($0.value)"))
//
//                    }
//                }
//            } else {
//                
//                urlQueryItems.append(URLQueryItem(name: $0.key, value: "\($0.value)"))
//                
//            }
//        }
//        urlComponents.queryItems = !urlQueryItems.isEmpty ? urlQueryItems : nil
//        guard let url = urlComponents.url else { throw RequestGenerationError.components }
//        return url
//    }
//    
//    public func urlRequest(with config: ApiDataNetworkConfig) throws -> (URLRequest , [String : Any]) {
//        
//        let url = try self.url(with: config)
//        var urlRequest = URLRequest(url: url)
//        var allHeaders: [String: String] = config.headers
//        headerParamaters.forEach { allHeaders.updateValue($1, forKey: $0) }
//       
//        let bodyParamaters = try bodyParamatersEncodable?.toDictionary() ?? self.bodyParamaters
//        if !bodyParamaters.isEmpty {
//            urlRequest.httpBody = encodeBody(bodyParamaters: bodyParamaters, bodyEncoding: bodyEncoding)
//            
//        }
//        urlRequest.httpMethod = method.rawValue
//        urlRequest.allHTTPHeaderFields = allHeaders
//        
//        
//       
//        return (urlRequest,bodyParamaters)
//    }
//    
//    public func paymentUrlRequest(token:String,with config: ApiDataNetworkConfig) throws -> (URLRequest , [String : Any]) {
//        
//        let url = try self.url(with: config)
//        var urlRequest = URLRequest(url: url)
//        var allHeaders: [String: String] = config.paymentHeaders
//        allHeaders["Authorization"] = "Bearer \(token)"
//        headerParamaters.forEach { allHeaders.updateValue($1, forKey: $0) }
//        
//        let bodyParamaters = try bodyParamatersEncodable?.toDictionary() ?? self.bodyParamaters
//        if !bodyParamaters.isEmpty {
//            urlRequest.httpBody = encodeBody(bodyParamaters: bodyParamaters, bodyEncoding: bodyEncoding)
//            
//        }
//        urlRequest.httpMethod = method.rawValue
//        urlRequest.allHTTPHeaderFields = allHeaders
//        
//        
//       
//        return (urlRequest,bodyParamaters)
//    }
//    public func paymentTokenRequest(with config: ApiDataNetworkConfig) throws -> (URLRequest , [String : Any]) {
//        
//        let url = try self.url(with: config)
//        var urlRequest = URLRequest(url: url)
//        var allHeaders: [String: String] = config.paymentTokenHeaders
//        headerParamaters.forEach { allHeaders.updateValue($1, forKey: $0) }
//       
//        let bodyParamaters = try bodyParamatersEncodable?.toDictionary() ?? self.bodyParamaters
//        if !bodyParamaters.isEmpty {
//            urlRequest.httpBody = encodeBody(bodyParamaters: bodyParamaters, bodyEncoding: bodyEncoding)
//            
//        }
//        urlRequest.httpMethod = method.rawValue
//        urlRequest.allHTTPHeaderFields = allHeaders
//        
//        
//       
//        return (urlRequest,bodyParamaters)
//    }
//
//    
//    private func encodeBody(bodyParamaters: [String: Any], bodyEncoding: BodyEncoding) -> Data? {
//        switch bodyEncoding {
//        case .jsonSerializationData:
//            return try? JSONSerialization.data(withJSONObject: bodyParamaters)
//        case .stringEncodingAscii:
//            return bodyParamaters.queryString.data(using: String.Encoding.ascii, allowLossyConversion: true)
//        }
//    }
//}
//
//private extension Dictionary {
//    var queryString: String {
//        return self.map { "\($0.key)=\($0.value)" }
//            .joined(separator: "&")
//            .addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) ?? ""
//    }
//}
//
//private extension Encodable {
//    func toDictionary() throws -> [String: Any]? {
//        let data = try JSONEncoder().encode(self)
//        let josnData = try JSONSerialization.jsonObject(with: data)
//        print("*********")
//        print(josnData as? [String : Any])
//        return josnData as? [String : Any]
//    }
//}
//
//public protocol ResponseDecoder {
//    func decode<T: Decodable>(_ data: Data) throws -> T
//}
//
//// MARK: - Response Decoders
//public class JSONResponseDecoder: ResponseDecoder {
//    private let jsonDecoder = JSONDecoder()
//    public init() { }
//    public func decode<T: Decodable>(_ data: Data) throws -> T {
//        return try jsonDecoder.decode(T.self, from: data)
//    }
//}
