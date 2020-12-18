//
//  RecipeCell.swift
//  Pollen
//
//  Created by user on 2020/12/2.
//

import SwiftUI

struct RecipeCell: View {
    let recipe: Recipe
        
    var body: some View {
        ZStack {
            URLImage(recipe.pic)
                .cornerRadius(20)
            
            Color("recipeCellColor")
            
            VStack(alignment: .leading, spacing: 10) {
                Text(recipe.name)
                    .frame(alignment: .leading)
                    .foregroundColor(Color("textColor"))
                    .font(.system(size: 20, weight: .bold, design: .default))
                    .lefting()
                
                
                Text("人数：\(recipe.peoplenum)")
                    .frame(alignment: .leading)
                    .foregroundColor(Color("textColor"))
                    .font(.system(size: 16))
                    .lefting()
                
                Text("准备时间：\(recipe.preparetime)")
                    .frame(alignment: .leading)
                    .foregroundColor(Color("textColor"))
                    .font(.system(size: 16))
                    .lefting()
                
                Text("烹饪时间：\(recipe.cookingtime)")
                    .frame(alignment: .leading)
                    .foregroundColor(Color("textColor"))
                    .font(.system(size: 16))
                    .lefting()
                
                Spacer()
            }
            .padding(15)
        }
        .padding()
    }
}
