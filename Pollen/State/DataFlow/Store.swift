//
//  Store.swift
//  Pollen
//
//  Created by user on 2020/11/25.
//

import Combine

class Store: ObservableObject {
    @Published var appState = AppState()
    
    private var disposeBag = Set<AnyCancellable>()

    init() {
        setupObservers()
    }
    
    func setupObservers() {
        appState.account.checker.loginValidPublisher.sink { isValid in
            self.dispatch(.loginAccountCheck(isValid: isValid))
        }.store(in: &disposeBag)
        
        appState.account.checker.signUpValidPublisher.sink { warningMessage in
            self.dispatch(.signupAccountCheck(warningMessage: warningMessage))
        }.store(in: &disposeBag)
    }
    
    
    func dispatch(_ action: AppAction) {
        print("[ACTION]: \(action)")
        let result = Store.reduce(state: appState, action: action)
        appState = result.0
        if let command = result.1 {
            print("[COMMAND]: \(command)")
            command.execute(in: self)
        }
    }

    static func reduce(state: AppState, action: AppAction) -> (AppState, AppCommand?) {
        var appState = state
        var appCommand: AppCommand? = nil
        
        switch action {
        
        case .loginAccountCheck(let isValid):
            appState.account.loginValid = isValid
            
        case .login(let username, let password):
            appState.account.loginRequesting = true
            appCommand = LoginCommand(username: username, password: password)
            
        case .checkLoginAccessToken(let token):
            appState.account.loginRequesting = true
            appCommand = CheckLoginAccessTokenCommand(token: token)
            
        case .signupAccountCheck(let warningMessage):
            appState.account.warningMessage = warningMessage
            appState.account.signUpValid = warningMessage == ""
            
        case .signUp(let username, let password):
            appState.account.signUpRequesting = true
            appCommand = SignUpCommand(username: username, password: password)
        case .loadFavoritedRecipe(let token):
            appCommand = LoadFavoritedRecipeCommand(token:token)
            
        case .logout:
            appState.account.loggedIn = false
            appState.account.accessToken = ""
            
        case .clearCache:
            appState.account.isClearCache = true
            appCommand = ClearCacheCommand()
            
        case .loadRecipeClass(let filename):
            appCommand = LoadRecipeClassCommand(filename: filename)
            
        case .loadRecipeData(let filename):
            appCommand = LoadRecipeDataCommand(filename: filename)
        
        case .showRecipeClassFilterView:
            appState.recipe.showingRecipeClassFilter.toggle()
            
        case .hiddenRecipeClassFilterView:
            appState.recipe.showingRecipeClassFilter = false
            
        case .resetRecipeClassId(let parentClassId, let subClassId):
            appState.recipe.currentParentClassId = parentClassId
            appState.recipe.currentSubClassId = subClassId
        
        case .reloadRecipe(let classId):
            appState.recipe.isLoadingRecipe = true
            appCommand = ReloadRecipeCommand(classId: classId)
            
        case .loadMoreRecipe(let classId):
            appState.recipe.isLoadingRecipe = true
            appCommand = LoadMoreRecipeCommand(classId: classId)
            
        case .favoritedRecipe(let token, let recipe):
            appCommand = FavoritedRecipeCommand(token: token, recipe: recipe)
            
        case .cancelFavoritedRecipe(let token, let recipe):
            appCommand = CancelFavoritedRecipeCommand(token: token, recipe: recipe)
            
        case .homePageRefresh:
            appState.home.isLoadingFeaturedRecipe = true
            appState.home.isLoadingSeasonRecipe = true
            appCommand = HomePageRefreshCommand()
            
        }
            
        
        return (appState, appCommand)
    }
}
