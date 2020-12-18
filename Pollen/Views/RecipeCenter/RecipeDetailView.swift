//
//  RecipeDetailView.swift
//  Pollen
//
//  Created by user on 2020/12/2.
//

import SwiftUI

struct TitleItem: View {
    let title: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 20, weight: .bold, design: .default))
                .foregroundColor(Color("lightblueColor"))
                .frame(alignment: .leading)
            Spacer()
        }
    }
}

struct DetailItem<Content>: View where Content: View {
    let title: String
    let content: () -> Content
    
    var body: some View {
        VStack(spacing: 10) {
            TitleItem(title: title)
            content()
        }
        .padding()
    }
}

struct RecipeDetailView: View {
    @EnvironmentObject var store: Store
    
    let recipe: Recipe
    
    @State var showingProcess = false
    var processButton: some View {
        HStack(spacing: 10) {
            Button(action: {
                let token = store.appState.account.accessToken
                if isFavorited() {
                    store.dispatch(.cancelFavoritedRecipe(token: token, recipe: self.recipe))
                } else {
                    store.dispatch(.favoritedRecipe(token: token, recipe: self.recipe))
                }
            }) {
                Image(isFavorited() ? "recipe_cancel_favorited" : "recipe_favorited")
                    .accessibility(label: Text(isFavorited() ? "取消收藏" : "收藏"))
                    .padding(5)
            }
            
            Button(action: {
                self.showingProcess.toggle()
            }) {
                Image("recipe_cooking")
                    .accessibility(label: Text("烹饪"))
                    .padding(5)
            }
        }
    }
    
    func isFavorited() -> Bool {
        store.appState.account.favoritedRecipe
            .filter { favoritedRecipe -> Bool in
                favoritedRecipe.recipeId == self.recipe.id
            }
            .first != nil
    }
    
    var body: some View {
        ScrollView {
            URLImage(recipe.pic)
                .cornerRadius(20)
                .padding()
                        
            DetailItem(title: "标签: ") {
                HStack {
                    Text(recipe.tag)
                    Spacer()
                }
            }
            
            DetailItem(title: "背景简介: ") {
                HStack {
                    Text(recipe.content)
                        .font(.system(size: 14))
                    Spacer()
                }
            }
            
            DetailItem(title: "准备材料：") {
                ForEach(recipe.material, id: \.self) { material in
                    VStack(spacing: 1){
                        HStack {
                            Text(material.mname)
                                .frame(alignment: .leading)
                            
                            Spacer()
                            
                            Text(material.amount)
                                .frame(alignment: .trailing)
                        }
                        Separator(color: Color("lightblueColor"))
                    }
                }
            }
            
            Spacer(minLength: 10)
        }
        .navigationBarTitle(recipe.name, displayMode: .large)
        .navigationBarItems(trailing: processButton)
        .sheet(isPresented: $showingProcess) {
            RecipeProcess(recipeProcess: recipe.process)
        }
    }
}
