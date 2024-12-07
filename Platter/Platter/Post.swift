//
//  Post.swift
//  Platter
//
//  Created by Yuan Gao on 12/5/24.
//

import Foundation

struct Post: Codable {
    // TODO: Create a Post Struct here
    let id: String
    let name: String
    let avatar: String
    //var likes: Int
    let title: String
    let description: String
    let time: Date
}

extension Post {
    
    static let dummyPosts: [Post] = [
        Post(
            id: "1",
            name: "Yuan Gao",
            avatar: "https://drive.google.com/uc?id=1udP6e8-Jo6vuF9T2DvntLy52jfplulNH",
            title: "Looking for Inspiration for Holiday Baking!",
            description: "With the holidays around the corner, I’m looking to try out some new festive recipes. Does anyone have a go-to cookie or cake recipe that screams holiday magic? 🎄🍪",
            time: Date()
        ),
        Post(
            id: "2",
            name: "Ivan Zheng",
            avatar: "https://drive.google.com/uc?id=1udP6e8-Jo6vuF9T2DvntLy52jfplulNH",
            title: "Sourdough Struggles?",
            description: "I’ve been experimenting with making sourdough bread lately, but my loaves keep coming out dense instead of fluffy and airy. Anyone have tips?",
            time: Date().addingTimeInterval(-10800)
        ),
        Post(
            id: "3",
            name: "Ryan Gomez",
            avatar: "https://drive.google.com/uc?id=1udP6e8-Jo6vuF9T2DvntLy52jfplulNH",
            title: "Chocolate Ganache Cake",
            description: "Does anyone know how to make the perfect ganache? Mine either turns out too thick or too runny, and I’m not sure what I’m doing wrong.",
            time: Date().addingTimeInterval(-86400)
        )
    ]
}
