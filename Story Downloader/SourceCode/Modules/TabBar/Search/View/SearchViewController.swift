//
//  SearchViewController.swift
//  Story Downloader
//
//  Created by Mohit Kumar Mohit on 08/10/22.
//

import UIKit
import SwiftUI

class SearchViewController: UIViewController {
    @IBOutlet weak var tableViewSearch: UITableView!
    var searchvm: SearchModel!
    var userData: [UserElement] = []
   
    
    
    
    let userDefaults = UserDefaults.standard
    var recentSearch: [UserUser] = []
    var userInfo: UserUser!
    var username: String = ""
    var recentCheck: Bool = false
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.hideKeyboardWhenTappedAround()
        self.recentCheck = existInRecent(userInfo: username)
    
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fillHistory()}    
    
    
    func setup(){
        self.tableViewSearch.register(UINib(nibName: "UsersTableViewCell", bundle: nil), forCellReuseIdentifier: "UsersTableViewCell")
        tableViewSearch.delegate = self
        tableViewSearch.dataSource = self
    }
    
    
    
    func recent(){
        var recent: [String:Any] = userDefaults.object(forKey: "recentSearch") as? [String:Any] ?? [:]
        do{
            let encoder = JSONEncoder()
            let data = try encoder.encode(userInfo)
            recent[username] = data
            userDefaults.set(recent, forKey: "recentSearch")
            print("Added recent story view")
            print(recent.keys.count)
            
        }catch{
            print(error)
        }
    }
    
    func existInRecent(userInfo:String)->Bool{
        var recentDict: [String:Any] = userDefaults.object(forKey: "recentSearch") as? [String:Any] ?? [:]
        var exist = recentDict[userInfo]
        if(exist == nil){
            return false
        }
        return true
    }
    
    

    @IBOutlet weak var searchTextField: UITextField!
    
    @IBAction func buttonBack(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
//Search button with textfield reading filling the API
    @IBAction func searchButton(_ sender: UIButton) {
        if(self.searchTextField.text != ""){
            self.checkText(text: searchTextField.text!)
            let loader = self.loader()
            SearchContent(text: searchTextField.text!)
            self.stopLoader(loader: loader)
            
        } else {
            print("Empty text")
        }
        
            }
    
    func history(userData: UserElement){
        var historyData : [String:Any] = self.userDefaults.object(forKey: "history") as? [String:Any] ?? [:]
        do{
            let encoder = JSONEncoder()
            let data = try encoder.encode(userData)
            historyData[userData.user.username] = data
            userDefaults.set(historyData, forKey: "history")
            print("history search added")
            print(historyData.keys.count)
        }catch{
            print(error)
        }
    }
    
    func fillHistory(){
        userData = []
        let userhistory: [String:Any] = userDefaults.object(forKey: "history") as? [String:Any] ?? [:]
        for (_, value) in userhistory{
            do{
                let unData = try JSONDecoder().decode(UserElement.self, from: value as! Data)
                userData.append(unData)
            }catch{
                print(error)
            }
        }
        print("History loaded")
        tableViewSearch.reloadData()
    }
    
    
    
   //Instance of API
    func SearchContent (text: String){
        contentSearch.getSearch(query: text){
            data in
            DispatchQueue.main.async {
                //local storage
                self.userData = data.users
                self.tableViewSearch.reloadData()
                
                print(data.users.count)

                }
            }
       


    }
        let contentSearch = searchViewModel()
    
    

}
    
    



var SearchCache = NSCache<AnyObject,AnyObject>()
extension SearchViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userData.count

        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewSearch.dequeueReusableCell(withIdentifier: "UsersTableViewCell", for: indexPath) as! UsersTableViewCell
        let userResults = userData[indexPath.row]
        cell.userInfo = userResults
        cell.labelUsername.textColor = .black
        cell.labelUsername.text = userResults.user.username
        cell.profilePicture.load(urlString: userResults.user.profilePicURL)
        cell.userid = userResults.user.pk
        cell.userData = userResults.user
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "UserDetailViewController") as? UserDetailViewController else{return}
        recent()
        let indexTapped = tableView.indexPathForSelectedRow
        let currentCell = tableView.cellForRow(at: indexTapped!)
        as! UsersTableViewCell
        history(userData: currentCell.userInfo)
        vc.username = currentCell.labelUsername.text!
        vc.picload = currentCell.profilePicture.image!
        vc.userID = currentCell.userid
        vc.userData = currentCell.userData
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
var imageCache = NSCache<AnyObject,AnyObject>()
extension UIImageView {
    func load(urlString : String) {
        if  let image = imageCache.object(forKey: urlString as NSString)as? UIImage{
            self.image = image
            return
        }
        guard let url = URL(string: urlString)else {
            return
        }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        imageCache.setObject(image, forKey: urlString as NSString)
                        self?.image = image
                    }
                }
            }
        }
    }
}


