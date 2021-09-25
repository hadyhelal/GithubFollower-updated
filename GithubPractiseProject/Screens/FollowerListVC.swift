//
//  FollowerListVC.swift
//  GithubPractiseProject
//
//  Created by Hady Helal on 19/08/2021.
//

import UIKit

protocol FollowerListVCDelegate : class {
    func didRequestFollower(for username : String)
}

class FollowerListVC: UIViewController {

    var username : String!
    var collectionView : UICollectionView!
    var followers = [Follower]()
    var filterFollower = [Follower]()
    var page = 1
    var hasMoreFollower = true
    var isSearching = false
    
    enum Section {
        case main
    }
    let bound : CGRect = CGRect(x: 12, y: 12, width: 12, height: 12)
    var dataSource : UICollectionViewDiffableDataSource<Section, Follower>!
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewController()
        configreCollectionView()
        configureSearchController()
        getFollowers(username: username, page: page)
        configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        //navigationController?.isNavigationBarHidden = false
        

    }
    
    func configureViewController(){
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let addBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBtnTapped))
        navigationItem.rightBarButtonItem = addBtn
    }
    
    @objc func addBtnTapped() {
        showLoadingScreen()
        NetworkManager.shared.getUserInfo(for: username) {[weak self] (result) in
            guard let self = self else { return }
            self.stopLoadingScreen()
            switch result {
            case .success(let user):
                let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
                
                PersistanceManager.updateWith(favorite: favorite , actionType: .add) { [weak self] error in
                    guard let self = self else { return }
                    
                    guard let error = error else {
                        self.presentGFAlertOnMainThread(title: "Done!", message: "You have successfully favorited this user ", buttonTitle: "Ok")
                        return
                    }
                    
                    self.presentGFAlertOnMainThread(title: "Error", message: error.rawValue, buttonTitle: "Ok")
                }
                
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Error", message: error.rawValue, buttonTitle: "Ok")
            }
        }
        
       
    }
    func configreCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayoud(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.cellID)
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section,Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexpath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.cellID, for: indexpath) as! FollowerCell
            cell.set(follower: follower)
            
            return cell
        })
    }
    
    func updateData(on followers : [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section,Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
        
    }
    
    func configureSearchController(){
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search for a username"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
    }
    
    func getFollowers(username : String , page : Int) {
        showLoadingScreen()
        NetworkManager.shared.getFollowers(for: username, page: page) {[weak self] (result) in
            guard let self = self else { return }
            self.stopLoadingScreen()
            switch result{
            case .success(let followers):
                if followers.count < 100 { self.hasMoreFollower = false }
                self.followers.append(contentsOf: followers)
                if followers.isEmpty {
                    let message = "This user has no followers right now go follow him!"
                    self.showEmptyStateView(message: message, in: self.view)
                }
                
                self.updateData(on: self.followers)
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Error", message: error.rawValue, buttonTitle: "Ok")
                
            }
        }
    }

}

extension FollowerListVC : UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY       = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height        = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard hasMoreFollower else { return }
            page += 1
            getFollowers(username : username , page : page)
            print("Did Get more followers / num of pages are: \(page)")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeFollowers = isSearching ? filterFollower : followers
        let follower        = activeFollowers[indexPath.row]
        let userInfoVC      = UserInfoVC()
        let navUserinfo     = UINavigationController(rootViewController: userInfoVC)
        userInfoVC.username = follower.login
        userInfoVC.delegate = self
        present(navUserinfo, animated: true)
        
    }
}

extension FollowerListVC : UISearchResultsUpdating , UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text , !filter.isEmpty else { return }
        filterFollower = followers.filter{ $0.login.lowercased().contains(filter.lowercased()) }
        updateData(on: filterFollower)
        isSearching = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        updateData(on: followers)
        isSearching = false
    }
}

extension FollowerListVC : FollowerListVCDelegate {
    func didRequestFollower(for username: String) {
        self.username = username
        title         = username
        page          = 1
        followers.removeAll()
        filterFollower.removeAll()
        collectionView.setContentOffset(.zero, animated: true)
        getFollowers(username: username, page: page)
        dismiss(animated: true)
    }
    
    
}

