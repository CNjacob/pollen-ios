//
//  RecipeCommand.swift
//  Pollen
//
//  Created by user on 2020/12/3.
//

import Foundation
import Alamofire

struct LoadRecipeClassCommand: AppCommand {
    let filename: String
    
    func execute(in store: Store) {
        if store.appState.recipe.recipeClass.isEmpty {
            store.appState.recipe.recipeClass = load(filename)
            store.appState.recipe.currentParentClassId = store.appState.recipe.recipeClass.first!.classid
            store.appState.recipe.currentSubClassId = (store.appState.recipe.currentParentClass?.list.first!.classid)!
        }
    }
}

struct LoadRecipeDataCommand: AppCommand {
    let filename: String
    
    func execute(in store: Store) {
        if store.appState.home.featuredRecipe.isEmpty {
            store.appState.home.featuredRecipe = load(filename)
        }
    }
}

struct ReloadRecipeCommand: AppCommand {
    let classId: Int
    
    func execute(in store: Store) {
        let token = SubscriptionToken()
        
        AF.request(APIRouter.getRecipeByClass(classid: classId, start: 0, pageSize: store.appState.recipe.pageSize)).publishString()
            .sink(receiveCompletion: { complete in
                if case .failure(let error) = complete {
                    print(error.localizedDescription)
                    print("网络异常，请检查您的网络！")
                }
                store.appState.recipe.isLoadingRecipe = false
                token.unseal()
            }, receiveValue: { receive in
                guard let receiveData = receive.data else {
                    print("服务器异常，请稍后重试！")
                    return
                }
                
                let decode = JSONDecoder()
                do {
                    let response = try decode.decode(RecipeResponse.self, from: receiveData)
                    guard response.status == 0 else {
                        print(response.msg)
                        return
                    }
                    
                    store.appState.recipe.offset = response.result.num
                    print("reload recipe count: \(store.appState.recipe.offset)")
                    store.appState.recipe.recipeData.removeAll()
                    store.appState.recipe.recipeData.append(contentsOf: response.result.list)
                    if response.result.num < store.appState.recipe.pageSize {
                        store.appState.recipe.noMoreRecipe = true
                    }
                } catch {
                    
                }
            })
            .seal(in: token)
    }
}

struct LoadMoreRecipeCommand: AppCommand {
    let classId: Int
    
    func execute(in store: Store) {
        let token = SubscriptionToken()
        
        AF.request(APIRouter.getRecipeByClass(classid: classId, start: store.appState.recipe.offset, pageSize: store.appState.recipe.pageSize)).publishString()
            .sink(receiveCompletion: { complete in
                if case .failure(let error) = complete {
                    print(error.localizedDescription)
                    print("网络异常，请检查您的网络！")
                }
                store.appState.recipe.isLoadingRecipe = false
                store.appState.recipe.footerRefreshing = false
                token.unseal()
            }, receiveValue: { receive in
                guard let receiveData = receive.data else {
                    print("服务器异常，请稍后重试！")
                    return
                }
                
                let decode = JSONDecoder()
                do {
                    let response = try decode.decode(RecipeResponse.self, from: receiveData)
                    guard response.status == 0 else {
                        print(response.msg)
                        return
                    }
                    
                    store.appState.recipe.offset += response.result.num
                    print("load more recipe count: \(store.appState.recipe.offset)")
                    store.appState.recipe.recipeData.append(contentsOf: response.result.list)
                    if response.result.num < store.appState.recipe.pageSize {
                        store.appState.recipe.noMoreRecipe = true
                    }
                } catch {
                    
                }
            })
            .seal(in: token)
    }
}

struct FavoritedRecipeCommand: AppCommand {
    let token: String
    let recipe: Recipe
    
    func execute(in store: Store) {
        let subscriptionToken = SubscriptionToken()
        let favoritedRecipe = FavoritedRecipe.create(withRecipe: recipe)
        AF.request(APIRouter.recipeIsExists(recipe: favoritedRecipe)).publishString()
            .sink(receiveCompletion: { complete in
                if case .failure(let error) = complete {
                    print(error.localizedDescription)
                }
                subscriptionToken.unseal()
                
            }, receiveValue: { receive in
                guard let receiveData = receive.data else {
                    return
                }
                let decode = JSONDecoder()
                do {
                    
                    let recipeExists = try decode.decode(RecipeExists.self, from: receiveData)
                    if recipeExists.isExists == 1 {
                        // favorited
                        favorited(store)
                        
                    } else {
                        createRecipe(store, recipe: favoritedRecipe)
                    }
                    
                } catch {
                    let error = try! decode.decode(ResponseError.self, from: receiveData)
                    print(error)
                }
            })
            .seal(in: subscriptionToken)
    }
    
    func createRecipe(_ store: Store, recipe: FavoritedRecipe) {
        let subscriptionToken = SubscriptionToken()
        AF.request(APIRouter.createRecipe(recipe: recipe)).publishString()
            .sink(receiveCompletion: { complete in
                if case .failure(let error) = complete {
                    print(error.localizedDescription)
                }
                subscriptionToken.unseal()
                
            }, receiveValue: { receive in
                guard let receiveData = receive.data else {
                    return
                }
                let decode = JSONDecoder()
                do {
                    let favoritedRecipe = try decode.decode(FavoritedRecipe.self, from: receiveData)
                    print(favoritedRecipe)
                    
                    // favorited
                    favorited(store)
                    
                } catch {
                    let error = try! decode.decode(ResponseError.self, from: receiveData)
                    print(error)
                }
            })
            .seal(in: subscriptionToken)
    }
    
    func favorited(_ store: Store) {
        let subscriptionToken = SubscriptionToken()
        AF.request(APIRouter.favoritedRecipe(token: token, recipeId: recipe.id)).publishString()
            .sink(receiveCompletion: { complete in
                if case .failure(let error) = complete {
                    print(error.localizedDescription)
                }
                subscriptionToken.unseal()
                
            }, receiveValue: { receive in
                guard let receiveData = receive.data else {
                    return
                }
                let
                    decode = JSONDecoder()
                do {
                    let favoritedRecipes = try decode.decode([FavoritedRecipe].self, from: receiveData)
                    store.appState.account.favoritedRecipe = favoritedRecipes
                } catch {
                    let error = try! decode.decode(ResponseError.self, from: receiveData)
                    print(error)
                }
            })
            .seal(in: subscriptionToken)
    }
}

struct CancelFavoritedRecipeCommand: AppCommand {
    let token: String
    let recipe: Recipe
    
    func execute(in store: Store) {
        let subscriptionToken = SubscriptionToken()
        AF.request(APIRouter.cancelFavoritedRecipe(token: token, recipeId: recipe.id)).publishString()
            .sink(receiveCompletion: { complete in
                if case .failure(let error) = complete {
                    print(error.localizedDescription)
                }
                subscriptionToken.unseal()
                
            }, receiveValue: { receive in
                guard let receiveData = receive.data else {
                    return
                }
                let
                    decode = JSONDecoder()
                do {
                    let favoritedRecipes = try decode.decode([FavoritedRecipe].self, from: receiveData)
                    store.appState.account.favoritedRecipe = favoritedRecipes
                } catch {
                    let error = try! decode.decode(ResponseError.self, from: receiveData)
                    print(error)
                }
            })
            .seal(in: subscriptionToken)
    }
}
