//
//  APICaller.swift
//  FoodApp
//
//  Created by Nikolaos Mikrogeorgiou on 23/11/21.
//

import Foundation

// -MARK: API Caller

final class APICaller {
    
    // enum for error checking the network call
    enum NetworkError: Error {
        case statusIncorrect
        case dataMissing
        case urlMalformed
        case decodingFailed(_ error: Error)
        case unknown(_ error: Error)
    }

    // instance of API (singleton)
    static let shared = APICaller()
    
    private init() {}
    
    // Network call
    public func getRecipes(searchTerm: String, completion: @escaping (Result<APIResponse, NetworkError>) -> Void) {
        
        // create url with a custom query: searchTerm
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.edamam.com"
        urlComponents.path = "/api/recipes/v2"
        urlComponents.queryItems = [
            URLQueryItem(name: "type", value: "public"),
            URLQueryItem(name: "q", value: searchTerm),
            URLQueryItem(name: "app_id", value: "c0fbb46c"),
            URLQueryItem(name: "app_key", value: "6503a4d4eb76389c8be4f5d39ee699b7")
        ]
        
        // check if url is correct
        guard let url = urlComponents.url else {
            completion(.failure(.urlMalformed))
            return
        }
        
        // create task
        let task = URLSession.shared.dataTask(with: url) {data, urlResponse, error in
            // check for general error
            guard error == nil else {
                completion(.failure(.unknown(error!)))
                return
            }
            // check if correct server response is in range 200-399
            guard let httpResponse = urlResponse as? HTTPURLResponse, (200..<400).contains(httpResponse.statusCode) else {
                completion(.failure(.statusIncorrect))
                return
            }
            
            // check if we received data
            guard let data = data else {
                completion(.failure(.dataMissing))
                return
            }
                // we have data, try to decode
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    
                    print("Recipes: \(result.hits.count)")
                    print("\(result._links.next?.href ?? "")")
                    completion(.success(result))
                }
                catch {
                    completion(.failure(.decodingFailed(error)))
                    return
                }
            }
            task.resume()
        }
}

// -MARK: Models

struct APIResponse: Codable {
    let hits: [RecipeLinks]
    let _links: NextLink
}

struct RecipeLinks: Codable {
    let recipe: Recipe
}

struct Recipe: Codable {
    let label: String
    let image: String
    let url: String
    let shareAs: String
    let yield: Int
    let dishType: [String]?
    let ingredientLines: [String]
    let calories: Double
    let totalTime: Double?
    let cuisineType: [String]?
}

struct NextLink: Codable {
    let next: Next?
}

struct Next: Codable {
    let href: String
    let title: String
}
