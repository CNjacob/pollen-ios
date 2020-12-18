//
//  DataStore.swift
//  Pollen
//
//  Created by user on 2020/11/23.
//

import SwiftUI
import Combine

final class DataStore: ObservableObject {
    
    let didChange = PassthroughSubject<DataStore, Never>()
    
    @Published var login: Bool = false
    
    @UserDefault(key: "loggedIn", defaultValue: false)
    var loggedIn: Bool {
        didSet {
            didChange.send(self)
            self.login = self.loggedIn
        }
    }
    
    @UserDefault(key: "token", defaultValue: "")
    var token: String {
        didSet {
            didChange.send(self)
        }
    }
    
    @UserDefault(key: "username", defaultValue: "")
    var User: String
    
    func isLogin() -> Bool {
        guard !token.isEmpty else {
            return false
        }
        
        return true
    }
}


final class DataOnboarding: ObservableObject {
    
    let didChange = PassthroughSubject<DataOnboarding, Never>()
    
    @Published var onboard: Bool = false
    
    @UserDefault(key: "onboardComplete", defaultValue: false)
    var onboardComplete: Bool {
        didSet {
            didChange.send(self)
            self.onboard = self.onboardComplete
        }
    }
}
