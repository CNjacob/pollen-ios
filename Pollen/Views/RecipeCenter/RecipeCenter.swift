//
//  RecipeCenter.swift
//  HuaFanDay
//
//  Created by user on 2020/11/3.
//  Copyright © 2020 XiaoHua. All rights reserved.
//

import SwiftUI
import Refresh

struct RecipeCenter: View {
    @EnvironmentObject var store: Store
    private var recipeState: AppState.RecipeState {
        store.appState.recipe
    }
    private var recipeStateBinding: Binding<AppState.RecipeState> {
        $store.appState.recipe
    }
    
    var filterButton: some View {
        Button(action: {
            store.dispatch(.showRecipeClassFilterView)
        }) {
            Image("recipe_filter")
                .accessibility(label: Text("筛选"))
                .padding()
        }
    }
    
    var body: some View {
        NavigationView {
            RecipeListView()
                .navigationBarTitle("美食坊", displayMode: .large)
                .navigationBarItems(trailing: filterButton/*FilterMenu()*/)
                .sheet(isPresented: recipeStateBinding.showingRecipeClassFilter) {
                    FilterView().environmentObject(store)
                }
        }
        .overlay(Group {
            if recipeState.recipeData.count == 0 || recipeState.isLoadingRecipe {
                ActivityIndicator(style: .large)
            } else {
                EmptyView()
            }
        })
        .onAppear {
            store.dispatch(.loadRecipeClass(filename: "recipeClass.json"))
        }
    }
}

struct RecipeCenter_Previews: PreviewProvider {
    static var previews: some View {
        RecipeCenter()
    }
}
