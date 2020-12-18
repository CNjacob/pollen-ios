//
//  MainTab.swift
//  Pollen
//
//  Created by user on 2020/11/26.
//

import SwiftUI

struct MainTab: View {
    @EnvironmentObject var store: Store
    
    var body: some View {
        TabView(selection: $store.appState.mainTab.selection) {
            
            HomePage().tabItem {
                TabItem(type: .home, selection: store.appState.mainTab.selection)
            }.tag(AppState.MainTabState.Index.home)
            
            RecipeCenter().tabItem {
                TabItem(type: .recipe, selection: store.appState.mainTab.selection)
            }.tag(AppState.MainTabState.Index.recipe)
            
//            MomentView().tabItem {
//                TabItem(type: .moment, selection: store.appState.mainTab.selection)
//            }.tag(AppState.MainTabState.Index.moment)
            
            Mine().tabItem {
                TabItem(type: .mine, selection: store.appState.mainTab.selection)
            }.tag(AppState.MainTabState.Index.mine)
        }
        .edgesIgnoringSafeArea(.top)
        .onAppear(perform: loadUserFavoritedRecipe)
    }
    
    func loadUserFavoritedRecipe() {
        let token = store.appState.account.accessToken
        store.dispatch(.loadFavoritedRecipe(token: token))
    }
}

struct TabItem: View {
    let type: AppState.MainTabState.Index
    let selection: AppState.MainTabState.Index
    
    var body: some View {
        VStack {
            if type == selection {
                type.selectedImage
            } else {
                type.image
            }
            
            Text(type.title)
        }
    }
}

struct MainTab_Previews: PreviewProvider {
    static var previews: some View {
        MainTab()
    }
}
