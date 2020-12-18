//
//  Helpers.swift
//  Pollen
//
//  Created by user on 2020/11/30.
//

import Foundation

let appDecoder: JSONDecoder = {
    let decoder = JSONDecoder()
//    decoder.keyDecodingStrategy = .convertFromSnakeCase
    return decoder
}()

let appEncoder: JSONEncoder = {
    let encoder = JSONEncoder()
//    encoder.keyEncodingStrategy = .convertToSnakeCase
    return encoder
}()
