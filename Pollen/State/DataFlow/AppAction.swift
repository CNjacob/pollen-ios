//
//  AppAction.swift
//  Pollen
//
//  Created by user on 2020/11/25.
//

import Foundation

enum AppAction {
    case loginAccountCheck(isValid: Bool)
    case login(username: String, password: String)
    case checkLoginAccessToken(token: String)
    
    case signupAccountCheck(warningMessage: String)
    case signUp(username: String, password: String)
    case loadFavoritedRecipe(token: String)
    
    case logout
    case clearCache
    
    case loadRecipeClass(filename: String)
    case loadRecipeData(filename: String)
    
    case showRecipeClassFilterView
    case hiddenRecipeClassFilterView
    
    case resetRecipeClassId(parentClassId: Int, subClassId: Int)
    
    case reloadRecipe(classId: Int)
    case loadMoreRecipe(classId: Int)
    
    case favoritedRecipe(token: String, recipe: Recipe)
    case cancelFavoritedRecipe(token: String, recipe: Recipe)
    
    case homePageRefresh
    
    case showLoginView
    case dismissLoginView
}
