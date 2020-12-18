//
//  HomeCommand.swift
//  Pollen
//
//  Created by user on 2020/12/7.
//

import Foundation
import Alamofire

//case loadFeaturedRecipe
//case loadSeasonRecipe

struct HomePageRefreshCommand: AppCommand {
    
    func execute(in store: Store) {
        
        let mealType = getCurrentMealType()
        switch mealType {
        case .breakfast:
            store.appState.home.featuredName = "精选早餐"
        case .lunch:
            store.appState.home.featuredName = "精选午餐"
        case .afternoonTea:
            store.appState.home.featuredName = "精选下午茶"
        case .dinner:
            store.appState.home.featuredName = "精选晚餐"
        case .supper:
            store.appState.home.featuredName = "精选夜宵"
        }
        loadRecipe(classid: mealType.rawValue, isFeatured: true, in: store)
        
        let season = getCurrentSeason()
        switch season {
        case .spring:
            store.appState.home.seasonName = "春季精选"
        case .summer:
            store.appState.home.seasonName = "夏季精选"
        case .autumn:
            store.appState.home.seasonName = "秋季精选"
        case .winter:
            store.appState.home.seasonName = "冬季精选"
        }
        loadRecipe(classid: season.rawValue, isFeatured: false, in: store)
    }
    
    enum MealType: Int {
        case breakfast = 562
        case lunch = 563
        case afternoonTea = 564
        case dinner = 565
        case supper = 566
    }
    
    func getCurrentMealType() -> MealType {
        let hour = Calendar.current.component(.hour, from: Date())
        if hour >= 20 {
            return .supper
        } else if hour >= 18 {
            return .dinner
        } else if hour >= 15 {
            return .afternoonTea
        } else if hour >= 11 {
            return .lunch
        } else if hour >= 6 {
            return .breakfast
        }
        
        return .supper
    }
    
    enum Season: Int {
        case spring = 598
        case summer = 599
        case autumn = 600
        case winter = 601
    }
    
    func getCurrentSeason() -> Season {
        let month = Calendar.current.component(.month, from: Date())
        
        if month >= 10 {
            return .winter
        } else if month >= 7 {
            return .autumn
        } else if month >= 4 {
            return .summer
        } else {
            return .spring
        }
    }
    
    func loadRecipe(classid: Int, isFeatured: Bool, in store: Store) {
        let token = SubscriptionToken()
        let offset = Int.random(in: 0..<100)
        
        AF.request(APIRouter.getRecipeByClass(classid: classid, start: offset, pageSize: store.appState.home.pageSize)).publishString()
            .sink(receiveCompletion: { complete in
                if case .failure(let error) = complete {
                    print(error.localizedDescription)
                    print("网络异常，请检查您的网络！")
                }
                
                if isFeatured {
                    store.appState.home.isLoadingFeaturedRecipe = false
                } else {
                    store.appState.home.isLoadingSeasonRecipe = false
                }
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
                    
                    if isFeatured {
                        store.appState.home.featuredRecipe.removeAll()
                        store.appState.home.featuredRecipe.append(contentsOf: response.result.list)
                    } else {
                        store.appState.home.seasonRecipe.removeAll()
                        store.appState.home.seasonRecipe.append(contentsOf: response.result.list)
                    }
                } catch {
                    
                }
            })
            .seal(in: token)
    }
}
