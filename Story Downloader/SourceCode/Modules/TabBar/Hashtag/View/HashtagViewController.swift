//
//  HashtagViewController.swift
//  Story Downloader
//
//  Created by Mohit Kumar Mohit on 08/10/22.
//

import UIKit

class HashtagViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var defaultCategories: UITextField!
    @IBOutlet weak var hashtagTextField: UITextField!
    @IBOutlet weak var collectionViewHashtag: UICollectionView!
    var hashtagSelected: Set<String> = []
    var hashtagModel: HashtagModel!
    {
        didSet{
            collectionViewHashtag.delegate = self
            collectionViewHashtag.dataSource = self
        }
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        HashtagContent(text: "trending")
        self.hideKeyboardWhenTappedAround()
//        DefaultCategories.delegate = self
//        DefaultCategories.text = placeholder
//        DefaultCategories.textColor = UIColor.lightGray
     
        
    }

        // Do any additional setup after loading the view.
    
//    copy default categories
    @IBAction func copyCategories(_ sender: UIButton) {
        //Alert hashtags copied
        copyAlert()
        print("Button tapped")
        UIPasteboard.general.string = defaultCategories.text!
    }
    
    
    func copyAlert() ->UIAlertController{
        let alert = UIAlertController(title: "Copied!", message: "Hashtags Copied", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (action: UIAlertAction!) in
          print("Handle Ok logic here")
          }))
        self.present(alert, animated: true, completion: nil)
        return alert
    }
    
    
    //paste default categories
    func PasteText(sender: UIButton!){
        if let textCopied = UIPasteboard.general.string{
            defaultCategories.insertText(textCopied)
        }
        
        self.stopLoader(loader: copyAlert())
    }
    
    
    
    func selectHashtag(){
        var hashtagText: String = ""
        hashtagSelected.forEach{text in
            hashtagText += "#"+text
            
        }
        defaultCategories.text! = hashtagText
    }
//
    
    @IBAction func buttonAccount(_ sender: UIButton){
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "AccountSettingViewController") as? AccountSettingViewController else{return}
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //Check data on API
    
    @IBAction func searchHashtag(_ sender: UIButton) {
        
        if(self.hashtagTextField.text != ""){
            let loader = self.loader()
            self.checkText(text: hashtagTextField.text!)
            HashtagContent(text: (hashtagTextField.text!))
            self.stopLoader(loader: loader)} else {
                print("Empty field")
            }
//
                    }
        
  
    
    

  
    
    //Instance of data
func HashtagContent (text: String){
    hashtagSearch.getHashtag(query: text){
    data in
    DispatchQueue.main.async {
        self.hashtagModel = data
        self.collectionViewHashtag.reloadData()
                }
                    
            }
          
    }
    
    let hashtagSearch = HashtagViewModel()
    
    
    
    
}

var hashtagCache = NSCache<AnyObject,AnyObject>()
extension HashtagViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hashtagModel.data.hashtags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionViewHashtag.dequeueReusableCell(withReuseIdentifier: "HashtagCollectionViewCell", for: indexPath) as! HashtagCollectionViewCell
        let hashtagTrend = hashtagModel.data.hashtags[indexPath.row]
        cell.apiTrending.text = hashtagTrend.hashtag
//        cell.delegate = self
        return cell
    }
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? HashtagCollectionViewCell else{return}
        
        if hashtagSelected.count == 10 && !hashtagSelected.contains(cell.apiTrending.text!){
            let alert = UIAlertController(title: "Oops", message: "Your limit is 10 hashtags", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Back", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)

            return
        }
       
        if hashtagSelected.contains(cell.apiTrending.text!){
            hashtagSelected.remove(cell.apiTrending.text!)
            cell.apiTrendView.backgroundColor = .white
            cell.apiTrending.textColor = .blue
        } else {
            hashtagSelected.insert(cell.apiTrending.text!)
            cell.apiTrendView.backgroundColor = .blue
            cell.apiTrending.textColor = .white
        }
        
        selectHashtag()
        
    }
      

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 30)
    }
       
    }

extension UITextField {
    func fortextField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let ACCEPTABLE_CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
        let cs = NSCharacterSet(charactersIn: ACCEPTABLE_CHARACTERS).inverted
        let filtered = string.components(separatedBy: cs).joined(separator: "")
        return (string == filtered)
    }
}


extension UIViewController{
    func checkText(text: String?){
        let characterset = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ")
        if text!.rangeOfCharacter(from: characterset.inverted) != nil{
            print("String with special characters")
            
        } else {
            return
            }
        }
}

