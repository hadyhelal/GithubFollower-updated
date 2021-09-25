//
//  ErrorMessage.swift
//  GithubPractiseProject
//
//  Created by Hady Helal on 21/08/2021.
//

import Foundation

enum GFError : String , Error {
    case invalidUsername  = "Invalid URL"
    case unableToComplete = "Plaease check your internet connection and try again."
    case invalidResponse  = "Invalid response from the server"
    case invalidData      = "Invalid data have been recieved!"
    case unableToFavorite = "There was an error favorting this user please try again!"
    case alreadyFavorited = "You already favorited this one"
}
