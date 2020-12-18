//
//  AccountState.swift
//  Pollen
//
//  Created by user on 2020/11/30.
//

import Foundation
import Combine

extension AppState {
    struct AccountState {
        class AccountChecker {
            @Published var username = ""
            @Published var password = ""
            @Published var verifyPassword = ""
            
            private var cancellableSet: Set<AnyCancellable> = []
            
            private var isUsernameValidPublisher: AnyPublisher<Bool, Never> {
                $username
                    .debounce(for: 0.8, scheduler: RunLoop.main)
                    .removeDuplicates()
                    .map { input in
                        return input.count >= 3
                    }
                    .eraseToAnyPublisher()
            }
            
            private var isPasswordEmptyPublisher: AnyPublisher<Bool, Never> {
                $password
                    .debounce(for: 0.8, scheduler: RunLoop.main)
                    .removeDuplicates()
                    .map { password in
                        return password == ""
                    }
                    .eraseToAnyPublisher()
            }
            
            private var arePasswordEqualPublisher: AnyPublisher<Bool, Never> {
                Publishers.CombineLatest($password, $verifyPassword)
                    .debounce(for: 0.2, scheduler: RunLoop.main)
                    .map { password, verifyPassword in
                        return password == verifyPassword
                    }
                    .eraseToAnyPublisher()
            }
            
            private var passwordStrengthPublisher: AnyPublisher<PasswordStrength, Never> {
                $password
                    .debounce(for: 0.2, scheduler: RunLoop.main)
                    .removeDuplicates()
                    .map { input in
                        return Navajo.strength(ofPassword: input)
                    }
                    .eraseToAnyPublisher()
            }
            
            private var isPasswordStrongEnoughPublisher: AnyPublisher<Bool, Never> {
                passwordStrengthPublisher
                    .map { strenght in
                        
                        switch strenght {
                        case .reasonable, .strong, .veryStrong:
                            return true
                        default:
                            return false
                        }
                    }
                    .eraseToAnyPublisher()
            }
            
            enum PasswordCheck {
                case valid
                case empty
                case noMatch
                case notStrongEnough
            }
            
            private var isPasswordValidPublisher: AnyPublisher<PasswordCheck, Never> {
                
                Publishers.CombineLatest3(isPasswordEmptyPublisher, isPasswordStrongEnoughPublisher, arePasswordEqualPublisher)
                    .map { passwordIsEmpty, passwordIsStrongEnough, passwordsAreEqual in
                        
                        if passwordIsEmpty {
                            return .empty
                        } else if !passwordIsStrongEnough {
                            return .notStrongEnough
                        } else if !passwordsAreEqual {
                            return .noMatch
                        } else {
                            return .valid
                        }
                }
                .eraseToAnyPublisher()
            }
            
            var loginValidPublisher: AnyPublisher<Bool, Never> {
                Publishers.CombineLatest(isUsernameValidPublisher, isPasswordEmptyPublisher)
                    .map { userNameIsValid, passwordIsEmpty in
                        return userNameIsValid && !passwordIsEmpty
                    }
                    .eraseToAnyPublisher()
            }
            
            var signUpValidPublisher: AnyPublisher<String, Never> {
                
                Publishers.CombineLatest(isUsernameValidPublisher, isPasswordValidPublisher)
                    .map { userNameIsValid, passwordIsValid in
                        if !userNameIsValid {
                            return "用户名不合法"
                        }
                        switch passwordIsValid {
                        case .valid:
                            return ""
                        case .empty:
                            return "密码不能为空"
                        case .noMatch:
                            return "两次密码输入不一致"
                        case .notStrongEnough:
                            return "密码强度不够"
                        }
                }
                .eraseToAnyPublisher()
            }
        }
        
        var checker = AccountChecker()
        // 控制登录按钮状态
        var loginValid = false
        // 控制注册按钮状态
        var signUpValid = false
        // 注册页面异常提示
        var warningMessage = ""
        
        var signUpRequesting = false
        var loginRequesting = false
        var showingIndicator: Bool { signUpRequesting || loginRequesting }
        
        // 是否已登录
        var loggedIn = false
        // 登录accessToken
        @UserDefault(key: "AccessToken", defaultValue: "")
        var accessToken
        
        var user: User?
        
        // 是否登录失败
        var loginFailure = false
        // 登录失败error
        var loginErrorMessage = ""
        
        var favoritedRecipe: [FavoritedRecipe] = []
        
        // 是否在清理缓存
        var isClearCache = false
        
        var helpString = "期待您的反馈～～"
    }
}
