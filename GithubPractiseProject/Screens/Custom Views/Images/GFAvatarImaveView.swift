//
//  GFAvatarImaveView.swift
//  GithubPractiseProject
//
//  Created by Hady Helal on 21/08/2021.
//

import UIKit

class GFAvatarImaveView: UIImageView {
    let cach = NetworkManager.shared.cach
    let placeholderImage = UIImage(named: "avatar-placeholder")
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure () {
        layer.cornerRadius = 10
        clipsToBounds      = true
        image              = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
    
     func downloadImage(from url : String) {
        let cachKey = NSString(string: url)
        if let image = cach.object(forKey: cachKey) {
            DispatchQueue.main.async {
                self.image = image
                return
            }
        }
        
        guard let url = URL(string: url) else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self     = self else { return }
            guard  error       == nil else { return }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data     = data else { return }
            guard let image    = UIImage(data: data) else { return}
            self.cach.setObject(image, forKey: cachKey)
            DispatchQueue.main.async {
                self.image = image
            }
            
        }
        task.resume()
    }
}
