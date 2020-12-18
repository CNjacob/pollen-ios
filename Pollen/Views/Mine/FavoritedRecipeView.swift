//
//  FavoritedRecipeView.swift
//  Pollen
//
//  Created by user on 2020/12/4.
//

import SwiftUI

struct FavoritedRecipeView: View {
    @EnvironmentObject var store: Store
    
    private var accountState: AppState.AccountState {
        store.appState.account
    }
    
    var body: some View {
        List {
            ForEach(accountState.favoritedRecipe, id: \.self) { favoritedRecipe in
                ZStack {
                    let recipe = Recipe.create(withFavoritedRecipe: favoritedRecipe)
                    RecipeCell(recipe: recipe)
                    NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                        EmptyView()
                    }
                }
            }
        }
        .navigationBarTitle("我的收藏")
    }
}

struct FavoritedRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritedRecipeView()
    }
}
