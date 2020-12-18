//
//  RecipeListView.swift
//  Pollen
//
//  Created by user on 2020/12/2.
//

import SwiftUI

struct RecipeListView: View {
    @EnvironmentObject var store: Store
    private var recipeState: AppState.RecipeState {
        store.appState.recipe
    }
    private var recipeStateBinding: Binding<AppState.RecipeState> {
        $store.appState.recipe
    }
    
    var body: some View {
        List {
            /*
            if recipeState.recipeClass.count > 0 {
                RefreshHeader(refreshing: recipeStateBinding.headerRefreshing, action: loadRecipe) { progress in
                    if recipeState.headerRefreshing {
                        RefreshingView()
                    } else {
                        PullToRefreshView(progress: progress)
                    }
                }
            }*/
            
            ForEach(recipeState.recipeData, id: \.self) { recipe in
                ZStack {
                    RecipeCell(recipe: recipe)
                    NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                        EmptyView()
                    }
                }
            }
            
            if recipeState.recipeClass.count > 0 {
                RefreshFooter(refreshing: recipeStateBinding.footerRefreshing, action: loadMoreRecipe) {
                    if recipeState.noMoreRecipe {
                        Text("没有更多数据了 !")
                            .font(.system(size: 15, weight: .bold, design: .default))
                            .foregroundColor(.secondary)
                            .padding()
                    } else {
                        RefreshingView()
                            .padding()
                    }
                }
                .noMore(recipeState.noMoreRecipe)
                .preload(offset: 50)
            }
        }
        .enableRefresh()
        .listSeparatorStyle(style: .none)
        .padding(.leading, -16)
        .padding(.trailing, -16)
        .listStyle(PlainListStyle())
        .onAppear {
            if recipeState.recipeData.count == 0 {
                loadRecipe()
            }
        }
    }
    
    func loadRecipe() {
        guard !recipeState.isLoadingRecipe else {
            return
        }
                
        store.dispatch(.reloadRecipe(classId: recipeState.currentSubClassId))
    }
    
    func loadMoreRecipe() {
        guard !recipeState.isLoadingRecipe else {
            return
        }
        
        store.dispatch(.loadMoreRecipe(classId: recipeState.currentSubClassId))
    }
}

struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView()
    }
}
