//
//  GFItemInfoVC.swift
//  GithubPractiseProject
//
//  Created by Hady Helal on 31/08/2021.
//

import UIKit

class GFItemInfoVC: UIViewController {

    let itemInfoViewOne = GFItemInfoView()
    let itemInfoViewTwo = GFItemInfoView()
    let stackView       = UIStackView()
    let actionBtn       = GFButton()
    
    var user : User!
    //Here we do delegate var for the child Vc's
    weak var delegate : UserInfoVCDelegate!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackgroundView()
        layoutUI()
        configureStackView()
        configureActionBtn()

    }

    init(user : User){
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureBackgroundView(){
        view.backgroundColor    = .secondarySystemBackground
        view.layer.cornerRadius = 18
        
    }
    
    func configureActionBtn() {
        actionBtn.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
    }
    
    @objc func actionButtonTapped() { }
    
    private func configureStackView(){
        stackView.axis         = .horizontal
        stackView.distribution = .equalSpacing
        itemInfoViewOne.translatesAutoresizingMaskIntoConstraints = false
        itemInfoViewTwo.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(itemInfoViewOne)
        stackView.addArrangedSubview(itemInfoViewTwo)
    }
    
    private func layoutUI() {
        view.addSubview(stackView)
        view.addSubview(actionBtn)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let padding : CGFloat = 20
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            
            actionBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            actionBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            actionBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            actionBtn.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}
