//
//  GFFollowerItemVC.swift
//  GithubPractiseProject
//
//  Created by Hady Helal on 31/08/2021.
//

import UIKit

class GFFollowerItemVC: GFItemInfoVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureItem()
    }
    
    private func configureItem(){
        itemInfoViewOne.set(itemInfo: .followers, withCount: user.followers)
        itemInfoViewTwo.set(itemInfo: .following, withCount: user.following)
        actionBtn.set(backgroundColor: .systemGreen, title: "Get Followers")
        
    }

    override func actionButtonTapped() {
        delegate.didTappedGetFollowers(with: user)
    }
}
