//
//  AppState.swift
//  Pollen
//
//  Created by user on 2020/11/25.
//

import Foundation
import SwiftUI

struct AppState {
    var onboarding = OnboardingState()
    var account = AccountState()
    
    var mainTab = MainTabState()
    var home = HomePageState()
    var recipe = RecipeState()
    var mine = MineState()
}

// MARK: OnboardingState
extension AppState {
    struct OnboardingState {
        @UserDefault(key: "onboardComplete", defaultValue: false)
        var onboardComplete
    }
}

// MARK: MainTabState
extension AppState {
    struct MainTabState {
        enum Index {
            case home
            case recipe
            case moment
            case mine
            
            var image: Image {
                switch self {
                case .home:
                    return Image("tab_homepage_nomal")
                case .recipe:
                    return Image("tab_recipecenter_nomal")
                case .moment:
                    return Image("tab_moments_nomal")
                case .mine:
                    return Image("tab_mine_nomal")
                }
            }
            
            var selectedImage: Image {
                switch self {
                case .home:
                    return Image("tab_homepage_selected")
                case .recipe:
                    return Image("tab_recipecenter_selected")
                case .moment:
                    return Image("tab_moments_selected")
                case .mine:
                    return Image("tab_mine_selected")
                }
            }
            
            var title: String {
                switch self {
                case .home:
                    return "首页"
                case .recipe:
                    return "美食坊"
                case .moment:
                    return "花粉圈"
                case .mine:
                    return "我的"
                }
            }
        }
        
        var selection: Index = .home
    }
}

// MARK: HomePageState
extension AppState {
    struct HomePageState {
        var pageSize = 20
        
        var isLoadingFeaturedRecipe = false
        var featuredName = ""
        // 根据时间精选
        var featuredRecipe: [Recipe] = []
        
        var isLoadingSeasonRecipe = false
        var seasonName = ""
        // 季节精选
        var seasonRecipe: [Recipe] = []
    }
}

// MARK: MineState
extension AppState {
    struct MineState {
        var showLoginView = false
        
    }
}
