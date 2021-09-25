//
//  GFItemInfoView.swift
//  GithubPractiseProject
//
//  Created by Hady Helal on 31/08/2021.
//

import UIKit

enum ItemInfoType {
    case gists , following , followers , repos
}

class GFItemInfoView: UIView {

    let sympolImageView = UIImageView()
    let titleLabel      = GFTitleLabel(textAlginment: .left, fontSize: 14)
    let countLabel      = GFTitleLabel(textAlginment: .center, fontSize: 14 )
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        addSubview(sympolImageView)
        addSubview(titleLabel)
        addSubview(countLabel)
        sympolImageView.translatesAutoresizingMaskIntoConstraints = false
        sympolImageView.tintColor   = .label
        sympolImageView.contentMode = .scaleAspectFill
        NSLayoutConstraint.activate([
            sympolImageView.topAnchor.constraint(equalTo: self.topAnchor),
            sympolImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            sympolImageView.widthAnchor.constraint(equalToConstant: 20),
            sympolImageView.heightAnchor.constraint(equalToConstant: 20),
            
            titleLabel.centerYAnchor.constraint(equalTo: sympolImageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: sympolImageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 18),
            
            countLabel.topAnchor.constraint(equalTo: sympolImageView.bottomAnchor, constant: 4),
            countLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    func set(itemInfo : ItemInfoType , withCount count : Int) {
        switch itemInfo {
        case .gists:
            sympolImageView.image = UIImage(systemName: SFSympols.gists)
            titleLabel.text       = "Public Gists"
        case .repos:
            sympolImageView.image = UIImage(systemName: SFSympols.repos)
            titleLabel.text       = "Public Repos"
        case .following:
            sympolImageView.image = UIImage(systemName: SFSympols.following)
            titleLabel.text       = "Public Following"
        case .followers:
            sympolImageView.image = UIImage(systemName: SFSympols.followers)
            titleLabel.text       = "Public Followers"
        }
        countLabel.text = "\(count)"
    }
    
}
