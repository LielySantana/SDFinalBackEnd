//
//  UIViewController.swift
//  Happy Event Demo
//
//  Created by fluper on 21/02/20.
//  Copyright © 2020 Manoj. All rights reserved.
//

import Foundation
import UIKit


extension UIViewController{
//    func goToHome(){
//           let storyBoard = UIStoryboard(name: Storyboards.kHome, bundle: nil)
//           guard  let vc = storyBoard.instantiateViewController(identifier: Identifiers.kHomeController) as? HomeViewController  else{return}
//       self.navigationController?.pushViewController(vc, animated: true)
//
//       }
 
}

public extension UIViewController {
    func setStatusBar(color: UIColor) {
        let tag = 12321
        if let taggedView = self.view.viewWithTag(tag){
            taggedView.removeFromSuperview()
        }
        let overView = UIView()
        overView.frame = UIApplication.shared.statusBarFrame
        overView.backgroundColor = color
        overView.tag = tag
        self.view.addSubview(overView)
    }
}
