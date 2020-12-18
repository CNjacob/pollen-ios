//
//  Authorization.swift
//  Pollen
//
//  Created by user on 2020/11/23.
//

import Foundation

public enum AuthorizationType: String {
    case basic = "Basic"
    case bearer = "Bearer"
}

public struct Authorization {
    public let type: AuthorizationType
    public let key: String
    public var value: String {
        get {
            return "\(type.rawValue) \(key)"
        }
    }
    
    public init(type: AuthorizationType, key: String) {
        self.type = type
        self.key = key
    }
}

extension Authorization {
    public static func basic(username: String, password: String) -> Authorization {
        return Authorization(type: .basic, key: Data("\(username):\(password)".utf8).base64EncodedString())
    }
    
    public static func bearer(_ token: String) -> Authorization {
        return Authorization(type: .bearer, key: token)
    }
}
