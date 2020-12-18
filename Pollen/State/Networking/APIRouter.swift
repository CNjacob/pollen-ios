//
//  APIRouter.swift
//  Pollen
//
//  Created by user on 2020/12/1.
//

import Foundation
import Alamofire

let appByteDatakey = "95f348fa0d7d522f"

enum APIRouter {
    case login(username: String, password: String)
    case signUp(username: String, password: String)
    case checkLoginAccessToken(token: String)
    case loadFavoritedRecipe(token: String)
    
    case recipeClass
    case getRecipeByClass(classid: Int, start: Int, pageSize: Int)
    case searchRecipe(keyword: String)
    case recipeDetail(recipeid: String)
    
    case recipeIsExists(recipe: FavoritedRecipe)
    case createRecipe(recipe: FavoritedRecipe)
    case favoritedRecipe(token: String, recipeId: Int)
    case cancelFavoritedRecipe(token: String, recipeId: Int)
    
    
    var baseURL: String {
        switch self {
        
        case .login,
             .signUp,
             .checkLoginAccessToken,
             .loadFavoritedRecipe,
             
             .recipeIsExists,
             .createRecipe,
             .favoritedRecipe,
             .cancelFavoritedRecipe:
            
            return "http://101.132.103.62:8080"
            
        case .recipeClass,
             .getRecipeByClass,
             .searchRecipe,
             .recipeDetail:
            
            return "https://api.binstd.com"
        }
        
    }
    
    var path: String {
        switch self {
        case .login:
            return "users/login"
            
        case .signUp:
            return "users/signup"
            
        case .checkLoginAccessToken:
            return "users/me"
            
        case .loadFavoritedRecipe:
            return "users/recipes"
            
        case .recipeClass:
            return ""
            
        case .getRecipeByClass:
            return "recipe/byclass"
            
        case .searchRecipe:
            return "recipe/search"
            
        case .recipeDetail:
            return "recipe/detail"
            
        
        case .recipeIsExists:
            return "recipes/exists"
            
        case .createRecipe:
            return "recipes/create"
            
        case .favoritedRecipe:
            return "recipes/favorited"
            
        case .cancelFavoritedRecipe:
            return "recipes/cancel_favorited"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        
        case .login,
             .signUp,
             
             .recipeIsExists,
             .createRecipe,
             .favoritedRecipe,
             .cancelFavoritedRecipe:
            
            return .post
            
        case .checkLoginAccessToken,
             .loadFavoritedRecipe,
             
             .recipeClass,
             .getRecipeByClass,
             .searchRecipe,
             .recipeDetail:
            
            return .get
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .login(let username, let password):
            return HTTPHeaders(
                ["Authorization": Authorization.basic(username: username, password: password).value]
            )
        case .checkLoginAccessToken(let token),
             .loadFavoritedRecipe(let token),
             .favoritedRecipe(let token, _),
             .cancelFavoritedRecipe(let token, _):
            return HTTPHeaders(
                ["Authorization": Authorization.bearer(token).value]
            )
        default:
            return nil
        }
    }
    
    var parameters: [String: String]? {
        switch self {
        case .login:
            return nil
            
        case .signUp(let username, let password):
            return [
                "username": username,
                "password": password
            ]
        
        case .searchRecipe(let keyword):
            return [
                "keyword": keyword,
                "num": String(Int.max),
                "appkey": appByteDatakey
            ]
        
        case .getRecipeByClass(let classid, let start, let pageSize):
            return [
                "classid": String(classid),
                "start": String(start),
                "num": String(pageSize),
                "appkey": appByteDatakey
            ]
            
        case .recipeDetail(let recipeid):
            return [
                "id": recipeid,
                "appkey": appByteDatakey
            ]
            
        case .recipeIsExists(let recipe):
            return [
                "recipeId": String(recipe.recipeId)
            ]
        
        case .createRecipe(let recipe):
            let recipeString = try? recipe.asDictionary().toJsonString()
            return [
                "recipe": recipeString ?? ""
            ]
            
        case .favoritedRecipe(_, let recipeId):
            return [
                "recipeId": String(recipeId)
            ]
            
        case .cancelFavoritedRecipe(_, let recipeId):
            return [
                "recipeId": String(recipeId)
            ]
            
        default:
            return nil
        }
    }
}

// MARK: - URLRequestConvertible
extension APIRouter: URLRequestConvertible {
    func asURLRequest() throws -> URLRequest {
        let url = try baseURL.asURL().appendingPathComponent(path)
        
        var request = try URLRequest(url: url, method: method, headers: headers)
        
        if method == .get {
            request = try URLEncodedFormParameterEncoder()
                .encode(parameters, into: request)
        } else if method == .post {
            request = try JSONParameterEncoder().encode(parameters, into: request)
            request.setValue("application/json", forHTTPHeaderField: "Accept")
        }
        
        return request
    }
}
