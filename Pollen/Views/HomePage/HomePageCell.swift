//
//  HomePageCell.swift
//  Pollen
//
//  Created by user on 2020/12/3.
//

import SwiftUI

struct CellItem<Content: View>: View {
    var categoryName: String
    var items: [Recipe]
    var offsetY: CGFloat?
    var content: () -> Content
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(categoryName)
                .font(.system(size: 25, weight: .bold, design: .default))
                .padding(.leading, 15)
                .padding(.top, 5)
            
            ScrollView(.horizontal, showsIndicators: false) {
                content()
            }
            .offset(y: offsetY ?? 0)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .listRowInsets(EdgeInsets())
    }
}

struct HomePageCell: View {
    var categoryName: String
    var items: [Recipe]
    
    var body: some View {
        CellItem(categoryName: categoryName, items: items) {
            HStack(alignment: .top, spacing: 0) {
                ForEach(self.items, id: \.self) { recipe in
                    NavigationLink(
                        destination: RecipeDetailView(recipe: recipe)
                    ) {
                        CategoryItem(recipe: recipe)
                    }
                }
            }
            .frame(height: 185)
        }
    }
}

struct CardScroll: View {
    var categoryName: String
    var items: [Recipe]
    
    var body: some View {
        CellItem(categoryName: categoryName, items: items, offsetY: -20) {
            HStack(spacing: 20) {
                ForEach(self.items, id: \.self) { recipe in
                    NavigationLink(
                        destination: RecipeDetailView(recipe: recipe)
                    ) {
                        SectionView(recipe: recipe)
                    }
                }
            }
            .padding(30)
            .padding(.bottom, 30)
        }
    }
}

struct CategoryItem: View {
    var recipe: Recipe
    
    var body: some View {
        VStack(alignment: .leading) {
            URLImage(recipe.pic)
                .frame(width: 155, height: 155, alignment: .center)
                .cornerRadius(15)
            
            Text(recipe.name)
                .foregroundColor(.primary)
                .font(.system(size: 16))
        }
        .padding(.leading, 15)
    }
}

struct SectionView: View {
    var recipe: Recipe
    
    var body: some View {
        ZStack {
            URLImage(recipe.pic)
                .cornerRadius(30)
            
            VStack(alignment: .center) {
                HStack(alignment: .top) {
                    Text(recipe.name)
                        .font(.system(size: 20, weight: .bold))
                        .frame(width: 160, alignment: .leading)
                        .foregroundColor(Color("textColor"))
                    Spacer()
                }
                Spacer()
            }
            .padding(.top, 20)
            .padding(.horizontal, 20)
            .frame(width: 275, height: 275)
            .cornerRadius(30)
        }
        .frame(width: 275, height: 275)
    }
}
