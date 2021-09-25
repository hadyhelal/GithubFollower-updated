//
//  UIViewController + Ext.swift
//  GithubPractiseProject
//
//  Created by Hady Helal on 19/08/2021.
//

import UIKit
import SafariServices

fileprivate var contentView : UIView!
extension UIViewController {
    
    func presentGFAlertOnMainThread(title : String , message : String , buttonTitle : String){
        DispatchQueue.main.async {
            let alertVC = GFAlertVC(title: title, message: message, buttonTitel: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle   = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    
    func presentSafariVC(with url : URL){
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredBarTintColor = .secondaryLabel
        present(safariVC, animated: true)
    }
    
    func showLoadingScreen(){
        contentView = UIView(frame: view.bounds)
        view.addSubview(contentView)
        contentView.backgroundColor = .systemBackground
        contentView.alpha           = 0
        let activitiIndicator = UIActivityIndicatorView(style: .large)
        activitiIndicator.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(activitiIndicator)

        NSLayoutConstraint.activate([
            activitiIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            activitiIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
        
        UIView.animate(withDuration: 0.25) { contentView.alpha = 0.8  }
        activitiIndicator.startAnimating()
    }
    
    func stopLoadingScreen(){
        DispatchQueue.main.async {
            guard contentView != nil else {return}
            contentView.removeFromSuperview()
            contentView = nil
        }
    }
    
    func showEmptyStateView(message : String , in view : UIView){
        let emptyState = GFEmptyStateView(message: message)
        emptyState.frame = view.bounds
        view.addSubview(emptyState)
    }
}
