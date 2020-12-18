//
//  PullToRefreshView.swift
//  Pollen
//
//  Created by user on 2020/12/2.
//

import SwiftUI

struct PullToRefreshView: View {
    let progress: CGFloat
    
    var body: some View {
        Text("下拉刷新")
    }
}

struct PullToRefreshView_Previews: PreviewProvider {
    static var previews: some View {
        PullToRefreshView(progress: 0)
    }
}
