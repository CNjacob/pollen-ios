//
//  Recipe.swift
//  HuaFanDay
//
//  Created by user on 2020/11/17.
//  Copyright © 2020 XiaoHua. All rights reserved.
//

import Foundation

struct RecipeExists: Codable {
    let isExists: Int
}

struct Material: Hashable, Codable {
    let mname: String
    let type: Int
    let amount: String
}

struct Process: Hashable, Codable {
    let pcontent: String
    let pic: String
}

struct Recipe: Hashable, Codable {
    let id: Int
    let classid: Int
    let name: String
    let peoplenum: String
    let preparetime: String
    let cookingtime: String
    let content: String
    let pic: String
    let tag: String
    let material: [Material]
    let process: [Process]
    
    static func create(withFavoritedRecipe favoritedRecipe: FavoritedRecipe) -> Recipe {
        Recipe(id: favoritedRecipe.recipeId,
               classid: favoritedRecipe.classid,
               name: favoritedRecipe.name,
               peoplenum: favoritedRecipe.peoplenum,
               preparetime: favoritedRecipe.preparetime,
               cookingtime: favoritedRecipe.cookingtime,
               content: favoritedRecipe.content,
               pic: favoritedRecipe.pic,
               tag: favoritedRecipe.tag,
               material: favoritedRecipe.material,
               process: favoritedRecipe.process)
    }
}

struct FavoritedRecipe: Hashable, Codable {
    let recipeId: Int
    let classid: Int
    let name: String
    let peoplenum: String
    let preparetime: String
    let cookingtime: String
    let content: String
    let pic: String
    let tag: String
    let material: [Material]
    let process: [Process]
    
    static func create(withRecipe recipe: Recipe) -> FavoritedRecipe {
        FavoritedRecipe(recipeId: recipe.id,
                        classid: recipe.classid,
                        name: recipe.name,
                        peoplenum: recipe.peoplenum,
                        preparetime: recipe.preparetime,
                        cookingtime: recipe.cookingtime,
                        content: recipe.content,
                        pic: recipe.pic,
                        tag: recipe.tag,
                        material: recipe.material,
                        process: recipe.process)
    }
}

/*
{
    "id": "8",
    "classid": "2",
    "name": "醋溜白菜",
    "peoplenum": "1-2人",
    "preparetime": "10-20分钟",
    "cookingtime": "10-20分钟",
    "content": "醋溜白菜，是北方人经常吃的一道菜，尤其是在多年前的冬天。那时，没有大棚菜，冬天，家家每天佐餐的基本上都是冬储大白菜，聪明的家庭主妇总是想方设法将这单调的菜变成多种菜式，于是，醋溜白菜被频繁的端上餐桌。<br>美食不分贵贱，用最平凡的原料、最简单的调料和最普通的手法做出美味的菜肴来才是美食的真谛。 <br>这次，我做的醋溜白菜，近似鲁菜的做法，使个这道菜酸甜浓郁、开胃下饭、老少咸宜。",
    "pic": "http://api.jisuapi.com/recipe/upload/20160719/115138_46688.jpg",
    "tag": "减肥,家常菜,排毒,补钙",
    "material": [
    {
    "mname": "油",
    "type": "0",
    "amount": "适量"
    },
    {
    "mname": "盐",
    "type": "0",
    "amount": "适量"
    },
    {
    "mname": "花椒",
    "type": "0",
    "amount": "适量"
    },
    {
    "mname": "干红椒",
    "type": "0",
    "amount": "适量"
    },
    {
    "mname": "葱",
    "type": "0",
    "amount": "适量"
    },
    {
    "mname": "姜",
    "type": "0",
    "amount": "适量"
    },
    {
    "mname": "蒜",
    "type": "0",
    "amount": "适量"
    },
    {
    "mname": "醋",
    "type": "0",
    "amount": "适量"
    },
    {
    "mname": "酱油",
    "type": "0",
    "amount": "适量"
    },
    {
    "mname": "糖",
    "type": "0",
    "amount": "适量"
    },
    {
    "mname": "淀粉",
    "type": "0",
    "amount": "适量"
    },
    {
    "mname": "白菜",
    "type": "1",
    "amount": "380g"
    }
    ],
    
    "process": [
    {
    "pcontent": "准备食材。",
    "pic": "http://api.jisuapi.com/recipe/upload/20160719/162550_84583.jpg"
    },
    {
    "pcontent": "将白菜斜刀片成薄片。",
    "pic": "http://api.jisuapi.com/recipe/upload/20160719/162551_90620.jpg"
    },
    {
    "pcontent": "片切好的白菜帮与菜叶分别入好。",
    "pic": "http://api.jisuapi.com/recipe/upload/20160719/162551_20925.jpg"
    },
    {
    "pcontent": "盐、糖、生抽、醋淀粉加少许水调匀备用。",
    "pic": "http://api.jisuapi.com/recipe/upload/20160719/162552_23125.jpg"
    },
    {
    "pcontent": "锅中油烧热，先入花椒炒香后捞出。再加入干红椒段略炒。",
    "pic": "http://api.jisuapi.com/recipe/upload/20160719/162552_57046.jpg"
    },
    {
    "pcontent": "加入葱姜蒜煸炒香，然后入白菜帮翻炒。",
    "pic": "http://api.jisuapi.com/recipe/upload/20160719/162553_89090.jpg"
    },
    {
    "pcontent": "炒至菜帮变软时，加入白菜叶。",
    "pic": "http://api.jisuapi.com/recipe/upload/20160719/162553_40445.jpg"
    },
    {
    "pcontent": "快速翻炒至菜软，勾入碗汁",
    "pic": "http://api.jisuapi.com/recipe/upload/20160719/162554_92210.jpg"
    },
    {
    "pcontent": "使汤汁均匀的包裹在菜帮上即可",
    "pic": "http://api.jisuapi.com/recipe/upload/20160719/162554_29522.jpg"
    }
    ]
}
*/
