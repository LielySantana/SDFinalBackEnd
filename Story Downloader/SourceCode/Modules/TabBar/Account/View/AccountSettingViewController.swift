//
//  AccountSettingViewController.swift
//  Story Downloader
//
//  Created by Mohit Kumar Mohit on 09/10/22.
//

import UIKit

class AccountSettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonBack(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }

}
