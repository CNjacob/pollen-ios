//
//  LoginResponse.swift
//  Pollen
//
//  Created by user on 2020/11/23.
//

import Foundation

struct LoginResponse: Decodable {
    let token: String
    let user: User
}
