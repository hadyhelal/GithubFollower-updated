//
//  GFBodyLabel.swift
//  GithubPractiseProject
//
//  Created by Hady Helal on 19/08/2021.
//

import UIKit

class GFBodyLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(textAlginment : NSTextAlignment) {
        super.init(frame: .zero)
        self.textAlignment = textAlginment
        configure()
    }
    
    private func configure() {
        textColor = .secondaryLabel
        font      = UIFont.preferredFont(forTextStyle: .body)
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.75
        lineBreakMode      = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
}
