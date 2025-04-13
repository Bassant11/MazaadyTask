////
////  NetworkConfig.swift
////  Testaty
////
////  Created by Hesham Donia on 18/09/2022.
////
//
//import Foundation
//import UIKit
//
//let SERVER_NAME = "demo.testaty.com"
//
//public struct ApiDataNetworkConfig {
//    public let baseURL: URL
//    public var headers: [String: String]
//    public var paymentHeaders: [String: String]
//    public var paymentTokenHeaders: [String: String]
//
//    public init() {
//        self.baseURL =  URL(string: "https://\(SERVER_NAME)/api/v1/")! //https://demo.testaty.com/api/v1
//        self.headers = generateHeaders()
//        self.paymentHeaders = generatePaymentHeaders()
//        self.paymentTokenHeaders = generatePaymentTokenHeaders()
//
//    }
//}
//
//func generateHeaders() ->[String:String] {
//    
//    var headers = [String:String]()
//
//    let INPUT_ACCEPT = "Accept"
//    let OUTPUT_ACCESS_TOKEN_HEADER = "Authorization"
//    let CONTENT_TYPE = "Content-Type"
//    
//    headers["X-device-model"] = UIDevice.modelName
//    headers["X-device-version"] = "\(UIDevice.current.systemVersion)"
//    headers["X-application-version"] = "1.0"
//    
//    headers["Accept-Language"] = Localizer.shared.currentLanguage()
//    
//    headers[INPUT_ACCEPT] = "application/json"
////    headers[INPUT_ACCEPT] = "application/vnd.ni-payment.v2+json"
//    if let token = UD.token {
//        headers[OUTPUT_ACCESS_TOKEN_HEADER] = "Bearer \(token)"
//    }
//    if let authToken = UD.authToken {
//        headers["AuthToken"] = authToken
//    }
//    headers[CONTENT_TYPE] = "application/json"
//    return headers
//    
//}
//
//
//func generatePaymentHeaders() ->[String:String] {
//    var headers = [String:String]()
//
//    let INPUT_ACCEPT = "Accept"
//    let OUTPUT_ACCESS_TOKEN_HEADER = "Authorization"
//    let CONTENT_TYPE = "Content-Type"
//        
//    headers[INPUT_ACCEPT] = "application/vnd.ni-payment.v2+json"
////    if let token = UD.paymentToken {
////        headers[OUTPUT_ACCESS_TOKEN_HEADER] = "Bearer \(token)"
////    }
////    if let authToken = UD.authToken {
////        headers["AuthToken"] = authToken
////    }
//    headers[CONTENT_TYPE] = "application/vnd.ni-payment.v2+json"
//    return headers
//}
//func generatePaymentTokenHeaders() ->[String:String] {
//    var headers = [String:String]()
//    let INPUT_ACCEPT = "Accept"
//    let OUTPUT_ACCESS_TOKEN_HEADER = "Authorization"
//    let CONTENT_TYPE = "Content-Type"
//
//
//    headers[OUTPUT_ACCESS_TOKEN_HEADER] = "Basic MGVjZTlhOTktMjE2OS00ZTNjLTlmMDMtNzhjYjc3OWEyNTRkOmYyNWMzMmFlLTEzMGEtNDg5Yy05OGY2LWI5OGQzY2VjYjJkMA=="
//    headers[CONTENT_TYPE] = "application/vnd.ni-identity.v1+json"
//    return headers
//}
//
//public protocol NetworkCancellable {
//    func cancel()
//}
