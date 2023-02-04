//
//  HomeViewController.swift
//  Story Downloader
//
//  Created by Mohit Kumar Mohit on 08/10/22.
//

import UIKit
import RevenueCat
import SwiftUI

class HomeViewController: UIViewController {
    @IBOutlet weak var collectionViewStories: UICollectionView!
    @IBOutlet weak var tableViewFavorites: UITableView!
    @IBOutlet weak var textfieldSearch: UITextField!
    
    
    
    
    
    let userDefaults = UserDefaults.standard
    var usersFav: [UserUser] = []
    var recentViewed: [UserUser] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        self.hideKeyboardWhenTappedAround()
       
        
       
    }
    
   
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        

        usersFav = []
        let likedUserDict: [String:Any] = userDefaults.object(forKey: "favorites") as? [String:Any] ?? [:]
        for (_, value) in likedUserDict{
            do{
                let unData = try JSONDecoder().decode(UserUser.self, from: value as! Data)
                usersFav.append(unData)
            }catch{
                print(error)
            }
        }
        print("Favorites loaded")
        tableViewFavorites.reloadData()
        
        
        
        recentViewed = []
        let recentUserDict: [String:Any] = userDefaults.object(forKey: "recent") as? [String: Any] ?? [:]
        for (_, value) in recentUserDict{
            do{
                let profileData = try JSONDecoder().decode(UserUser.self, from: value as! Data)
                
                recentViewed.append(profileData)
            } catch{
                print(error)
            }
        }
        print("Recent viewed loaded")
        collectionViewStories.reloadData()
//        self.stopLoader(loader: loader)
        
        
        
        
    }
    
    

    
    func setUpUI(){
        self.collectionViewStories.register(UINib(nibName: "RecentStoriesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "RecentStoriesCollectionViewCell")
        self.tableViewFavorites.register(UINib(nibName: "UsersTableViewCell", bundle: nil), forCellReuseIdentifier: "UsersTableViewCell")
        self.collectionViewStories.delegate = self
        self.collectionViewStories.dataSource = self
        self.tableViewFavorites.delegate = self
        self.tableViewFavorites.dataSource = self
        self.textfieldSearch.delegate = self
    }
    
    

    @IBAction func buttonAccount(_ sender: UIButton){
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "AccountSettingViewController") as? AccountSettingViewController else{return}
        self.navigationController?.pushViewController(vc, animated: true)
    }
}




extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        usersFav.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewFavorites.dequeueReusableCell(withIdentifier: "UsersTableViewCell", for: indexPath) as! UsersTableViewCell
        let dataResults = usersFav[indexPath.row]
        cell.labelUsername.text = dataResults.username
        cell.profilePicture.load(urlString: dataResults.profilePicURL)
        cell.userid = dataResults.pk
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "UserDetailViewController") as? UserDetailViewController else{return}
        let indexTapped = tableView.indexPathForSelectedRow
        let currentCell = tableView.cellForRow(at: indexTapped!) as! UsersTableViewCell
        vc.username = currentCell.labelUsername.text!
        vc.picload = currentCell.profilePicture.image!
        vc.userID = currentCell.userid
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if recentViewed.count <= 10 {
            return recentViewed.count
        } else {
            return 10
            }
}
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionViewStories.dequeueReusableCell(withReuseIdentifier: "RecentStoriesCollectionViewCell", for: indexPath) as! RecentStoriesCollectionViewCell
                let recentResults = recentViewed[indexPath.row]
                cell.username.text = recentResults.username
                cell.profilePic.load(urlString: recentResults.profilePicURL)
                cell.userid = recentResults.pk
                cell.userData = recentResults
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "UserDetailViewController") as? UserDetailViewController else{return}
        guard let currentCell = collectionView.cellForItem(at: indexPath) as? RecentStoriesCollectionViewCell else{return}
        vc.username = currentCell.username.text!
        vc.picload = currentCell.profilePic.image!
        vc.userID = currentCell.userid
        vc.userData = currentCell.userData
        print(currentCell)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}


extension HomeViewController: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textfieldSearch.resignFirstResponder()
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController else{return}
        self.navigationController?.pushViewController(vc, animated: false)
    }
}
