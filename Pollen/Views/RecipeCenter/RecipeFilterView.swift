//
//  RecipeFilterView.swift
//  Pollen
//
//  Created by user on 2020/12/3.
//

import SwiftUI

struct FilterItem: View {
    var categoryName: String
    var items: [RecipeSubClass]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(categoryName)
                .font(.headline)
                .padding(.leading, 15)
                .padding(.top, 5)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 0) {
                    ForEach(self.items, id: \.self) { recipe in
                        RecipeSubClassItem(subClass: recipe)
                            .padding()
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .listRowInsets(EdgeInsets())
    }
}

struct RecipeSubClassItem: View {
    @EnvironmentObject var store: Store
    
    var subClass: RecipeSubClass
    
    var body: some View {
        ZStack {
            Color("recipeCellColor")
            
            Button {
                // reset classid
                store.dispatch(.resetRecipeClassId(parentClassId: subClass.parentid, subClassId: subClass.classid))
                
                // hidden filter view
                store.dispatch(.hiddenRecipeClassFilterView)
                
                // reload recipe data
                store.dispatch(.reloadRecipe(classId: subClass.classid))
                
            } label: {
                Text(subClass.name)
                    .foregroundColor(.primary)
                    .font(.system(size: 20, weight: .bold, design: .default))
            }
        }
        .background(Color("lightblueColor"))
        .frame(width: 80, height: 80, alignment: .center)
        .cornerRadius(16)
    }
}

struct FilterView: View {
    @EnvironmentObject var store: Store
    
    private var recipeState: AppState.RecipeState {
        store.appState.recipe
    }
    
    var body: some View {
        VStack {
            Spacer(minLength: 16)
            
            Text("\(recipeState.currentParentClass?.name ?? "") * \(recipeState.currentSubClass?.name ?? "")")
                .foregroundColor(Color("lightblueColor"))
                .font(.system(size: 20, weight: .bold, design: .default))
            
            List {
                ForEach(recipeState.recipeClass, id: \.self) { rClass in
                    FilterItem(categoryName: rClass.name, items: rClass.list)
                }
            }
        }
    }
}
