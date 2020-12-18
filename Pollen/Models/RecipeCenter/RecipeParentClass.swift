//
//  RecipeParentClass.swift
//  Pollen
//
//  Created by user on 2020/12/1.
//

import Foundation

struct RecipeParentClass: Hashable, Codable {
    var classid: Int
    var name: String
    var list: [RecipeSubClass]
}
