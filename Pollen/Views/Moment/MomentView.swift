//
//  MomentView.swift
//  HuaFanDay
//
//  Created by user on 2020/11/3.
//  Copyright © 2020 XiaoHua. All rights reserved.
//

import SwiftUI

struct MomentView: View {
    @Environment(\.statusBarStyle) var statusBarStyle
    
    var body: some View {
        GeometryReader { proxy in
            MomentList()
            .overlayPreferenceValue(NavigationKey.self) { value in
                VStack {
                    self.navigation(proxy: proxy, value: value)
                    Spacer()
                }
            }
            .edgesIgnoringSafeArea(.top)
        }
        .onDisappear {
            self.statusBarStyle.current = .default
        }
    }
    
    func navigation(proxy: GeometryProxy, value: [Anchor<CGPoint>]) -> some View {
        let height = proxy.safeAreaInsets.top + 44
        let progress: CGFloat
        
        if let anchor = value.first {
            progress = max(0, min(1, (-proxy[anchor].y + height + 20) / 44))
        } else {
            progress = 1
        }

        // 同时更新状态栏样式
        statusBarStyle.current = progress > 0.3 ? .default : .lightContent
        
        return Navigation(progress: Double(progress))
            .frame(height: height)
    }
    
    struct Navigation: View {
        let progress: Double
        
        var body: some View {
            ZStack(alignment: .bottom) {
                Rectangle()
                    .foregroundColor(
                        Color("light_gray")
                            .opacity(progress)
                    )
                
                HStack {
                    Spacer()
                    
                    Button(action: {
                        print("camera")
                    }) {
                        Image(systemName: progress > 0.4 ? "camera" : "camera.fill")
                    }
                    .padding()
                }
                .accentColor(Color(white: colorScheme == .light ? 1 - progress : 1))
                .frame(height: 44)
                
                Text("花粉圈")
                    .font(.system(size: 16, weight: .semibold))
                    .opacity(progress)
                    .frame(height: 44, alignment: .center)
            }
            .frame(maxWidth: .infinity)
        }
        
        @Environment(\.colorScheme) var colorScheme
        @Environment(\.presentationMode) var presentationMode
    }
    
    struct NavigationKey: PreferenceKey {
        typealias Value = [Anchor<CGPoint>]
        
        static var defaultValue: Value = []
        
        static func reduce(value: inout Value, nextValue: () -> Value) {
            value.append(contentsOf: nextValue())
        }
    }
}

struct MomentView_Previews: PreviewProvider {
    static var previews: some View {
        MomentView()
    }
}
