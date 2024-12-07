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
                summary: "A creamy dish featuring spices, coconut milk, protein and vegetables, served with rice for a flavorful experience.",
                imageUrl: "https://drive.google.com/uc?id=1udP6e8-Jo6vuF9T2DvntLy52jfplulNH",
                title: "Thai Yellow Curry",
                ingredients: ["Yellow curry paste, thinly sliced against the grain", "Coconut milk", "1 tablespoon cornstarch", "Chicken or tofu", "Potatoes"],
                instructions: [
                    "Heat a tablespoon of oil in a pot and sauté the yellow curry paste until fragrant.",
                    "Add coconut milk and stir until the curry paste is fully dissolved.",
                    "Add diced potatoes, carrots, and your choice of chicken or tofu.",
                    "Simmer the curry until the potatoes and carrots are tender.",
                    "Season with fish sauce or soy sauce to taste."
                ],
                type: "Meats",
                saved: false
            ),
            Recipe(
                id: "2",
                summary: "Savor the Mac and Cheese, where tender pasta is enveloped in a rich, creamy cheese sauce.",
                imageUrl: "https://drive.google.com/uc?id=1QI1OA3QgTE7EOMclH3Q0cJKeGfkjjoRN",
                title: "Mac and Cheese",
                ingredients: ["8 oz elbow macaroni", "Salt", "2 cups milk (whole or 2%)", "2 cups shredded sharp cheddar cheese", "Salt and pepper to taste", "2 tablespoons melted butter"],
                instructions: [
                    "Cook macaroni in salted water until al dente, then drain.",
                    "Make a roux by whisking melted butter and flour; gradually add milk and cook until thickened.",
                    "Stir in cheeses and seasonings until smooth; mix in macaroni.",
                    "Optionally, bake with a breadcrumb topping at 350°F for 20-25 minutes."
                ],
                type: "Vegetarian",
                saved: false
            ),
            Recipe(
                id: "3",
                summary: "A Honey-Glazed Ham is a festive centerpiece, featuring tender, juicy ham coated in a sticky-sweet honey glaze.",
                imageUrl: "https://drive.google.com/uc?id=1ah8SCRWV691NtxZfucEkdtBvo3uK73Jk",
                title: "Honey-Glazed Ham",
                ingredients: ["1 fully cooked bone-in ham (8–10 lbs)", "1 cup honey", "1/2 cup brown sugar", "1/4 cup Dijon mustard", "1/4 cup orange juice",],
                instructions: [
                    "Place ham on a roasting rack and preheat the oven.",
                    "Make a glaze by simmering honey, brown sugar, mustard, juice, vinegar, and spices.",
                    "Brush ham with glaze, cover with foil, and bake at 15–18 min per pound.",
                    "Baste every 30 minutes; uncover for the last 20 minutes to caramelize.",
                ],
                type: "Healthy",
                saved: false
            ),
            Recipe(
                id: "4",
                summary: "Stuffed Squash is a cozy, wholesome dish featuring roasted squash halves filled with a savory mixture of quinoa, vegetables, and herbs. ",
                imageUrl: "https://drive.google.com/uc?id=1LtLaZ8ntV9dMjs_DcH7HRqPgQqq7BYLv",
                title: "Stuffed Squash",
                ingredients: ["2 medium butternut squashes, halved and seeded", "1 cup cooked quinoa", "1 cup sautéed spinach and mushrooms", "1/3 cup dried cranberries"],
                instructions: [
                    "Preheat the oven to 400°F (200°C) and place squash halves on a baking sheet.",
                    "Drizzle squash with olive oil, season with salt, and roast for 40–50 minutes.",
                    "In a bowl, mix cooked quinoa,mushrooms, cranberries, pecans, and thyme.",
                    "Spoon the quinoa mixture into the roasted squash cavities.",
                    "Return stuffed squash to the oven and bake for 10–15 minutes."
                    
                ],
                type: "Vegetarian",
                saved: false
            ),
            Recipe(
                id: "5",
                summary: "Succulent pork loin with fragrant garlic, rosemary, and wine.",
                imageUrl:  "https://drive.google.com/uc?id=16biGkez4P67QuVJBg9YUQYbN-e9vYCGk",
                title: "Roasted Pork Loin",
                ingredients: ["Pork loin", "Garlic", "Rosemary", "Olive oil", "White wine"],
                instructions: [
                    "Preheat oven to 375°F.",
                    "Rub pork loin with garlic and rosemary.",
                    "Place in a roasting pan and drizzle with olive oil.",
                    "Roast for 1 hour, basting with white wine."
                ],
                type: "None",
                saved: false
            ),
            Recipe(
                id: "6",
                summary: "My version of chicken Parmesan is a little different than what they do in the restaurants, with less sauce and a crispier crust.",
                imageUrl:  "https://drive.google.com/uc?id=1mUqS_qd_3K8Z_EOqXvI7Zjr3Ag1fVYi_",
                title: "Chicken Parmesan",
                ingredients: ["Chicken breasts", "Breadcrumbs", "Parmesan cheese", "Marinara sauce", "Mozzarella cheese"],
                instructions: [
                    "Coat chicken breasts in breadcrumbs and Parmesan cheese.",
                    "Bake at 375°F for 25 minutes.",
                    "Top with marinara sauce and mozzarella cheese.",
                    "Bake for another 10 minutes or until cheese is melted."
                ],
                type: "None",
                saved: false
            ),
            Recipe(
                id: "7",
                summary: "Jollof Rice is a beloved West African dish made with long-grain rice cooked in a rich, spiced tomato sauce.",
                imageUrl: "https://drive.google.com/uc?id=1JAcNY6vffBnD4T5-lFjtFV77fiRtn_th",
                title: "Jollof Rice",
                ingredients: ["Long-grain rice", "Tomatoes", "Tomato paste", "Onions", "Red pepper", "Spices"],
                instructions: [
                    "Blend tomatoes, red pepper, and some onions into a smooth puree.",
                    "Sauté chopped onions in oil until golden, then add tomato paste and blended mixture; cook until thickened.",
                    "Add washed rice to the pot and mix to coat with the sauce.",
                    "Pour in water or broth, cover, and cook on low heat until rice is tender.",
                ],
                type: "Grilled",
                saved: false
            ),
            Recipe(
                id: "8",
                summary: "Sweet potatoes are a naturally sweet and nutrient-rich root vegetable.",
                imageUrl: "https://drive.google.com/uc?id=10SSHwrqELoEs-qXGBhYWkKDhA8q10DQX",
                title: "Sweet Potato",
                ingredients: ["Sweet potatoes", "Olive oil or butter", "Salt", "Pepper", "Cinnamon or paprika", "Brown sugar or honey"],
                instructions: [
                    "Wash, peel (optional), and cut sweet potatoes into cubes or wedges.",
                    "Toss the sweet potatoes with olive oil or melted butter, salt, and pepper.",
                    "Add optional seasonings like cinnamon or paprika for flavor.",
                    "Spread the sweet potatoes evenly on a baking sheet and roast for 25-30 minutes, flipping halfway through."
                ],
                type: "Grilled",
                saved: false
            ),
            Recipe(
                id: "9",
                summary: "This ropa vieja is great served on tortillas or over rice. Add sour cream, cheese, and fresh cilantro on the side.",
                imageUrl:  "https://drive.google.com/uc?id=1j-T_b3jW8R3fd6Zr0gcXONTE9O3wLohb",
                title: "Cuban Ropa Vieja",
                ingredients: ["Beef", "Bell peppers", "Tomato paste", "Onions", "Garlic", "Olives"],
                instructions: [
                    "Heat oil in a skillet and cook the beef until browned.",
                    "Add bell peppers, onions, garlic, and tomato paste.",
                    "Simmer until the mixture is tender.",
                    "Serve with tortillas or over rice, topped with sour cream and cheese."
                ],
                type: "Soup",
                saved: false
            ),
        ]
    }
}
