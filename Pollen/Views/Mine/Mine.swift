//
//  Mine.swift
//  HuaFanDay
//
//  Created by user on 2020/11/3.
//  Copyright © 2020 XiaoHua. All rights reserved.
//

import SwiftUI

struct Mine: View {
    @EnvironmentObject var store: Store
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    ZStack {
                        if store.appState.account.loggedIn {
                            MineRow(icon: "mine_favorites", title: "我的收藏")
                            NavigationLink(destination: FavoritedRecipeView()) {
                                EmptyView()
                            }
                            
                        } else {
                            ZStack {
                                MineRow(icon: "mine_login", title: "登录")
                                Button(action: {
                                    store.dispatch(.showLoginView)
                                }) {
                                    EmptyView()
                                }
                            }
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
                        MineRow(icon: "mine_privacy_policy", title: "隐私政策")
                        NavigationLink(destination: PrivacyPolicyView()) {
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
