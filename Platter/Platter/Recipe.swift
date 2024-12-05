//
//  Recipe.swift
//  Platter
//
//  Created by Yuan Gao on 12/2/24.
//
import Foundation

struct Recipe: Codable {
    let id: String
    let summary: String
    let imageUrl: String
    let title: String
    let ingredients: [String]
    let instructions: [String]
    let type: String
    var saved: Bool
}

extension Recipe {
    static let recipesKey = "recipes"

    static func saveRecipes(_ recipes: [Recipe]) {
        if let data = try? JSONEncoder().encode(recipes) {
            UserDefaults.standard.set(data, forKey: recipesKey)
        }
    }
    
    static func loadRecipes() -> [Recipe] {
        if let data = UserDefaults.standard.data(forKey: recipesKey),
           let recipes = try? JSONDecoder().decode([Recipe].self, from: data) {
            recipes.forEach { print("Recipe ID: \($0.id), Title: \($0.title), Saved: \($0.saved)") }
            return recipes
        }
        return [
            Recipe(
                id: "1",
                summary: "This ropa vieja is great served on tortillas or over rice. Add sour cream, cheese, and fresh cilantro on the side.",
                imageUrl: "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fimages.media-allrecipes.com%2Fuserphotos%2F8368708.jpg&q=60&c=sc&orient=true&poi=auto&h=512",
                title: "Cuban Ropa Vieja",
                ingredients: ["Beef", "Bell peppers", "Tomato paste", "Onions", "Garlic", "Olives"],
                instructions: [
                    "Heat oil in a skillet and cook the beef until browned.",
                    "Add bell peppers, onions, garlic, and tomato paste.",
                    "Simmer until the mixture is tender.",
                    "Serve with tortillas or over rice, topped with sour cream and cheese."
                ],
                type: "Baking",
                saved: false
            ),
            Recipe(
                id: "2",
                summary: "You only need 3 ingredients for this crockpot Italian chicken with Italian dressing and Parmesan cheese. Nothing could be easier than this for a weekday meal that's ready when you get home.",
                imageUrl: "https://www.allrecipes.com/thmb/cLLmeWO7j9YYI66vL3eZzUL_NKQ=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/7501402crockpot-italian-chicken-recipe-fabeveryday4x3-223051c7188841cb8fd7189958c62f3d.jpg",
                title: "Crockpot Italian Chicken",
                ingredients: ["Chicken breasts", "Italian dressing", "Parmesan cheese"],
                instructions: [
                    "Place chicken breasts in a crockpot.",
                    "Pour Italian dressing over the chicken.",
                    "Sprinkle with Parmesan cheese.",
                    "Cook on low for 6 hours or until tender."
                ],
                type: "Baking",
                saved: false
            ),
            Recipe(
                id: "3",
                summary: "This crockpot mac and cheese recipe is creamy, comforting, and takes just moments to assemble in a slow cooker. Great for large family gatherings and to take to potluck dinners. It's always a big hit!",
                imageUrl: "https://www.allrecipes.com/thmb/wRSDpUgu8VR2PpQtjGq97cuk8Fo=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/237311-slow-cooker-mac-and-cheese-DDMFS-4x3-9b4a15f2c3344c1da22b034bc3b35683.jpg",
                title: "Slow Cooker Mac and Cheese",
                ingredients: ["Elbow macaroni", "Cheddar cheese", "Milk", "Butter", "Flour"],
                instructions: [
                    "Cook macaroni according to package instructions.",
                    "In a crockpot, combine cooked macaroni, cheddar cheese, milk, butter, and flour.",
                    "Cook on low for 3 hours, stirring occasionally."
                ],
                type: "Vegan",
                saved: false
            ),
            Recipe(
                id: "4",
                summary: "My mother was one of the best cooks I ever knew. Whenever she made stews we mostly found homemade dumplings in them. We never ate things from packages or microwaves and you sure could taste what food was.",
                imageUrl: "https://www.allrecipes.com/thmb/neJT4JLJz7ks8D0Rkvzf8fRufWY=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/6900-dumplings-DDMFS-4x3-c03fe714205d4f24bd74b99768142864.jpg",
                title: "Homemade Dumplings",
                ingredients: ["Flour", "Baking powder", "Salt", "Milk", "Butter"],
                instructions: [
                    "Combine flour, baking powder, and salt in a bowl.",
                    "Add milk and butter, stirring to form a dough.",
                    "Drop spoonfuls of dough into simmering stew.",
                    "Cook until the dumplings are tender and cooked through."
                ],
                type: "Vegetarian",
                saved: false
            ),
            Recipe(
                id: "5",
                summary: "Succulent pork loin with fragrant garlic, rosemary, and wine.",
                imageUrl: "https://www.allrecipes.com/thmb/llWmU-j1PO7kCPvKkzQnfmeBf0M=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/21766-roasted-pork-loin-DDMFS-4x3-42648a2d6acf4ef3a05124ef5010c4fb.jpg",
                title: "Roasted Pork Loin",
                ingredients: ["Pork loin", "Garlic", "Rosemary", "Olive oil", "White wine"],
                instructions: [
                    "Preheat oven to 375°F.",
                    "Rub pork loin with garlic and rosemary.",
                    "Place in a roasting pan and drizzle with olive oil.",
                    "Roast for 1 hour, basting with white wine."
                ],
                type: "Baking",
                saved: false
            ),
            Recipe(
                id: "6",
                summary: "My version of chicken Parmesan is a little different than what they do in the restaurants, with less sauce and a crispier crust.",
                imageUrl: "https://www.allrecipes.com/thmb/0NW5WeQpXaotyZHJnK1e1mFWcCk=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/223042-Chicken-Parmesan-mfs_001-7ab952346edc4b2da36f3c0259b78543.jpg",
                title: "Chicken Parmesan",
                ingredients: ["Chicken breasts", "Breadcrumbs", "Parmesan cheese", "Marinara sauce", "Mozzarella cheese"],
                instructions: [
                    "Coat chicken breasts in breadcrumbs and Parmesan cheese.",
                    "Bake at 375°F for 25 minutes.",
                    "Top with marinara sauce and mozzarella cheese.",
                    "Bake for another 10 minutes or until cheese is melted."
                ],
                type: "Grilled",
                saved: false
            )
        ] 
    }
}
