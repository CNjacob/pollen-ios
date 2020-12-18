//
//  LoginRequest.swift
//  Pollen
//
//  Created by user on 2020/11/30.
//

import Foundation
import Combine
import Alamofire

/*
struct LoginRequest: APIRequestType {
    var path: String {
        "users/login"
    }
    
    var method: HTTPMethod {
        .post
    }
    
    var header: HTTPHeaders? {
        HTTPHeaders(
            [
                "Authorization" : Authorization.basic(username: username, password: password).value,
            ]
        )
    }
    
    var parameters: Parameters? {
        nil
    }
        
    var username, password: String
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
}
*/

struct LoginRequest {
    let username: String
    let password: String
    
    var publisher: DataResponsePublisher<String> {
        
        var header:HTTPHeaders = HTTPHeaders()
        header["Content-Type"] = "application/json;charset=UTF-8"
        
        let auth = Authorization.basic(username: "NatanTheChef", password: "qwert").value;
        header["Authorization"] = auth
        
        return AF.request("http://127.0.0.1:8080/users/login", method: .post, headers: header)
            .publishString()
    }
}
