//
//  GFTabBarController.swift
//  GithubPractiseProject
//
//  Created by Hady Helal on 20/09/2021.
//

import UIKit

class GFTabBarController: UITabBarController {
   
    override func viewDidLoad() {
        UITabBar.appearance().tintColor = .systemGreen
        viewControllers = [createSearchNC() , createFavoriteVC()]
    }
    
    func createSearchNC() -> UINavigationController {
        let searchVC = SearchVC()
        searchVC.title = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        return UINavigationController(rootViewController: searchVC)
    }
    
    func createFavoriteVC() -> UINavigationController {
        let favoriteVC = FavoriteListVC()
        favoriteVC.title = "Favorite"
        favoriteVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        return UINavigationController(rootViewController: favoriteVC)
    }

}
