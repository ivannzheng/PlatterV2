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
                summary: "A creamy, aromatic dish featuring a blend of spices, coconut milk, and your choice of protein and vegetables, served with rice for a comforting and flavorful experience.",
                imageUrl: "https://drive.google.com/uc?id=1udP6e8-Jo6vuF9T2DvntLy52jfplulNH",
                title: "Thai Yellow Curry",
                ingredients: ["Yellow curry paste, thinly sliced against the grain", "Coconut milk", "1 tablespoon cornstarch", "Chicken or tofu", "Potatoes", "Carrots", "3 cloves garlic, minced", "1-inch piece of ginger, minced", "Fish sauce or soy sauce"],
                instructions: [
                    "Heat a tablespoon of oil in a pot and sauté the yellow curry paste until fragrant.",
                    "Add coconut milk and stir until the curry paste is fully dissolved.",
                    "Add diced potatoes, carrots, and your choice of chicken or tofu.",
                    "Simmer the curry until the potatoes and carrots are tender.",
                    "Season with fish sauce or soy sauce to taste.",
                    "Serve hot over steamed rice or with flatbread."
                ],
                type: "Meats",
                saved: false
            ),
            Recipe(
                id: "2",
                summary: "Savor the irresistible allure of Mac and Cheese, where tender pasta is enveloped in a rich, creamy cheese sauce, delivering pure comfort and nostalgia in every delectable bite.",
                imageUrl: "https://drive.google.com/uc?id=1QI1OA3QgTE7EOMclH3Q0cJKeGfkjjoRN",
                title: "Mac and Cheese",
                ingredients: ["8 oz elbow macaroni (or your favorite pasta)", "Salt (for boiling water)", "2 tablespoons butter", "2 tablespoons all-purpose flour", "2 cups milk (whole or 2%)", "2 cups shredded sharp cheddar cheese", "1 cup shredded mozzarella cheese", "1 teaspoon mustard powder (optional)", "1/2 teaspoon garlic powder", "1/2 teaspoon onion powder", "Salt and pepper to taste", "1/2 cup breadcrumbs", "2 tablespoons melted butter", "1/4 cup grated Parmesan cheese"],
                instructions: [
                    "In a large pot, bring salted water to a boil. Add the elbow macaroni and cook according to package instructions until al dente. Drain and set aside.",
                    "In a large saucepan, melt the butter over medium heat. Add the flour and whisk constantly for about 1-2 minutes until it forms a paste (roux).",
                    "Gradually add the milk, whisking continuously until the mixture is smooth and starts to thicken (about 5 minutes).",
                    "Reduce the heat to low, then stir in the shredded cheddar and mozzarella cheeses until melted and creamy. Add the mustard powder, garlic powder, onion powder, salt, and pepper. Adjust seasoning to taste.",
                    "Add the cooked macaroni to the cheese sauce, stirring until well coated.",
                    "If using, preheat the oven to 350°F (175°C). In a small bowl, mix the breadcrumbs with melted butter and Parmesan cheese. Sprinkle this mixture over the mac and cheese in a baking dish.",
                    "Bake in the preheated oven for 20-25 minutes, or until bubbly and golden brown on top.",
                    "Let it cool for a few minutes before serving. Enjoy your creamy, cheesy Mac and Cheese!"
                ],
                type: "Vegetarian",
                saved: false
            ),
            Recipe(
                id: "3",
                summary: "A Honey-Glazed Christmas Ham is a festive centerpiece, featuring tender, juicy ham coated in a sticky-sweet honey glaze infused with warm spices and a hint of citrus. Perfectly caramelized in the oven, it’s an irresistible combination of savory and sweet that adds holiday cheer to any table.",
                imageUrl: "https://drive.google.com/uc?id=1NdaualWtAEJnOPN1nTDl5DDaO3gTWUl7",
                title: "Slow Cooker Mac and Cheese",
                ingredients: ["1 fully cooked bone-in ham (8–10 lbs)", "1 cup honey", "1/2 cup brown sugar", "1/4 cup Dijon mustard", "1/4 cup orange juice (freshly squeezed)", "1/4 cup apple cider vinegar", "1/2 teaspoon ground cinnamon", "1/4 teaspoon ground cloves", "1/4 teaspoon ground nutmeg"],
                instructions: [
                    "Place the ham on a roasting rack in the prepared pan.",
                    "In a medium saucepan, combine honey, brown sugar, Dijon mustard, orange juice, apple cider vinegar, cinnamon, cloves, and nutmeg.",
                    "Heat the mixture over medium heat, stirring until the sugar dissolves. Bring to a simmer and let cook for 3–5 minutes, until slightly thickened. Remove from heat.",
                    "Brush a generous layer of the glaze over the ham, covering all exposed surfaces. Reserve some glaze for basting.",
                    "Cover the ham loosely with aluminum foil and bake for 15–18 minutes per pound (about 2–3 hours for an 8–10 lb ham), or until the internal temperature reaches 140°F (60°C).",
                    "Every 20–30 minutes, remove the foil, brush more glaze over the ham, and then re-cover it.",
                    "During the last 20 minutes of cooking, remove the foil entirely and brush the ham with the remaining glaze. Let the glaze caramelize, keeping an eye on it to avoid burning.",
                    "Once the ham is cooked, remove it from the oven and let it rest for 15–20 minutes before slicing."
                    
                ],
                type: "Healthy",
                saved: false
            ),
            Recipe(
                id: "4",
                summary: "Stuffed Butternut Squash is a cozy, wholesome dish featuring roasted squash halves filled with a savory mixture of quinoa, vegetables, and herbs. Perfect for holiday gatherings or weeknight dinners, it combines rich flavors and vibrant colors for a hearty, plant-based meal.",
                imageUrl: "https://drive.google.com/uc?id=1QOBfHmjnnZnq57DG7lddvAFSuKYV2hTC",
                title: "Stuffed Butternut Squash ",
                ingredients: ["2 medium butternut squashes, halved and seeded", "1 cup cooked quinoa", "1 cup sautéed spinach and mushrooms", "1/3 cup dried cranberries", "1/4 cup chopped pecans", "1 teaspoon dried thyme"],
                instructions: [
                    "Preheat the oven to 400°F (200°C) and place squash halves cut-side up on a baking sheet.",
                    "Drizzle squash with olive oil, season with salt, and roast for 40–50 minutes, until fork-tender.",
                    "In a bowl, mix cooked quinoa, sautéed spinach and mushrooms, cranberries, pecans, and thyme.",
                    "Spoon the quinoa mixture into the roasted squash cavities.",
                    "Return stuffed squash to the oven and bake for 10–15 minutes until heated through."
                    
                ],
                type: "Vegetarian",
                saved: false
            ),
            Recipe(
                id: "5",
                summary: "Succulent pork loin with fragrant garlic, rosemary, and wine.",
                imageUrl: "https://drive.google.com/uc?id=1wxANSxwLyg7_6cAZySlRCyntNTwnECuY",
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
                imageUrl: "https://drive.google.com/uc?id=1oJLinWzRU_3GLb9_lhFoN1LeFTteVeXk",
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
                summary: "Jollof Rice is a beloved West African dish made with long-grain rice cooked in a rich, spiced tomato sauce. It's a one-pot meal full of bold flavors, often served with fried plantains, chicken, or fish.",
                imageUrl: "https://drive.google.com/uc?id=1JAcNY6vffBnD4T5-lFjtFV77fiRtn_th",
                title: "Jollof Rice",
                ingredients: ["Long-grain rice", "Tomatoes", "Tomato paste", "Onions", "Red pepper", "Spices"],
                instructions: [
                    "Blend tomatoes, red pepper, and some onions into a smooth puree.",
                    "Sauté chopped onions in oil until golden, then add tomato paste and blended mixture; cook until thickened.",
                    "Season with spices, curry powder, thyme, and bouillon cubes, stirring well.",
                    "Add washed rice to the pot and mix to coat with the sauce.",
                    "Pour in water or broth, cover, and cook on low heat until rice is tender and fully cooked.",
                    "Stir gently, adjust seasoning, and serve warm."
                ],
                type: "Grilled",
                saved: false
            ),
            Recipe(
                id: "8",
                summary: "Sweet potatoes are a naturally sweet and nutrient-rich root vegetable that can be prepared in a variety of ways, from roasting to mashing. Their versatility and vibrant flavor make them a delicious side dish or a base for hearty meals.",
                imageUrl: "https://drive.google.com/uc?id=10SSHwrqELoEs-qXGBhYWkKDhA8q10DQX",
                title: "Sweet potato",
                ingredients: ["Sweet potatoes", "Olive oil or butter", "Salt", "Pepper", "Cinnamon or paprika", "Brown sugar or honey"],
                instructions: [
                    "Preheat the oven to 400°F (200°C).",
                    "Wash, peel (optional), and cut sweet potatoes into cubes or wedges.",
                    "Toss the sweet potatoes with olive oil or melted butter, salt, and pepper.",
                    "Add optional seasonings like cinnamon or paprika for flavor.",
                    "Spread the sweet potatoes evenly on a baking sheet and roast for 25-30 minutes, flipping halfway through.",
                    "Serve warm and drizzle with honey or sprinkle with brown sugar for a touch of sweetness if desired."
                ],
                type: "Grilled",
                saved: false
            ),
            Recipe(
                id: "9",
                summary: "This ropa vieja is great served on tortillas or over rice. Add sour cream, cheese, and fresh cilantro on the side.",
                imageUrl: "https://drive.google.com/uc?id=1209g_aFn6S8OGwLA12u7KGhgsuNGSKep",
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
