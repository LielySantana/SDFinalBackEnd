//
//  TabBarController.swift
//  Story Downloader
//
//  Created by Mohit Kumar Mohit on 07/10/22.
//

import Foundation
import UIKit

class TabBarController: UIViewController{
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet var tabImages: [UIImageView]!
    @IBOutlet var buttonTabs: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateTabUI(index: 0)
    }
    
    private func updateTabUI(index: Int){
        switch index {
        case 0:
            tabImages[0].image = UIImage(named: "Icon awesome-home")
            tabImages[1].image = UIImage(named: "Icon awesome-fire copy")
            tabImages[2].image = UIImage(named: "Icon awesome-slack-hash copy")
            tabImages[3].image = UIImage(named: "Icon awesome-coins")
        case 1:
            tabImages[0].image = UIImage(named: "Icon awesome-home-1")
            tabImages[1].image = UIImage(named: "Icon awesome-fire")
            tabImages[2].image = UIImage(named: "Icon awesome-slack-hash copy")
            tabImages[3].image = UIImage(named: "Icon awesome-coins")
        case 2:
            tabImages[0].image = UIImage(named: "Icon awesome-home-1")
            tabImages[1].image = UIImage(named: "Icon awesome-fire copy")
            tabImages[2].image = UIImage(named: "Icon awesome-slack-hash")
            tabImages[3].image = UIImage(named: "Icon awesome-coins")
        case 3:
            tabImages[0].image = UIImage(named: "Icon awesome-home-1")
            tabImages[1].image = UIImage(named: "Icon awesome-fire copy")
            tabImages[2].image = UIImage(named: "Icon awesome-slack-hash copy")
            tabImages[3].image = UIImage(named: "Icon awesome-coins")
        default:
            return
        }
        loadController(index: index)
    }
    
    
    private func loadController(index: Int){
        
        switch index {
        case 0:
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController else { return }
            self.addChild(vc)
            vc.view.frame = CGRect(x: 0, y: 0, width: self.containerView.frame.size.width, height: self.containerView.frame.size.height);
            self.containerView.addSubview(vc.view)
            vc.didMove(toParent: self)
        case 1:
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "TrendingViewController") as? TrendingViewController else { return }
            self.addChild(vc)
            vc.view.frame = CGRect(x: 0, y: 0, width: self.containerView.frame.size.width, height: self.containerView.frame.size.height);
            self.containerView.addSubview(vc.view)
            vc.didMove(toParent: self)
        case 2:
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "HashtagViewController") as? HashtagViewController else { return }
            self.addChild(vc)
            vc.view.frame = CGRect(x: 0, y: 0, width: self.containerView.frame.size.width, height: self.containerView.frame.size.height);
            self.containerView.addSubview(vc.view)
            vc.didMove(toParent: self)
        case 3:
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "CoinsViewController") as? CoinsViewController else { return }
            self.addChild(vc)
            vc.view.frame = CGRect(x: 0, y: 0, width: self.containerView.frame.size.width, height: self.containerView.frame.size.height);
            self.containerView.addSubview(vc.view)
            vc.didMove(toParent: self)
        default:
            return
        }
        
    }
    
    @IBAction func buttonSelectTab(_ sender: UIButton){
        updateTabUI(index: sender.tag)
    }
    
}

