//
//  HashtagViewController.swift
//  Story Downloader
//
//  Created by Mohit Kumar Mohit on 08/10/22.
//

import UIKit

class HashtagViewController: UIViewController {
    @IBOutlet weak var collectionViewHashtag: UICollectionView!{
        didSet{
            collectionViewHashtag.delegate = self
            collectionViewHashtag.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonAccount(_ sender: UIButton){
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "AccountSettingViewController") as? AccountSettingViewController else{return}
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


extension HashtagViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionViewHashtag.dequeueReusableCell(withReuseIdentifier: "HashtagCollectionViewCell", for: indexPath) as! HashtagCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionViewHashtag.frame.size.width/4 - 15, height: 30)
    }
    
}
