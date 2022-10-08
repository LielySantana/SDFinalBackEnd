//
//  UserDetailViewController.swift
//  Story Downloader
//
//  Created by Mohit Kumar Mohit on 09/10/22.
//

import UIKit

class UserDetailViewController: UIViewController {
    @IBOutlet weak var collectionViewStories: UICollectionView!
    @IBOutlet weak var bgViewDownloadHint: UIView!
    @IBOutlet weak var bgViewStory: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        bgViewDownloadHint.isHidden = false
        bgViewStory.isHidden = true
        self.collectionViewStories.register(UINib(nibName: "StoriesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "StoriesCollectionViewCell")
        self.collectionViewStories.delegate = self
        self.collectionViewStories.dataSource = self
        // Do any additional setup after loading the view.
    }
    @IBAction func buttonBack(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }

}


extension UserDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionViewStories.dequeueReusableCell(withReuseIdentifier: "StoriesCollectionViewCell", for: indexPath) as! StoriesCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        bgViewDownloadHint.isHidden = true
        bgViewStory.isHidden = false
    }
    
    
}
