//
//  AppError.swift
//  Pollen
//
//  Created by user on 2020/11/25.
//

import Foundation

enum AppError: Error, Identifiable {
    var id: String { localizedDescription }

    case alreadyRegistered
    case passwordWrong

    case networkingFailed(Error)
}

extension AppError: LocalizedError {
    var localizedDescription: String {
        switch self {
        case .alreadyRegistered:
            return "该账号已注册"
            
        case .passwordWrong:
            return "密码错误"
            
        case .networkingFailed(let error):
            return error.localizedDescription
        }
    }
}
