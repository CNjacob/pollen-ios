//
//  RefreshingView.swift
//  Pollen
//
//  Created by user on 2020/12/2.
//

import SwiftUI

struct RefreshingView: View {
    var body: some View {
        ActivityIndicator(style: .medium)
    }
}

struct RefreshingView_Previews: PreviewProvider {
    static var previews: some View {
        RefreshingView()
    }
}
