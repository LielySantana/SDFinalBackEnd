//
//  HomeViewController.swift
//  Story Downloader
//
//  Created by Mohit Kumar Mohit on 08/10/22.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var collectionViewStories: UICollectionView!
    @IBOutlet weak var tableViewFavorites: UITableView!
    @IBOutlet weak var textfieldSearch: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
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
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewFavorites.dequeueReusableCell(withIdentifier: "UsersTableViewCell", for: indexPath) as! UsersTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "UserDetailViewController") as? UserDetailViewController else{return}
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionViewStories.dequeueReusableCell(withReuseIdentifier: "RecentStoriesCollectionViewCell", for: indexPath) as! RecentStoriesCollectionViewCell
        return cell
    }
    
    
}


extension HomeViewController: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController else{return}
        self.navigationController?.pushViewController(vc, animated: false)
    }
}
