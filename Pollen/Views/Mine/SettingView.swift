//
//  SettingView.swift
//  Pollen
//
//  Created by user on 2020/12/4.
//

import SwiftUI

struct SettingView: View {
    @EnvironmentObject var store: Store
    
    @State var logoutConfirm = false
    var body: some View {
        Form {
            ZStack {
                MineRow(icon: "mine_clean", title: "清理缓存")
                Button(action: {
                    store.dispatch(.clearCache)
                }) {
                    EmptyView()
                }
            }
            
            ZStack {
                MineRow(icon: "mine_logout", title: "退出登录")
                Button(action: {
                    self.logoutConfirm.toggle()
                }) {
                    EmptyView()
                }
            }
        }
        .navigationBarTitle("设置")
        .overlay(Group {
            if store.appState.account.isClearCache {
                ActivityIndicator(style: .large)
            } else {
                EmptyView()
            }
        })
        .alert(isPresented: $logoutConfirm) {
            Alert(
                title: Text("温馨提示"),
                message: Text("是否确定退出当前登录账号？"),
                primaryButton: .default(
                    Text("确定"),
                    action: {
                        store.dispatch(.logout)
                    }
                ),
                secondaryButton: .cancel(
                    Text("取消")
                )
            )
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
