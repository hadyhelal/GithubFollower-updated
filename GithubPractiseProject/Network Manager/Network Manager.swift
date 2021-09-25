//
//  Network Manager.swift
//  GithubPractiseProject
//
//  Created by Hady Helal on 21/08/2021.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    let cach   = NSCache<NSString ,UIImage>()
    let baseUrl = "https://api.github.com/users/"
    let perBageFollower = 100
    
    private init () {}
    
    func getFollowers(for username : String, page : Int, completed : @escaping (Result<[Follower] , GFError>) -> Void){
        let endPoint = baseUrl + "\(username)/followers?per_page=\(perBageFollower)&page\(page)"
        
        guard let url = URL(string: endPoint) else {
            completed(.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.invalidResponse))
            }
            
            guard let response = response as? HTTPURLResponse , response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completed(.success(followers))
            }catch{
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    func getUserInfo(for username : String, completed : @escaping (Result<User , GFError>) -> Void){
        let endPoint =  baseUrl + "\(username)"
        
        guard let url = URL(string: endPoint) else {
            completed(.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.invalidResponse))
            }
            
            guard let response = response as? HTTPURLResponse , response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let user = try decoder.decode(User.self, from: data)
                completed(.success(user))
            }catch{
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
}
