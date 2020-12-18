//
//  Separator.swift
//  HuaFanDay
//
//  Created by user on 2020/11/16.
//  Copyright © 2020 XiaoHua. All rights reserved.
//

import SwiftUI

struct Separator: View {
    let color: Color
    
    var body: some View {
        Divider()
            .overlay(color)
            .padding(.zero)
    }
    
    init(color: Color = Color("separator")) {
        self.color = color
    }
}

struct Separator_Previews: PreviewProvider {
    static var previews: some View {
        Separator()
    }
}
