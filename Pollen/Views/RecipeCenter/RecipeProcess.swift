//
//  RecipeProcess.swift
//  Pollen
//
//  Created by user on 2020/12/4.
//

import SwiftUI

struct RecipeProcess: View {
    let recipeProcess: [Process]
    
    var body: some View {
        VStack {
            Spacer(minLength: 20)
            
            Text("具体步骤")
                .foregroundColor(Color("textColor"))
                .font(.system(size: 26, weight: .bold, design: .default))
            
            ScrollView {
                ForEach(0..<recipeProcess.count) { index in
                    VStack {
                        let process = recipeProcess[index]
                        Text("\(index + 1). \(process.pcontent)")
                            .padding()
                        
                        URLImage(process.pic)
                            .cornerRadius(20)
                            .padding()
                    }
                }
            }
        }
    }
}
