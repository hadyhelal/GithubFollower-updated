//
//  UIHelper.swift
//  GithubPractiseProject
//
//  Created by Hady Helal on 23/08/2021.
//

import UIKit

struct UIHelper {
    
    static func createThreeColumnFlowLayoud(in view : UIView) -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let padding : CGFloat = 12
        let minimumItemSpacing : CGFloat = 10
        let availiableWidth = width - (padding * 2 ) - ( minimumItemSpacing * 2)
        let itemWidth = availiableWidth / 3
        
        let flowLayout = UICollectionViewFlowLayout()
        
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding , right: padding)
        flowLayout.itemSize     = CGSize(width: itemWidth, height: itemWidth + 40)
        
        return flowLayout
    }
    
}
