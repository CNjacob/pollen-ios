//
//  OnboardingView.swift
//  SwiftUIWorkingDemo
//
//  Created by mac-00015 on 18/10/19.
//  Copyright © 2019 mac-00015. All rights reserved.
//

import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var store: Store
    
    var subViews = [
        UIHostingController(rootView: Subview(imageString: "First")),
        UIHostingController(rootView: Subview(imageString: "Second")),
        UIHostingController(rootView: Subview(imageString: "Third"))
    ]
    
    var titles = ["精选推荐", "美食坊", "美食收藏"]
        
    var captions =  ["根据不同时间推荐美食，如精选早餐、精选午餐、精选下午茶等。", "各类美食应有尽有，任你选择。", "美食收藏，更易找到最爱美食。"]
    
    @State var currentPageIndex = 0
    @EnvironmentObject var dataOnboard: DataOnboarding
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            PageViewController(currentPageIndex: $currentPageIndex,viewControllers: subViews)
                .frame(height: (UIScreen.main.bounds.width * 500) / 414)
            
            Spacer()
            
            Group {
                
                Text(titles[currentPageIndex])
                    .font(.title)
                
                Text(captions[currentPageIndex])
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .frame(width: 300, height: 50, alignment: .leading)
                    .lineLimit(nil)
            }.padding([.leading, .trailing])
            
            HStack {
                
                PageControl(numberOfPages: subViews.count, currentPageIndex: $currentPageIndex)
                
                Spacer()
                
                Button(action: {
                    
                    if self.currentPageIndex + 1 == self.subViews.count {
                        
                        //if using with proprty wrapper
                        store.appState.onboarding.onboardComplete = true
                        
                    } else {
                        self.currentPageIndex += 1
                    }
                }) {
                    Image(systemName: "arrow.right")
                        .resizable()
                        .foregroundColor(.white)
                        .frame(width: 30, height: 30)
                        .padding()
                        .background(Color("lightblueColor"))
                        .clipShape(Circle())
                }
            }.padding()
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
