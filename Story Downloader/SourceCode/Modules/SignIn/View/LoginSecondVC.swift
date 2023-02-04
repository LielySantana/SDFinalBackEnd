//
//  LoginSecondVC.swift
//  StoryDownloader
//
//  Created by krunal on 22/11/22.
//

import UIKit

class LoginSecondVC: UIViewController {
    
    @IBOutlet weak var cv1: UICollectionView!
    @IBOutlet weak var cv2: UICollectionView!
    @IBOutlet weak var cv3: UICollectionView!
    @IBOutlet weak var cv4: UICollectionView!
    
    let numberOfItems = 7
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cv1.isUserInteractionEnabled = false
        cv2.isUserInteractionEnabled = false
        cv3.isUserInteractionEnabled = false
        cv4.isUserInteractionEnabled = false

        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(scrollToNextCell(timer:)), userInfo: cv1, repeats: true);
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(scrollToNextCell(timer:)), userInfo: cv3, repeats: true);
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.cv2.scrollToItem(at: IndexPath(row: self.numberOfItems - 1, section: 0), at: .right, animated: false)
            self.cv4.scrollToItem(at: IndexPath(row: self.numberOfItems - 1, section: 0), at: .right, animated: false)
            Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.scrollToPrevCell(timer:)), userInfo: self.cv2, repeats: true);
            Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.scrollToPrevCell(timer:)), userInfo: self.cv4, repeats: true);
        }
    }
    
    @IBAction func continueBtnPress(_ sender: UIButton) {
        let parentVC = self.parent as! LoginPageVC
        if let vc = parentVC.vcList.last{
            parentVC.setViewControllers([vc], direction: .forward, animated: false, completion: nil)
        }
    }
}


extension LoginSecondVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCVC", for: indexPath) as! ImageCVC
        cell.backgroundColor = UIColor.red
        cell.imgV.image = UIImage(named: "img\(indexPath.row+1)")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.height * 0.6, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if collectionView.tag == 1 ||  collectionView.tag == 3{
            return CGSize(width: (collectionView.frame.size.height * 0.6)/2, height: collectionView.frame.size.height)
        }
        return CGSize(width: 0, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderView", for: indexPath)
        return cell
    }
    
    @objc func scrollToNextCell(timer:Timer){
        if let cv =  timer.userInfo as? UICollectionView{
            let contentOffset = cv.contentOffset;
            cv.contentOffset = CGPoint(x: contentOffset.x + 2, y: contentOffset.y)
            
            let visibleItems = cv.indexPathsForVisibleItems
            if let firstItem = visibleItems.first , firstItem.row == numberOfItems - 1{
                timer.invalidate()
                Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.scrollToPrevCell(timer:)), userInfo: cv, repeats: true)
            }
        }
    }
    
    @objc func scrollToPrevCell(timer:Timer){
        if let cv =  timer.userInfo as? UICollectionView{
            let contentOffset = cv.contentOffset;
            cv.contentOffset = CGPoint(x: contentOffset.x - 2, y: contentOffset.y)
            
            let visibleItems = cv.indexPathsForVisibleItems
            if let firstItem = visibleItems.first , firstItem.row == 0{
                timer.invalidate()
                Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.scrollToNextCell(timer:)), userInfo: cv, repeats: true)
            }
        }
    }
}

