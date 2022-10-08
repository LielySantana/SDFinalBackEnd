//
//  SignInViewController.swift
//  Story Downloader
//
//  Created by Mohit Kumar Mohit on 07/10/22.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var textfieldUserName: UITextField!
    @IBOutlet weak var textfieldPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func buttonEye(_ sender: UIButton) {
    }
    
    @IBAction func buttonSignIn(_ sender: UIButton) {
        kSharedAppDelegate?.moveToTabBar(selectedIndex: 0)
    }
}
