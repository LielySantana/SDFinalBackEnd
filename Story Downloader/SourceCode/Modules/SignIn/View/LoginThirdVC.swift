//
//  LoginThirdVC.swift
//  StoryDownloader
//
//  Created by krunal on 22/11/22.
//


import UIKit
import RevenueCat

class LoginThirdVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    let headerArr = ["MONTHLY","BEST OPTION","WEEKLY"]
    let priceArr = ["$5.99","$29.99","$2.99"]
    let typeArr = ["MONTHLY","YEARLY","WEEKLY"]
    var selectedOption = -1
    var selection: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        Purchases.shared.getOfferings{ (offerings, error) in
            guard let offerings = offerings, error == nil else {
                return
            }
            
            guard let Package = offerings.current?.annual else {return}
            print(Package)
            self.purchase(package: Package)
          
            
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
                
//        collectionView.setContentOffset(CGPoint(x: (collectionView.frame.size.width*0.35)+((collectionView.frame.size.width*0.35)/2), y: 0), animated: true)
        
        collectionView.setContentOffset(CGPoint(x:1, y: 0), animated: true)
        
    }
    
    @IBAction func cancelBtn(_ sender: UIButton) {
        kSharedAppDelegate?.moveToTabBar(selectedIndex: 0)
    }
    
    
    @IBAction func continueBtn(_ sender: UIButton) {
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
                    kSharedAppDelegate?.moveToTabBar(selectedIndex: 0)
                }
                
            } else if self.selection == "WEEKLY"{
                Purchases.shared.getOfferings{ (offerings, error) in
                    guard let offerings = offerings, error == nil else {
                        return
                    }
                    
                    guard let Package = offerings.current?.weekly else {return}
                    print(Package)
                    self.purchase(package: Package)
                    kSharedAppDelegate?.moveToTabBar(selectedIndex: 0)
                }
                
            } else {
                Purchases.shared.getOfferings{ (offerings, error) in
                    guard let offerings = offerings, error == nil else {
                        return
                    }
                    
                    guard let Package = offerings.current?.annual else {return}
                    print(Package)
                    self.purchase(package: Package)
                    kSharedAppDelegate?.moveToTabBar(selectedIndex: 0)
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

extension LoginThirdVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SubscribtionCVC", for: indexPath) as! SubscribtionCVC
        cell.headerLbl.text = headerArr[indexPath.row]
        cell.typeLbl.text = typeArr[indexPath.row]
        cell.priceLbl.text = priceArr[indexPath.row]
        cell.layer.cornerRadius = 10
        cell.clipsToBounds = true
        if indexPath.row == 1 {
            cell.starImgV.isHidden = false
        }else{
            cell.starImgV.isHidden = true
        }
        
        cell.topView.layer.cornerRadius = 10
        cell.topView.layer.masksToBounds = true
        cell.topView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        cell.selectBtn.tag = indexPath.row
        cell.selectBtn.addTarget(self, action: #selector(selectedPressed(sender:)), for: .touchUpInside)
        
        
        return cell
    }
    
    @objc func selectedPressed(sender:UIButton){
        selectedOption = sender.tag
        updateCell(tagNo: selectedOption)
    }
    
    func updateCell(tagNo:Int){
        for i in 0...2 {
            let path = IndexPath(row: i, section: 0)
            if let cell = collectionView.cellForItem(at: path) as? SubscribtionCVC{
                cell.topView.backgroundColor = UIColor(named: "primary")
                cell.headerLbl.textColor = UIColor.white
                cell.typeLbl.textColor = UIColor(named: "primary")
                cell.subscrptionLbl.textColor = UIColor(named: "primary")
                cell.selectBtn.setTitleColor(UIColor.white, for: .normal)

                if i ==  tagNo{
                    print("selectedPressed")
                    cell.bgView.backgroundColor = UIColor.white
                    cell.selectBtn.backgroundColor = UIColor(named: "primary")
                    cell.priceLbl.textColor = UIColor(named: "secondary")


                }else{
                    print("else")
                    cell.bgView.backgroundColor = UIColor(displayP3Red: 236.0/255.0, green: 243.0/255.0, blue: 248.0/255.0, alpha: 1.0)
                    cell.selectBtn.backgroundColor = UIColor(named: "secondary")
                    cell.priceLbl.textColor = UIColor(named: "primary")
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
        updateCell(tagNo: selectedOption)

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


class SubscribtionCVC:UICollectionViewCell{
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var subscrptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var starImgV: UIImageView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var selectBtn: UIButton!
    @IBOutlet weak var bgView: UIView!
    
}

    
 
    

