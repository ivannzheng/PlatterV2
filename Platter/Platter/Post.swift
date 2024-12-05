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
    let avatar: String //image url
    //var likes: Int
    let title: String
    let message: String
    let time: Date
}
