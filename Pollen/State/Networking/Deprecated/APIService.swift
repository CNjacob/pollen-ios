//
//  APIService.swift
//  Pollen
//
//  Created by user on 2020/11/30.
//

import Foundation
import Alamofire

protocol APIRequestType {
    var path: String { get }
    var method: HTTPMethod { get }
    var header: HTTPHeaders? { get }
    var parameters: Parameters? { get }
}

protocol APIServiceType {
    func response<Request>(from request: Request) -> DataResponsePublisher<String> where Request: APIRequestType
}

final class APIService: APIServiceType {
    private let baseURL: URL
    init(baseURL: URL = URL(string: "http://127.0.0.1:8080/")!) {
        self.baseURL = baseURL
    }
    
    func response<Request>(from request: Request) -> DataResponsePublisher<String> where Request: APIRequestType {
        let pathURL = URL(string: request.path, relativeTo: baseURL)!
        
        return AF
            .request(
                pathURL,
                method: request.method,
                parameters: request.parameters,
                encoding:  URLEncoding.init(destination: .httpBody, arrayEncoding: .noBrackets, boolEncoding: .literal),
                headers: request.header
            )
            .publishString()
    }
}
