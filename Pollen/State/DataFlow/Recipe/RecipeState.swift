//
//  RecipeState.swift
//  Pollen
//
//  Created by user on 2020/12/3.
//

import Foundation

extension AppState {
    struct RecipeState {
        var recipeClass: [RecipeParentClass] = []
        var recipeData: [Recipe] = []
        
        // 控制分类筛选显示
        var showingRecipeClassFilter = false
        
        var currentParentClassId = 223
        var currentSubClassId = 225
        var currentParentClass: RecipeParentClass? {
            recipeClass.filter { recipeParentClass in
                recipeParentClass.classid == currentParentClassId
            }
            .first
        }
        var currentSubClass: RecipeSubClass? {
            currentParentClass?.list.filter{ recipeSubClass in
                recipeSubClass.classid == currentSubClassId
            }
            .first
        }
        
        var searchText = ""
        
//        var headerRefreshing = false
        var footerRefreshing = false
        
        var noMoreRecipe = false
        
        var pageSize = 20
        var offset = 0
        
        // 防止重复请求加载数据
        var isLoadingRecipe = false
    }
}
