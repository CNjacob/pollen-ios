//
//  HelpView.swift
//  Pollen
//
//  Created by user on 2020/12/4.
//

import SwiftUI

struct HelpView: View {
    @EnvironmentObject var store: Store
    
    var body: some View {
        VStack {
            
            TextEditor(text: $store.appState.account.helpString)
                .foregroundColor(Color("textColor"))
                .font(.system(size: 15, weight: .regular, design: .default))
                .lineSpacing(8)
                .frame(height: (UIScreen.main.bounds.width * 300) / 414, alignment: .center)
                .padding(.leading, (UIScreen.main.bounds.width * 16) / 414)
                .padding(.trailing, (UIScreen.main.bounds.width * 16) / 414)
            
            ColorButton(btnText: "发送", textColor: Color("textColor"), backgroundColor: Color("lightblueColor")) {
                store.dispatch(.clearCache)
            }
        }
        .navigationBarTitle("帮助中心")
        .overlay(Group {
            if store.appState.account.isClearCache {
                ActivityIndicator(style: .large)
            } else {
                EmptyView()
            }
        })
    }
}

struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        HelpView()
    }
}
