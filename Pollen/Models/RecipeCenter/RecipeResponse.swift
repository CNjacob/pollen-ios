//
//  RecipeResponse.swift
//  Pollen
//
//  Created by user on 2020/12/3.
//

import Foundation

struct RecipeResult: Decodable {
    let total: Int
    let num: Int
    let list: [Recipe]
}

struct RecipeResponse: Decodable {
    let status: Int
    let msg: String
    let result: RecipeResult
}
