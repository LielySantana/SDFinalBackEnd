//
//  CoinsViewController.swift
//  Story Downloader
//
//  Created by Mohit Kumar Mohit on 08/10/22.
//

import UIKit
import SwiftUI
import StoreKit
import RevenueCat


import SwiftyStoreKit

class SubscriptionViewController: UIViewController{
    
    @IBOutlet weak var collectionView: UICollectionView!
    let header_Arr = ["MONTHLY","BEST OPTION","WEEKLY"]
    let price_Arr = ["$5.99","$29.99","$2.99"]
    let type_Arr = ["MONTHLY","YEARLY","WEEKLY"]
    var selected_Option = -1
    var selection: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        //        collectionView.setContentOffset(CGPoint(x: (collectionView.frame.size.width*0.35)+((collectionView.frame.size.width*0.35)/2), y: 0), animated: true)
        
        collectionView.setContentOffset(CGPoint(x:1, y: 0), animated: true)
        
    }
    
    
    @IBAction func SubscribeBtn(_ sender: UIButton){
        print("Hey")
        Purchases.shared.getCustomerInfo { (customerInfo, error) in
            guard let customerInfo = customerInfo, error == nil else {return}
            
            if self.selection == "MONTHLY"{
                Purchases.shared.getOfferings{ (offerings, error) in
                    guard let offerings = offerings, error == nil else {
                        return
                    }
                    
                    guard let Package = offerings.current?.monthly else {return}
                    print(Package)
                    self.purchase(package: Package)
                }
                
            } else if self.selection == "YEARLY"{
                Purchases.shared.getOfferings{ (offerings, error) in
                    guard let offerings = offerings, error == nil else {
                        return
                    }
                    
                    guard let Package = offerings.current?.annual else {return}
                    print(Package)
                    self.purchase(package: Package)
                }
                
            } else {
                Purchases.shared.getOfferings{ (offerings, error) in
                    guard let offerings = offerings, error == nil else {
                        return
                    }
                    
                    guard let Package = offerings.current?.weekly else {return}
                    print(Package)
                    self.purchase(package: Package)
                }
            }
        }
    }
    
    
    
    
    func purchase(package: Package){
        Purchases.shared.purchase(package: package) { transaction, customerInfo, error, userCancelled in
            
            
        }
    }
    
    func fetcPackage(){
        Purchases.shared.getOfferings{ (offerings, error) in
            guard let offerings = offerings, error == nil else {
                return
            }
            
            guard let monthPackage = offerings.current?.monthly else {return}
            print(monthPackage)
        }
    }
    
    
    
}

extension SubscriptionViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SubscribtionCVC2", for: indexPath) as! SubscribtionCVC2
        cell.HeaderLbl.text = header_Arr[indexPath.row]
        cell.TypeLbl.text = type_Arr[indexPath.row]
        cell.PriceLbl.text = price_Arr[indexPath.row]
        cell.layer.cornerRadius = 10
        cell.clipsToBounds = true
        if indexPath.row == 1 {
            cell.StarImg.isHidden = false
        }else{
            cell.StarImg.isHidden = true
        }
        
        cell.TopView.layer.cornerRadius = 10
        cell.TopView.layer.masksToBounds = true
        cell.TopView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        cell.SelectBtn.tag = indexPath.row
        cell.SelectBtn.addTarget(self, action: #selector(selectedPressed(sender:)), for: .touchUpInside)
        
        
        return cell
    }
    
    @objc func selectedPressed(sender:UIButton){
        selected_Option = sender.tag
        updateCell(tagNo: selected_Option)
    }
    
    func updateCell(tagNo:Int){
       
        for i in 0...2 {
            let path = IndexPath(row: i, section: 0)
            if let cell = collectionView.cellForItem(at: path) as? SubscribtionCVC2
            
            {
                cell.TopView.backgroundColor = UIColor(named: "primary")
                cell.HeaderLbl.textColor = UIColor.white
                cell.TypeLbl.textColor = UIColor(named: "primary")
                cell.SubscriptionLbl.textColor = UIColor(named: "primary")
                cell.SelectBtn.setTitleColor(UIColor.white, for: .normal)

                if i ==  tagNo{
                    print("selectedPressed")
                    cell.BgView.backgroundColor = UIColor.white
                    cell.SelectBtn.backgroundColor = UIColor(named: "primary")
                    cell.PriceLbl.textColor = UIColor(named: "secondary")
                    selection = cell.TypeLbl.text!

                }else{
                    print("else")
                    cell.BgView.backgroundColor = UIColor(displayP3Red: 236.0/255.0, green: 243.0/255.0, blue: 248.0/255.0, alpha: 1.0)
                    cell.SelectBtn.backgroundColor = UIColor(named: "secondary")
                    cell.PriceLbl.textColor = UIColor(named: "primary")
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.size.width*0.35, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.size.width*0.35, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width*0.35, height: collectionView.frame.size.height)
    }
    
    private func applyCellTransform()  {
        let centerX = collectionView.contentOffset.x + (collectionView.frame.size.width) / 2
        for cell in collectionView.visibleCells {
            let offsetX = abs(centerX - cell.center.x)
            cell.transform = CGAffineTransform.identity
            let offsetPercentage = offsetX / (self.view.bounds.width * 2.0)
            let scaleX = 1 - offsetPercentage
            cell.transform = CGAffineTransform(scaleX: scaleX, y: scaleX)
        }
    }

    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        applyCellTransform()
        updateCell(tagNo: selected_Option)

        let visibleRect = CGRect(
            origin: collectionView.contentOffset,
            size: collectionView.bounds.size
        )
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        if let visibleIndexPath = collectionView.indexPathForItem(at: visiblePoint) {
//            pageControlView.currentPage = visibleIndexPath.row
            print(visibleIndexPath.row)
        }
    }
}

class SubscribtionCVC2: UICollectionViewCell{

    @IBOutlet weak var BgView: UIView!
    @IBOutlet weak var TopView: UIView!
    @IBOutlet weak var HeaderLbl: UILabel!
    @IBOutlet weak var TypeLbl: UILabel!
    @IBOutlet weak var SubscriptionLbl: UILabel!
    @IBOutlet weak var PriceLbl: UILabel!
    @IBOutlet weak var SelectBtn: UIButton!
    @IBOutlet weak var StarImg: UIImageView!
}
