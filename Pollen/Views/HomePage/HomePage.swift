//
//  HomePage.swift
//  HuaFanDay
//
//  Created by user on 2020/11/3.
//  Copyright © 2020 XiaoHua. All rights reserved.
//

import SwiftUI

struct HomePage: View {
    @EnvironmentObject var store: Store
    
    private var homeState: AppState.HomePageState {
        store.appState.home
    }
    
    var refreshButton: some View {
        Button(action: {
            store.dispatch(.homePageRefresh)
        }) {
            Image("homepage_refresh")
                .accessibility(label: Text("刷新"))
                .padding()
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                Spacer(minLength: 20)
                
                HomePageCell(categoryName: homeState.featuredName, items: homeState.featuredRecipe)
                
                Spacer(minLength: 20)
                
                CardScroll(categoryName: homeState.seasonName, items: homeState.seasonRecipe)
            }
            .navigationBarTitle("精选推荐", displayMode: .large)
            .navigationBarItems(trailing: refreshButton)
        }
        .overlay(Group {
            if homeState.isLoadingFeaturedRecipe || homeState.isLoadingSeasonRecipe {
                ActivityIndicator(style: .large)
            } else {
                EmptyView()
            }
        })
        .onAppear(perform: reloadData)
    }
    
    func reloadData() {
        store.dispatch(.homePageRefresh)
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}

