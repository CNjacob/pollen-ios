//
//  SignUpRequest.swift
//  Pollen
//
//  Created by user on 2020/11/25.
//

import Foundation
import Alamofire

struct SignUpRequest: APIRequestType {
    var path: String {
        "users/signup"
    }
    
    var method: HTTPMethod {
        .post
    }
    
    var header: HTTPHeaders? {
        nil
    }
    
    var parameters: Parameters? {
        [
            "username": username,
            "password": password,
        ]
    }
        
    var username, password: String
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
}
