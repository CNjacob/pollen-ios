//
//  AccountCommand.swift
//  Pollen
//
//  Created by user on 2020/12/1.
//

import Foundation
import Alamofire

struct SignUpCommand: AppCommand {
    let username: String
    let password: String
    
    func execute(in store: Store) {
        let token = SubscriptionToken()
        
        AF.request(APIRouter.signUp(username: username, password: password)).publishString()
            .sink(receiveCompletion: { complete in
                if case .failure(let error) = complete {
                    print(error.localizedDescription)
                    store.appState.account.loginFailure = true
                    store.appState.account.loginErrorMessage = "注册失败，请检查您的网络！"
                }
                store.appState.account.signUpRequesting = false
                token.unseal()
            }, receiveValue: { receive in
                guard let receiveData = receive.data else {
                    store.appState.account.loginFailure = true
                    store.appState.account.loginErrorMessage = "服务器异常，请稍后重试！"
                    return
                }
                
                let decode = JSONDecoder()
                do {
                    let response = try decode.decode(LoginResponse.self, from: receiveData)
                    store.appState.account.loggedIn = true
                    store.appState.account.accessToken = response.token
                    store.appState.account.user = response.user
                } catch {
                    let error = try! decode.decode(ResponseError.self, from: receiveData)
                    guard error.reason != "Something went wrong." else {
                        store.dispatch(.signUp(username: username, password: password))
                        return
                    }
                    
                    store.appState.account.loginFailure = true
                    store.appState.account.loginErrorMessage = error.reason
                }
            })
            .seal(in: token)
        
        /*
         APIService().response(from: SignUpRequest(username: username, password: password))
         .sink(receiveCompletion: { complete in
         if case .failure(let error) = complete {
         print(error.localizedDescription)
         store.appState.account.loginFailure = true
         store.appState.account.loginErrorMessage = "注册失败，请检查您的网络！"
         }
         token.unseal()
         }, receiveValue: { receive in
         if case .failure(let error) = receive.result {
         store.appState.account.loginFailure = true
         store.appState.account.loginErrorMessage = error.localizedDescription
         } else {
         let decode = JSONDecoder()
         do {
         let s = try decode.decode(LoginResponse.self, from: receive.data!)
         print(s.token)
         store.appState.account.loggedIn = true
         } catch {
         let error = try! decode.decode(ResponseError.self, from: receive.data!)
         store.appState.account.loginFailure = true
         store.appState.account.loginErrorMessage = error.reason
         }
         }
         })
         .seal(in: token)
         */
    }
}

struct LoginCommand: AppCommand {
    let username: String
    let password: String
    
    func execute(in store: Store) {
        let token = SubscriptionToken()
        
        AF.request(APIRouter.login(username: username, password: password)).publishString()
            .sink(receiveCompletion: { complete in
                if case .failure(let error) = complete {
                    print(error.localizedDescription)
                    store.appState.account.loginFailure = true
                    store.appState.account.loginErrorMessage = "登录失败，请检查您的网络！"
                }
                store.appState.account.loginRequesting = false
                token.unseal()
            }, receiveValue: { receive in
                guard let receiveData = receive.data else {
                    store.appState.account.loginFailure = true
                    store.appState.account.loginErrorMessage = "服务器异常，请稍后重试！"
                    return
                }
                
                let decode = JSONDecoder()
                do {
                    let response = try decode.decode(LoginResponse.self, from: receiveData)
                    store.appState.account.loggedIn = true
                    store.appState.account.accessToken = response.token
                    store.appState.account.user = response.user
                    store.dispatch(.loadFavoritedRecipe(token: response.token))
                } catch {
                    let error = try! decode.decode(ResponseError.self, from: receiveData)
                    guard error.reason != "Something went wrong." else {
                        store.dispatch(.login(username: username, password: password))
                        return
                    }
                    store.appState.account.loginFailure = true
                    store.appState.account.loginErrorMessage = error.reason
                }
            })
            .seal(in: token)
        
        /*
         APIService().response(from: LoginRequest(username: username, password: password))
         .sink(receiveCompletion: { complete in
         if case .failure(let error) = complete {
         print(error.localizedDescription)
         store.appState.account.loginFailure = true
         store.appState.account.loginErrorMessage = "登录失败，请检查您的网络！"
         }
         token.unseal()
         }, receiveValue: { receive in
         let decode = JSONDecoder()
         do {
         let s = try decode.decode(LoginResponse.self, from: receive.data!)
         print(s.token)
         store.appState.account.loggedIn = true
         } catch {
         let error = try! decode.decode(ResponseError.self, from: receive.data!)
         store.appState.account.loginFailure = true
         store.appState.account.loginErrorMessage = error.reason
         }
         })
         .seal(in: token)
         */
        
        /*
         LoginRequest(username: username, password: password).publisher
         .sink(receiveCompletion: { complete in
         if case .failure(let error) = complete {
         print(error.localizedDescription)
         store.appState.account.loginFailure = true
         store.appState.account.loginErrorMessage = "登录失败，请检查您的网络！"
         }
         token.unseal()
         }, receiveValue: { receive in
         let decode = JSONDecoder()
         do {
         let s = try decode.decode(LoginResponse.self, from: receive.data!)
         print(s.token)
         store.appState.account.loggedIn = true
         } catch {
         let error = try! decode.decode(ResponseError.self, from: receive.data!)
         store.appState.account.loginFailure = true
         store.appState.account.loginErrorMessage = error.reason
         }
         })
         .seal(in: token)
         */
    }
}

struct CheckLoginAccessTokenCommand: AppCommand {
    let token: String
    
    func execute(in store: Store) {
        let subscriptionToken = SubscriptionToken()
        
        AF.request(APIRouter.checkLoginAccessToken(token: token)).publishString()
            .sink(receiveCompletion: { complete in
                if case .failure(let error) = complete {
                    print(error.localizedDescription)
                    store.appState.account.loginFailure = true
                    store.appState.account.loginErrorMessage = "登录失败，请检查您的网络！"
                }
                store.appState.account.loginRequesting = false
                subscriptionToken.unseal()
            }, receiveValue: { receive in
                guard let receiveData = receive.data else {
                    store.appState.account.loginFailure = true
                    store.appState.account.loginErrorMessage = "服务器异常，请稍后重试！"
                    return
                }
                
                let decode = JSONDecoder()
                do {
                    let user = try decode.decode(User.self, from: receiveData)
                    store.appState.account.loggedIn = true
                    store.appState.account.user = user
                    store.dispatch(.loadFavoritedRecipe(token: token))
                } catch {
                    let error = try! decode.decode(ResponseError.self, from: receiveData)
                    guard error.reason != "Something went wrong." else {
                        store.dispatch(.checkLoginAccessToken(token: token))
                        return
                    }
                    store.appState.account.loginFailure = true
                    store.appState.account.loginErrorMessage = error.reason
                }
            })
            .seal(in: subscriptionToken)
    }
}

struct LoadFavoritedRecipeCommand: AppCommand {
    let token: String
    
    func execute(in store: Store) {
        let subscriptionToken = SubscriptionToken()
        AF.request(APIRouter.loadFavoritedRecipe(token: token)).publishString()
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
