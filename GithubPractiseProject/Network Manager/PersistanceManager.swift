//
//  PersistanceManager.swift
//  GithubPractiseProject
//
//  Created by Hady Helal on 09/09/2021.
//

import Foundation

enum persistanceActionType { case add , remove }

enum PersistanceManager {
    static var defaults = UserDefaults.standard
    
    enum key {
        static var favorites = "favorites"
    }
    
    static func updateWith(favorite : Follower, actionType : persistanceActionType ,completed : @escaping (GFError?)-> Void) {
        retrieveFavorites { (result) in
            switch result {
            case .success(let favorites):
                var favoritedArray = favorites
                
                switch actionType {
                case .add:
                    guard !favoritedArray.contains(favorite) else {
                        completed(.alreadyFavorited)
                        return
                    }
                    
                    favoritedArray.append(favorite)
                case .remove:
                    favoritedArray.removeAll {$0.login == favorite.login}
                }
                
                completed(saveFavorites(followers: favoritedArray))
                
            case .failure(let error):
            completed(error)
            }
        }
    }
    
    static func retrieveFavorites(completed: @escaping (Result<[Follower], GFError>) -> Void) {
        guard let favoritesData = defaults.object(forKey: key.favorites) as? Data else {
            completed(.success([]))
            return
        }
        
        do{
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: favoritesData)
            completed(.success(favorites))
        }catch{
            completed(.failure(.unableToFavorite))
        }
    }
    
    static func saveFavorites(followers : [Follower]) -> GFError? {
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(followers)
            defaults.setValue(encodedFavorites, forKey: key.favorites)
            return nil
        }catch{
            return .unableToFavorite
        }
        
    }
}
