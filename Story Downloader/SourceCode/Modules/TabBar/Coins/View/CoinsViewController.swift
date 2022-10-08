//
//  CoinsViewController.swift
//  Story Downloader
//
//  Created by Mohit Kumar Mohit on 08/10/22.
//

import UIKit

class CoinsViewController: UIViewController {
    @IBOutlet weak var tableViewPrices: UITableView!
    var pricesArray:[[String:Any]] = [["prices":"$0.99","coins":"100"],
                                    ["prices":"$1.99","coins":"250"],
                                    ["prices":"$3.99","coins":"500"],
                                    ["prices":"$6.99","coins":"1000"],
                                    ["prices":"$6.99","coins":"3000"],
                                    ["prices":"$11.99","coins":"6500"],
                                    ["prices":"$29.99","coins":"10000"],
                                    ["prices":"$49.99","coins":"20000"],
                                    ["prices":"$99.99","coins":"50000"]]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewPrices.delegate = self
        tableViewPrices.dataSource = self
        // Do any additional setup after loading the view.
    }
    @IBAction func buttonAccount(_ sender: UIButton){
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "AccountSettingViewController") as? AccountSettingViewController else{return}
        self.navigationController?.pushViewController(vc, animated: true)
    }
}



extension CoinsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pricesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PurchaseCoinsTableViewCell", for: indexPath) as! PurchaseCoinsTableViewCell
        cell.labelPrice.text = String.getString(pricesArray[indexPath.row]["prices"])
        cell.labelCoins.text = String.getString(pricesArray[indexPath.row]["coins"])
        return cell
    }
}

class PurchaseCoinsTableViewCell: UITableViewCell{
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var labelCoins: UILabel!
}
