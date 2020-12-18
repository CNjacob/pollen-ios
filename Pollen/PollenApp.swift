//
//  PollenApp.swift
//  Pollen
//
//  Created by user on 2020/11/18.
//

import SwiftUI

@main
struct PollenApp: App {
    
    var body: some Scene {
        WindowGroup {
            StartOnboardView()
                .environmentObject(Store())
        }
    }
}

struct StartView: View {
    @EnvironmentObject var store: Store
    
    var body: some View {
        if store.appState.account.loggedIn {
            MainTab()
        } else {
            LoginView()
        }
    }
}

struct StartOnboardView: View {
    @EnvironmentObject var store: Store
    
    var body: some View {
        if store.appState.onboarding.onboardComplete {
            StartView()
                .onAppear {
                    let token = store.appState.account.accessToken
                    if !token.isBlank {
                        store.dispatch(.checkLoginAccessToken(token: token))
                    }
                }
        } else {
            OnboardingView()
        }
    }
}
