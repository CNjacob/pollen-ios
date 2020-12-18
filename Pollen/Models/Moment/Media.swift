//
//  Media.swift
//  HuaFanDay
//
//  Created by user on 2020/11/16.
//  Copyright © 2020 XiaoHua. All rights reserved.
//

import Foundation

struct Media: Codable, Equatable, Identifiable {
    var id = UUID()
    let cover: String?
    let width: Double?
    let height: Double?
    let url: String
}
