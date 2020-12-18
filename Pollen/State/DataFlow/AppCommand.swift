//
//  AppCommand.swift
//  Pollen
//
//  Created by user on 2020/11/25.
//

import Foundation
import Combine


protocol AppCommand {
    func execute(in store: Store)
}

// MARK: SubscriptionToken
class SubscriptionToken {
    var cancellable: AnyCancellable?
    func unseal() { cancellable = nil }
}

extension AnyCancellable {
    func seal(in token: SubscriptionToken) {
        token.cancellable = self
    }
}

struct ClearCacheCommand: AppCommand {
    func execute(in store: Store) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.5) {
            DispatchQueue.main.async {
                store.appState.account.isClearCache = false
            }
        }
    }
}
