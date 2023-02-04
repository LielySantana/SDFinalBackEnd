//
//  AccountSettingViewController.swift
//  Story Downloader
//
//  Created by Mohit Kumar Mohit on 09/10/22.
//

import UIKit
import RevenueCat
import StoreKit
import MessageUI

class AccountSettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func retorePurchase(_ sender: UIButton) {
        Purchases.shared.restorePurchases { (purchaserInfo, error) in
            if purchaserInfo?.entitlements.active.isEmpty != true {
                
                return
            } else {
                print( "Subscription restored 👍")
                self.restoreAlert()
            }
            
        }
    }
    
    @IBAction func shareBtn(_ sender: UIButton) {
        let url = URL(string: "Link")!
        let text = "Hey!, you should try this App."
        let activity = UIActivityViewController(activityItems: [url, text], applicationActivities: nil)
        present(activity, animated: true)
        
        }
    
    
    
    @IBAction func rateBtn(_ sender: UIButton) {
        rateApp()
    }
    
    
    @IBAction func contactBtn(_ sender: UIButton) {
        sendEmail()
    }
    
    @IBAction func logOutBtn(_ sender: UIButton) {
        
    }
    
    @IBAction func deleteBtn(_ sender: UIButton) {
        
    }
    
    @IBAction func buttonBack(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    func rateApp() {
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()

        } else if let url = URL(string: "itms-apps://itunes.apple.com/app/" + "appId") {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)

            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    func restoreAlert() ->UIAlertController{
        let alert = UIAlertController(title: "", message: "You're purchase has been restored", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (action: UIAlertAction!) in
          print("Handle Ok logic here")
          }))
        self.present(alert, animated: true, completion: nil)
        return alert
    }
    
    
    
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
//            mail.mailComposeDelegate = ""
            mail.setToRecipients(["you@yoursite.com"])
            mail.setMessageBody("<p>You're so awesome!</p>", isHTML: true)

            present(mail, animated: true)
        } else {
            // show failure alert
        }
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    

}
