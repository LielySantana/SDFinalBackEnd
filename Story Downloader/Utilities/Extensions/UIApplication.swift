//
//  UIApplication.swift
//  Kawader
//
//  Created by fluper on 18/03/20.
//  Copyright © 2020 fluper. All rights reserved.
//

import Foundation
import UIKit
extension UIApplication {
    
    var statusBarView: UIView? {
           if #available(iOS 13.0, *) {
               let tag = 3848245

               let keyWindow = UIApplication.shared.connectedScenes
                   .map({$0 as? UIWindowScene})
                   .compactMap({$0})
                   .first?.windows.first

               if let statusBar = keyWindow?.viewWithTag(tag) {
                   return statusBar
               } else {
                   let height = keyWindow?.windowScene?.statusBarManager?.statusBarFrame ?? .zero
                   let statusBarView = UIView(frame: height)
                   statusBarView.tag = tag
                   statusBarView.layer.zPosition = 999999

                   keyWindow?.addSubview(statusBarView)
                   return statusBarView
               }

           } else {
               if responds(to: Selector(("statusBar"))) {
                   return value(forKey: "statusBar") as? UIView
               }
           }
           return nil
    }
}


