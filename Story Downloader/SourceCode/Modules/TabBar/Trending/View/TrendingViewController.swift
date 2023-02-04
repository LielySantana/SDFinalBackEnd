
//  TrendingViewController.swift
//  Story Downloader
//
//  Created by Mohit Kumar Mohit on 08/10/22.
//

import UIKit
import SwiftUI
import RevenueCat

class TrendingViewController: UIViewController {
    @IBOutlet weak var collectionViewStories: UICollectionView!
    @IBOutlet weak var trendingTextField: UITextField!
//    var trendingData: SearchModel!
    var userData: [UserElement] = []
    var trendUser: [UserUser] = []
    let topUsers: [String] = ["bloomberg", "cnn", "foxnews", "9gag", "loft", "BadBunny", "Linsday", "Jonas", "Ana", "Selena"]
    let userDefaults = UserDefaults.standard
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let loader = self.loader()
        
        
        
        self.collectionViewStories.register(UINib(nibName: "RecentStoriesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "RecentStoriesCollectionViewCell")
        self.collectionViewStories.delegate = self
        self.collectionViewStories.dataSource = self
        
        
        trendingLoad()
        
        
        self.stopLoader(loader: loader)
        
        self.hideKeyboardWhenTappedAround() 
        // Do any additional setup after loading the view.
    }
    @IBAction func buttonAccount(_ sender: UIButton){
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "AccountSettingViewController") as? AccountSettingViewController else{return}
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func searchButton(_ sender: UIButton) {
        var date: String? = self.getDate()
        print(date)
        
        Purchases.shared.getCustomerInfo {  (customerInfo, error) in
            guard let customerInfo = customerInfo, error == nil else {return}
            
            if customerInfo.entitlements.active.isEmpty == false {
                if(self.trendingTextField.text != ""){
                    let loader = self.loader()
                    self.checkText(text: self.trendingTextField.text!)
                    self.TrendingContent(text: (self.trendingTextField.text!))
                    self.stopLoader(loader: loader)
                    }else{
                   print("Empty field")
                }
                
            } else {
                print("Customer doesn't have an active Subscription")
                var searchDates : [String:String] = self.userDefaults.object(forKey: "searchDates") as? [String:String] ?? [:]
                if searchDates.keys.contains(date!){
                    self.purchaseAlert()
                } else {
                   searchDates[date!] = date!
                    self.userDefaults.set(searchDates, forKey: "searchDates")
                    print(searchDates)
                    if(self.trendingTextField.text != ""){
                        let loader = self.loader()
                        self.checkText(text: self.trendingTextField.text!)
                        self.TrendingContent(text: (self.trendingTextField.text!))
                        self.stopLoader(loader: loader)
                        }else{
                       print("Empty field")
                    }
                }

            }
           
        }
    }
    
    func getDate() -> String{
        let date = Date()
        let index = "\(date)".index("\(date)".startIndex, offsetBy: 10)
        let mySubstring = "\(date)".prefix(upTo: index)
        print (mySubstring)
        return String(mySubstring)
    }
    
    func purchaseAlert() ->UIAlertController{
        let alert = UIAlertController(title: "Oops!", message: "You only can share content once daily, please buy a Subscription to get unlimited content to share", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (action: UIAlertAction!) in
          print("Handle Ok logic here")
          }))
        self.present(alert, animated: true, completion: nil)
        return alert
    }
    

    func trendingLoad(){
        
            self.topUsers.forEach{ user in
                trendingSearch.getSearch(query: user){
                   data in
                    self.userData.append(data.users[0])
                    self.userData.append(data.users[1])
                    DispatchQueue.main.async{
                        print(self.userData)
                        self.collectionViewStories.reloadData()
                    }
            }
               
  }


        
        
        
}
    
    func TrendingContent (text: String){
        trendingSearch.getSearch(query: text){
        data in
        DispatchQueue.main.async {
            self.userData = data.users
            self.collectionViewStories.reloadData()
                    }
                        
                }
              
        }

    let trendingSearch = searchViewModel()
}


extension TrendingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          return userData.count
        }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionViewStories.dequeueReusableCell(withReuseIdentifier: "RecentStoriesCollectionViewCell", for: indexPath) as! RecentStoriesCollectionViewCell
        let topUser = userData[indexPath.row]
        cell.username.text = topUser.user.username
        cell.profilePic.load(urlString: topUser.user.profilePicURL)
        cell.userid = topUser.user.pk
        cell.userData = topUser.user
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 175)
    }
    
}
