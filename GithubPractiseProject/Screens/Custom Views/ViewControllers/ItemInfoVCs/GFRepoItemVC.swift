//
//  GFRepoItemVC.swift
//  GithubPractiseProject
//
//  Created by Hady Helal on 31/08/2021.
//

import UIKit

class GFRepoItemVC: GFItemInfoVC {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItem()
    }
    
    private func configureItem(){
        itemInfoViewOne.set(itemInfo: .repos, withCount: user.publicRepos)
        itemInfoViewTwo.set(itemInfo: .gists, withCount: user.publicGists)
        actionBtn.set(backgroundColor: .systemPurple, title: "Github Profile")
        
    }
    
    override func actionButtonTapped() {
        delegate.didTappedGitHubProfile(with: user)
        
    }


}
