//
//  NetworkManager.swift
//  Platter
//
//  Created by Yuan Gao on 12/2/24.
//

import Alamofire
import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private let decoder = JSONDecoder()
    
    private init() {}

    func fetchRecipes(completion: @escaping ([Recipe]) -> Void) {
        let url = "https://api.jsonbin.io/v3/b/64d033f18e4aa6225ecbcf9f?meta=false"
        decoder.dateDecodingStrategy = .iso8601
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        AF.request(url, method: .get)
            .validate()
            .responseDecodable(of: [Recipe].self, decoder: decoder) { response in
                switch response.result {
                case .success(let recipes):
                    completion(recipes)
                    print("Successfully fetched recipes")
                case .failure(let error):
                    print("Error fetching recipes: \(error)")
                }
            }
    }
    
    // MARK: - Requests
    func fetchPosts(completion: @escaping ([Post]) -> Void) {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        // convert keys to camel case
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let endPoint = "https://chatdev-wuzwgwv35a-ue.a.run.app/api/posts/create/"
        AF.request(endPoint, method: .get)
            .validate()
            .responseDecodable(of: [Post].self, decoder: decoder) { response in
                switch response.result {
                    case .success(let posts):
                    completion(posts)
                    print("Successfully fetched \(posts.count) posts")
                    case .failure(let error):
                        print("Error in NetworkManager.fetchPosts: ", error)
                }
            }
    }
    
    func addToPosts (post: Post, completion: @escaping ((Post) -> Void)) {
        let parameters: Parameters = [
            "id": post.id,
            "time": post.time,
            "name": post.name,
            "avatar": post.avatar,
            "title": post.title,
            "description": post.description,
        ]
        let endPoint = "https://chatdev-wuzwgwv35a-ue.a.run.app/api/posts/create/"
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        AF.request(endPoint, method: .post, parameters: parameters)
            .validate()
            .responseDecodable(of: Post.self, decoder: decoder) { response in
                switch response.result {
                    case .success(let post):
                        completion(post)
                    print("Successfully added \(post.description) to posts")
                    case .failure(let error):
                        print("Error in NetworkManager.addToPosts: ", error)
                }
            }
    }
}
