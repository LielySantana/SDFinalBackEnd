//
//  UserDetailViewController.swift
//  Story Downloader
//
//  Created by Mohit Kumar Mohit on 09/10/22.
//

import UIKit
import AVKit
import AVFoundation
import MediaPlayer
import Photos
import RevenueCat
import Foundation
import SwiftUI

class UserDetailViewController: UIViewController {
    @IBOutlet weak var collectionViewStories: UICollectionView!
    @IBOutlet weak var bgViewStory: UIView!
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var Username: UILabel!
    @IBOutlet weak var imageContainer: UIImageView!
    @IBOutlet weak var videoContainer: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var DownloadStory: UIButton!
    
    
    var userID: Int!
    var storiesData: [Storiesdata] = []
    var storiesMedia: [StoriesMedia] = []
    var username: String = ""
    var picload: UIImage!
    var player: AVPlayer!
    //Favorite users declarations
    let userDefaults = UserDefaults.standard
    var liked: Bool = false
    var userData: UserUser!
    var storyMediaData: String?
    var storyData: StoriesMedia!
    var videoMedia: StoriesMedia!
    var preview: candidates!
    var videosDict: [StoriesMedia] = []
    var storyCover: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDate()
        getExpDate()
        
        bgViewStory.isHidden = true

        self.collectionViewStories.register(UINib(nibName: "StoriesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "StoriesCollectionViewCell")
        self.collectionViewStories.delegate = self
        self.collectionViewStories.dataSource = self
        
        Username.text = self.username
        profilePic.image = picload
        self.storiesContent(text: userID)
        
        
        self.liked = existInLike(userInfo: username)
        if(liked){
            //            likeButton.backgroundColor = .red
            likeButton.tintColor = .red
        }
        else{
            likeButton.backgroundColor = .white
            likeButton.tintColor = .gray
        }
    }

    let vc = SubscriptionViewController?.self
    

    
    //Favorite users
    @IBAction func favUser(_ sender: UIButton) {
    
        Purchases.shared.getCustomerInfo {  (customerInfo, error) in
            guard let customerInfo = customerInfo, error == nil else {return}
        
            if customerInfo.entitlements.active.isEmpty == false {
            
                if self.likeButton.tintColor == .gray {
                    self.like()
                }else{
                    self.likeButton.tintColor = .gray
                    
                    
                    //remove user from favList
                    var favDict: [String:Any] = self.userDefaults.object(forKey: "favorites") as? [String:Any] ?? [:]
                    favDict.removeValue(forKey: self.username)
                    self.userDefaults.set(favDict, forKey: "favorites")
                    print("Removed")
                    print(favDict.keys.count)
                }
          
            } else {
                print("Customer doesn't have an active Subscription")
                    self.premiumAlert()
                }
            }
        }

    //Download videos
    func downVid(){
        print(videoMedia)
        var storiesData : [String:Any] = userDefaults.object(forKey: "mediaStorage") as? [String:Any] ?? [:]
        do{
            let encoder = JSONEncoder()
            let data = try encoder.encode(videoMedia)
            storiesData[storyCover] = data
            userDefaults.set(storiesData, forKey: "mediaStorage")
            print("Story Saved")
            print(storiesData.keys.count)
            
        }catch{
            print(error)
        }
        
        

       
    }

    
    
    func like(){
        likeButton.tintColor = .red
        
        var favorites: [String:Any] = userDefaults.object(forKey: "favorites") as? [String:Any] ?? [:]
        do{
            let encoder = JSONEncoder()
            let data = try encoder.encode(userData)
            favorites[username] = data
            userDefaults.set(favorites, forKey: "favorites")
            print("Favorite added")
            print(favorites.keys.count)
            
        }catch{
            print(error)
        }
    }
    
    
    func existInLike(userInfo:String)->Bool{
        var favDict: [String:Any] = userDefaults.object(forKey: "favorites") as? [String:Any] ?? [:]
        var exist = favDict[userInfo]
        if(exist == nil){
            return false
        }
        return true
    }
    
    func recent(){
        var recent: [String:Any] = userDefaults.object(forKey: "recent") as? [String:Any] ?? [:]
        do{
            let encoder = JSONEncoder()
            let data = try encoder.encode(userData)
            recent[username] = data
            userDefaults.set(recent, forKey: "recent")
            print("Added recent story view")
            print(recent.keys.count)
            
        }catch{
            print(error)
        }
    }
    
    func getDate() -> String{
        let date = Date()
        let index = "\(date)".index("\(date)".startIndex, offsetBy: 10)
        let mySubstring = "\(date)".prefix(upTo: index)
        print (mySubstring)
        return String(mySubstring)
    }
    
    
    
    func getExpDate() -> String{
        var dayComponent = DateComponents()
        dayComponent.day = 3
        let currentDate = Date()
        let expDate = Calendar.current.date(byAdding: dayComponent, to: currentDate)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let actDate = dateFormatter.string(from: expDate!)
        print(actDate)
        return String(actDate)
    }
    
    
    func premiumAlert() ->UIAlertController{
        let alert = UIAlertController(title: "Oops!", message: "You only can access to this feature if you get a subscription, please buy a became Pro.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (action: UIAlertAction!) in
          print("Handle Ok logic here")
          }))
        self.present(alert, animated: true, completion: nil)
        return alert
    }
    
    
    func purchaseAlert() ->UIAlertController{
        let alert = UIAlertController(title: "Oops!", message: "You only can share content once daily, please buy a Subscription to get unlimited content to share", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (action: UIAlertAction!) in
          print("Handle Ok logic here")
          }))
        self.present(alert, animated: true, completion: nil)
        return alert
    }
    
    
    
    @IBAction func ShareStory(_ sender: UIButton) {
        var date: String? = self.getDate()
        var actDate: String? = self.getExpDate()
        print(date!, "to", actDate!)
        
        
        var proDate : [String:String] = self.userDefaults.object(forKey: "proDate") as? [String:String] ?? [:]
        
        var storageData : [String:Any] = self.userDefaults.object(forKey: "mediaStorage") as? [String:Any] ?? [:]
        
        
        if (proDate[actDate!] == date){
            Purchases.shared.getCustomerInfo {  (customerInfo, error) in
                guard let customerInfo = customerInfo, error == nil else {return}
            
                if customerInfo.entitlements.active.isEmpty == false {
                    self.share()
                } else {
                    print("Customer doesn't have an active Subscription")
                    var downDates : [String:String] = self.userDefaults.object(forKey: "downDates") as? [String:String] ?? [:]
                    if downDates.keys.contains(date!){
                        self.purchaseAlert()
                    } else {
                        downDates[date!] = date!
                        self.userDefaults.set(downDates, forKey: "downDates")
                        self.share()
                    }
                }
            }
            
        } else{
            proDate[actDate!] = actDate!
            self.userDefaults.set(proDate, forKey: "proDate")
            
            
            
            if storageData[storyCover] as! String == storyCover{
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "DownloadVC") as? DownloadVC
                vc?.storyCover = self.storyCover!
                vc?.storyData = self.videoMedia
                self.navigationController?.pushViewController(vc!, animated: true)
                
            } else {
                self.downVid()
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "DownloadVC") as? DownloadVC
                vc?.storyCover = self.storyCover!
                self.navigationController?.pushViewController(vc!, animated: true)
            }
            
        }
     
    }
    
    

    
    func share(){

            guard let urlData =  NSData(contentsOf: NSURL(string: storyMediaData!)! as URL) else {
                print("No video found")
                return
            }
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "DownloadVC") as? DownloadVC
       
            if (storyMediaData!.contains("jpg")){
                //Share case for images
                let objectsToShare = [urlData] as [Any]
                let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
                activityVC.popoverPresentationController?.sourceView = view
                activityVC.popoverPresentationController?.sourceRect = view.frame
                self.present(activityVC, animated: true, completion: nil)
                

                vc?.storyCover = storyCover!
                
                
            }else if (storyMediaData!.contains("mp4")){
                //Share case for videos
                let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
                let docDirectory = paths[0]
                let filePath = "\(docDirectory)/tmpVideo.mov"
                urlData.write(toFile: filePath, atomically: true)
                // File Saved
                let videoLink = NSURL(fileURLWithPath: filePath)
                let objectToShare = [videoLink] //comment!, imageData!, myWebsite!]
                let activitysVC = UIActivityViewController(activityItems: objectToShare, applicationActivities: nil)
                activitysVC.setValue("Video", forKey: "subject")
                self.present(activitysVC, animated: true, completion: nil)
                
                
                
            }
        
    }
    
    @IBAction func buttonBack(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    
    //Call of the View Model
    let storiesSearch = UserViewModel()
    
    
    //Active Stories Endpoint Instance
    func storiesContent (text: Int){
        storiesSearch.getStories(query: text){
            data in
            DispatchQueue.main.async {
                //local storage
                self.storiesData = data.Sdata
                self.storiesMedia = data.storiesMedia
                self.collectionViewStories.reloadData()
            }
        }
    }
}
    
    extension UserDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource{
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return storiesData.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let currentMedia = storiesMedia[indexPath.item]
            let cell = collectionViewStories.dequeueReusableCell(withReuseIdentifier: "StoriesCollectionViewCell", for: indexPath) as! StoriesCollectionViewCell
            var currentStoryPreview = currentMedia.image_versions2!["candidates"]![0].url
            cell.storiesProjection.load(urlString: currentStoryPreview)
            cell.storyMedia = currentMedia
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            guard let cell = collectionView.cellForItem(at: indexPath) as? StoriesCollectionViewCell else{return}
            recent()
            
            
            
            
            if (player != nil){
                player.pause()
            }
            
            var videos = cell.storyMedia.video_versions?.count
            
            
            if (videos != nil){
                let loader = self.loader()
                loader
                imageContainer.isHidden = true
                videoContainer.isHidden = false
                let videoContent = cell.storyMedia.video_versions!
                let videoUrl = URL(string: (videoContent[0].url))
                let videoData = videoContent[0].url
                player = AVPlayer(url: videoUrl!)
                let playerLayer = AVPlayerLayer(player: player)
                playerLayer.frame = self.videoContainer.bounds
                self.videoContainer.layer.addSublayer(playerLayer)
                self.stopLoader(loader: loader)
                player.play()
                storyMediaData = videoData
                self.storyCover = cell.storyMedia.image_versions2!["candidates"]![0].url
                print(videoData)
                
                
            }
            else {
                if (player != nil){
                    player.pause()
                }
                let loader = self.loader()
                loader
                videoContainer.isHidden = true
                imageContainer.isHidden = false
                
                var imageUrl: String!
                let imageContent: [String: [candidates]?] = cell.storyMedia.image_versions2!
                for (_, value) in imageContent{
                    imageUrl = value![0].url
                }
                storyMediaData = imageUrl!
                print("These are the values\(imageUrl)")
                self.storyCover = imageUrl!
                self.imageContainer.load(urlString: imageUrl)
                self.stopLoader(loader: loader)
            }
            
            bgViewStory.isHidden = false
        }
    }

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
    
