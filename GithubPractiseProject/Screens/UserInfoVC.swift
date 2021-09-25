//
//  UserInfoVC.swift
//  GithubPractiseProject
//
//  Created by Hady Helal on 25/08/2021.
//

import UIKit
import SafariServices

protocol UserInfoVCDelegate : class {
    func didTappedGitHubProfile(with user : User)
    func didTappedGetFollowers(with user : User)
}

class UserInfoVC: UIViewController {
    
    var headerView  = UIView()
    var itemViewOne = UIView()
    var itemViewTwo = UIView()
    var subViews: [UIView] = []
    var dateLabel = GFBodyLabel(textAlginment: .center)
    var username : String!
    weak var delegate : FollowerListVCDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewController()
        layoutUI()
        getUserDate()
        
    }
    
    private func configureViewController(){
        view.backgroundColor = .systemBackground
        let barButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = barButton
    }
    
    func getUserDate () {
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                self.configureUIViewConrollersElements(with: user)
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Error!", message: error.rawValue, buttonTitle: "Ok")
            }
        }

    }
    
    
    func configureUIViewConrollersElements(with user : User){
        DispatchQueue.main.async {
            let repoItemVC =  GFRepoItemVC(user: user)
            repoItemVC.delegate = self
            
            let followerItemVC = GFFollowerItemVC(user: user)
            followerItemVC.delegate = self
            
            self.addChildVC(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
            self.addChildVC(childVC: repoItemVC, to: self.itemViewOne)
            self.addChildVC(childVC: followerItemVC, to: self.itemViewTwo)
            self.dateLabel.text = "Github since \(user.createdAt.convertToDisplayedFormat())"
            
        }
        print(user)
    }
    @objc func dismissVC(){
        dismiss(animated: true)
    }
    
    func addChildVC(childVC : UIViewController , to containerView : UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    func layoutUI(){
        let padding : CGFloat = 20
        let itemheight : CGFloat = 140
        
        subViews = [headerView,itemViewTwo,itemViewOne , dateLabel]
        for itemView in subViews {
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor , constant: padding),
                itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            ])
        }
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemheight),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemheight),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 18)
            
        ])
    }
}

extension UserInfoVC : UserInfoVCDelegate {
    func didTappedGitHubProfile(with user: User) {
        guard let url = URL(string: user.htmlUrl) else {return}
        presentSafariVC(with: url)
    }
    
    func didTappedGetFollowers(with user: User) {
        print("Did tapped get followers")
        guard user.followers != 0 else {
            presentGFAlertOnMainThread(title: "Uh!", message: "This user has no followers!", buttonTitle: "Ok")
            return
        }
        delegate.didRequestFollower(for: user.login)
        
    }
    
    
}
