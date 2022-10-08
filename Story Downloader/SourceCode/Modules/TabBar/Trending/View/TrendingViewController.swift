//
//  TrendingViewController.swift
//  Story Downloader
//
//  Created by Mohit Kumar Mohit on 08/10/22.
//

import UIKit

class TrendingViewController: UIViewController {
    @IBOutlet weak var collectionViewStories: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionViewStories.register(UINib(nibName: "RecentStoriesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "RecentStoriesCollectionViewCell")
        self.collectionViewStories.delegate = self
        self.collectionViewStories.dataSource = self
        // Do any additional setup after loading the view.
    }
    @IBAction func buttonAccount(_ sender: UIButton){
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "AccountSettingViewController") as? AccountSettingViewController else{return}
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension TrendingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       24
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionViewStories.dequeueReusableCell(withReuseIdentifier: "RecentStoriesCollectionViewCell", for: indexPath) as! RecentStoriesCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 175)
    }
    
}
