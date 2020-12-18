//
//  Mine.swift
//  HuaFanDay
//
//  Created by user on 2020/11/3.
//  Copyright © 2020 XiaoHua. All rights reserved.
//

import SwiftUI

struct Mine: View {
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    ZStack {
                        MineRow(icon: "mine_favorites", title: "我的收藏")
                        NavigationLink(destination: FavoritedRecipeView()) {
                            EmptyView()
                        }
                    }
                }
                
                Section {
                    ZStack {
                        MineRow(icon: "mine_help", title: "帮助与反馈")
                        NavigationLink(destination: HelpView()) {
                            EmptyView()
                        }
                    }
                    
                    ZStack {
                        MineRow(icon: "mine_setting", title: "设置")
                        NavigationLink(destination: SettingView()) {
                            EmptyView()
                        }
                    }
                }
            }
            .navigationBarTitle("个人中心", displayMode: .large)
        }
    }
}

struct Mine_Previews: PreviewProvider {
    static var previews: some View {
        Mine()
    }
}
