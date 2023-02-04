//
//  DownloadVC.swift
//  Story Downloader
//
//  Created by Christina Santana on 18/1/23.
//


import UIKit
import AVKit
import AVFoundation
import MediaPlayer
import Photos
//import RevenueCat
import Foundation
import SwiftUI

class DownloadVC: UIViewController {
    
//    @IBOutlet weak var scrollV: UIScrollView!
    @IBOutlet weak var collectionV: UICollectionView!
    @IBOutlet var recentView: UIView!
    @IBOutlet weak var mediaContainer: UIImageView!
    
    @IBOutlet weak var containerV: UIView!
    
    
    
    var player: AVPlayer!
    var mediaDict: [StoriesMedia] = []
    var storiesData: [Storiesdata] = []
    var storiesMedia: [StoriesMedia] = []
    let userDefaults = UserDefaults.standard
    var videoDown: Bool = false
    var storyCover: String = ""
    var storyMediaData: String?
    var storyData: StoriesMedia!
    
   
    //this counter decide whether to
    var displayRecentSection = false
    
    override func viewDidLoad() {
        self.hideKeyboardWhenTappedAround()
        super.viewDidLoad()
        recentView.backgroundColor = UIColor.clear


        self.collectionV.dataSource = self
        self.collectionV.delegate = self
        
        print("This is the dict \(mediaDict.count)")
        
        self.videoDown = loadDownloads(mediaInfo: storyCover)
        
        
        mediaDict = []
        let savedDict: [String:Any] = userDefaults.object(forKey: "mediaStorage") as? [String: Any] ?? [:]
        print(savedDict.keys.count)
        for (_, value) in savedDict{
            do{
                let unData = try JSONDecoder().decode(StoriesMedia.self, from: value as! Data)
                mediaDict.append(unData)
            }catch{
                print(error)
            }
//            print(storyData, "HEREEEEEEEEE COMEEEEEESSSSSSS")
            print(mediaDict, "THIS IS THE MEDIA DICT")
            
            print(value)

        }
        print("Downloaded media loaded===============================")
        print(mediaDict.count)
        collectionV.reloadData()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.videoDown = loadDownloads(mediaInfo: self.storyCover)
        
        
        
       
        
        
      
    }
    
    
    @IBAction func backBtn(_ sender: UIButton) {
        print("touched")
        let vc = storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    

    func loadDownloads(mediaInfo:String)->Bool{
        var storageDict: [String:String] = userDefaults.object(forKey: "mediaStorage") as? [String:String] ?? [:]
        var exist = storageDict[mediaInfo]
        if(exist == nil){
            return false
        }
        return true
    }
    
}



extension DownloadVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if mediaDict.count <= 10{
            return mediaDict.count
        } else {
            return 10
        }
//        2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoryGallery", for: indexPath) as! StoryGallery
        
        let currentMedia = mediaDict[indexPath.row]
        cell.videoImgV.load(urlString: currentMedia.image_versions2!["candidates"]![0].url)
        cell.storyId =  currentMedia
//        print(currentMedia)
        cell.layer.cornerRadius = 5.0
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: floor((collectionView.frame.size.width-52)/3), height: collectionView.frame.size.width/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        displayRecentSection = true
        guard let cell = collectionView.cellForItem(at: indexPath) as? StoryGallery else {return}
        
        
        if (player != nil){
            player.pause()
        }
        
        var videos = cell.storyId.video_versions?.count
        
        
        if (videos != nil){
            let loader = self.loader()
            loader
            let videoContent = cell.storyId.video_versions!
            let videoUrl = URL(string: (videoContent[0].url))
            let videoData = videoContent[0].url
            player = AVPlayer(url: videoUrl!)
            let playerLayer = AVPlayerLayer(player: player)
            playerLayer.frame = cell.videoImgV.bounds
            cell.videoImgV.layer.addSublayer(playerLayer)
            self.stopLoader(loader: loader)
            player.play()
            storyMediaData = videoData //Take the video URL from the array
            print(videoData)
            
            
        }
        else {
            if (player != nil){
                player.pause()
            }
            let loader = self.loader()
            loader
            var imageUrl: String!
            let imageContent: [String: [candidates]?] = cell.storyId.image_versions2!
            for (_, value) in imageContent{
                imageUrl = value![0].url
            }
            storyMediaData = imageUrl!
            print("These are the values\(imageUrl)")
            self.storyCover = imageUrl!
            cell.videoImgV.load(urlString: imageUrl)
            self.stopLoader(loader: loader)
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 40)
    }
    

    
}


