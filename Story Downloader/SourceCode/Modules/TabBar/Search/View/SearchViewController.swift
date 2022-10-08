//
//  SearchViewController.swift
//  Story Downloader
//
//  Created by Mohit Kumar Mohit on 08/10/22.
//

import UIKit

class SearchViewController: UIViewController {
    @IBOutlet weak var tableViewSearch: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableViewSearch.register(UINib(nibName: "UsersTableViewCell", bundle: nil), forCellReuseIdentifier: "UsersTableViewCell")
        tableViewSearch.delegate = self
        tableViewSearch.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonBack(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }

}


extension SearchViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewSearch.dequeueReusableCell(withIdentifier: "UsersTableViewCell", for: indexPath) as! UsersTableViewCell
        cell.labelUserName.textColor = UIColor(named: "AppThemeDarkBlue")
        cell.labelFollowers.textColor = UIColor(named: "AppThemeDarkBlue")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "UserDetailViewController") as? UserDetailViewController else{return}
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
