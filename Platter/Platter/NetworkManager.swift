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
}
