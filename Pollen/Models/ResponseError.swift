//
//  ResponseError.swift
//  Pollen
//
//  Created by user on 2020/11/30.
//

import Foundation

struct ResponseError: Decodable {
    let error: Bool
    let reason: String
}
