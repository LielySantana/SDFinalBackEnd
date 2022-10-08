//
//  AppsNetworkManager swift
//  Shubham Kaliyar
//
//  Created by Shubham Kaliyar on 17/09/19.
//  Copyright © 2019 Shubham Kaliyar. All rights reserved.



import Foundation
import UIKit
import SVProgressHUD
import AVFoundation

//MARK:- Globle Variable for AppsNetworkManagerInstanse
let AppsNetworkManagerInstanse = AppsNetworkManager.sharedInstanse
let iimageCache = NSCache<NSString, AnyObject>()

//MARK:-Class For Network Manager For Api Send And Retrived Data To/From Server

public class AppsNetworkManager{
    /**
     A shared instance of `AppsNetworkManagerInstanse`, used by top-level UllSessions request methods, and suitable for use directly
     for any ad hoc requests.
     */
    
    internal static let sharedInstanse :AppsNetworkManager  = AppsNetworkManager()
    
    // MARK:- Func for Single part Api
    /**
     *  Initiates HTTPS or HTTP request over |HttpsMEthods| method and returns call back in success and failure block.
     *
     *  @param serviceurl  name of the service
     *  @param method       method type like Get and Post
     *  @param postData     parameters
     *  @param responeBlock call back in block
     */
    
    
    
    
    func requestApi(parameters : Dictionary<String , Any>, serviceurl:String ,showHud: Bool = true, methodType:httpMethod, completionClosure: @escaping (_ result: Any?) -> ()) -> Void {
        
        //MARK:- Check the network availability
        //        if  NetworkReachabilityManager()?.isReachable != true {
        //            showAlertMessage.alert(message: AlertMessage.knoNetwork)
        //        }
        
        
        //MARK:-Show Progress bar Hud
        self.showHudWithNoInteraction(show: showHud)
        
        //MARK:-Fatch URL From Strings
        let urlString = AppsNetworkManagerConstants.baseUrl + serviceurl
        guard let url = URL(string: urlString.replacingOccurrences(of: " ", with: "%20")) else { return }
        print("Connecting to Host with URL \(urlString) with parameters: \(parameters)")
        
        let accessToken = "\(kSharedUserDefaults.getLoggedInAccessToken())"

        var request = URLRequest(url: url)
        request.httpMethod = methodType.rawValue
        
        print(accessToken)
        guard let httpBody = try? JSONSerialization.data(withJSONObject: methodType.rawValue == httpMethod.get.rawValue ?  [:] : parameters , options: []) else {
            return
        }
        if  methodType.rawValue != httpMethod.get.rawValue {
            request.httpBody = httpBody
        }
      
        request.setValue(accessToken, forHTTPHeaderField: AppsNetworkManagerConstants.accessToken)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request){(data , response , error) in
            self.showHudWithNoInteraction(show: showHud)
            guard error == nil else {
                //MARK:-  In Case of No Internet "Request failed with error: The Internet connection appears to be offline."
                let returnMessage = "RequestFailed :->  \(String(describing: error!.localizedDescription))"
                //MARK:-  --> Show snackbar in case of no internet connection for reload page case
                DispatchQueue.main.async { self.alert(message: returnMessage)}
                return
                
            }
            if let response = response {
//                print(response)
            }
            if let data = data {
                guard  let httpsresponse = response as? HTTPURLResponse else {return}
                let statusCode = httpsresponse.statusCode
                if !String.getString(httpsresponse.allHeaderFields["Authorization"]).isEmpty{
                    kSharedUserDefaults.setLoggedInAccessToken(loggedInAccessToken: String.getString(httpsresponse.allHeaderFields["Authorization"]))
                }
                do {
                    let data = try JSONSerialization.jsonObject(with: data, options: [])
                    let response = kSharedInstance.getDictionary(data)
                    print("Response-------->\(response)")
                    switch statusCode{
                    case 200 :
                        DispatchQueue.main.async {
                            completionClosure(data)
                        }
                        break
                    case 401:
                        DispatchQueue.main.async {
                            CommonUtils.showAlert(title: kAppName, message: String.getString(kSharedInstance.getDictionary(data)["message"]), buttonTitle: "OK") { buttonTitle in
//                                kSharedAppDelegate?.moveTologin()
                            }
                        }
                        break
                    default:
                        DispatchQueue.main.async {
                            self.alert(message: String.getString(kSharedInstance.getDictionary(data)["message"]))
                        }
                    }
                } catch {
                    DispatchQueue.main.async {
                        print(String.getString(error.localizedDescription))
                    }
                }
            }
        }.resume()
    }

    //Func for Post Api MultiPart Api to send  image ,Video and File
    /**
     *  Upload multiple images and videos via multipart
     * @param send image into perticular Key
     *  @param serviceurl  name of the service
     *  @param videosArray  array having videos file path
     *  @param postData     parameters
     *  @param responeBlock call back in block
     */
    
    func requestMultipartApi(parameters : Dictionary<String , Any> , serviceurl:String , methodType:httpMethod, completionClosure: @escaping (_ result: Any?) -> ()) -> Void{
        //MARK:- fetch Url For Apia
        self.showHudWithNoInteraction(show: true)
        let urlString = AppsNetworkManagerConstants.baseUrl + serviceurl
        guard let url = URL(string: urlString.replacingOccurrences(of: " ", with: "%20")) else { return }
        print("Connecting to Host with URL \(urlString) with parameters: \(parameters)")
        
        //MARK:- Fatch the Access Tokan And Create Header
        let accessToken = "\(kSharedUserDefaults.getLoggedInAccessToken())"

        var request = URLRequest(url: url)
        print(accessToken)
        request.httpMethod = methodType.rawValue
        request.setValue(accessToken, forHTTPHeaderField: AppsNetworkManagerConstants.accessToken)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        //MARK:-  Boundary For Multipart Api
        let boundary =  "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! createBody(parameters: parameters, boundary: boundary, mimeType: "image/jpeg/png/jpg/docx/doc/mp4/mov/movie/m4a")
        
        
        URLSession.shared.dataTask(with: request){(data , response , error) in
//            print("Details: \(String(describing: data)) --- ResponseIs: \(String(describing: response)) --- ErrorIs \(String(describing: error))")
            self.showHudWithNoInteraction(show: false)
            
            guard error == nil else {
                //MARK:-  In Case of No Internet "Request failed with error: The Internet connection appears to be offline."
                let returnMessage = "RequestFailed :->  \(String(describing: error!.localizedDescription))"
                //MARK:-  --> Show snackbar in case of no internet connection for reload page case
                DispatchQueue.main.async { self.alert(message: String.getString(returnMessage))}
                return
            }
            
            if let response = response {
//                print(response)
            }
            if let data = data {
                guard  let httpsresponse = response as? HTTPURLResponse else {return}
                
                let statusCode = httpsresponse.statusCode
                if !String.getString(httpsresponse.allHeaderFields["Authorization"]).isEmpty{
                    kSharedUserDefaults.setLoggedInAccessToken(loggedInAccessToken: String.getString(httpsresponse.allHeaderFields["Authorization"]))
                }
                do {
                    let data = try JSONSerialization.jsonObject(with: data, options: [])
                    let response = kSharedInstance.getDictionary(data)
                    print(response)
                    switch statusCode{
                    case 200 :
                        DispatchQueue.main.async {
                            completionClosure(response)
                        }
                        break
                    case 401:
                        DispatchQueue.main.async {
                            CommonUtils.showAlert(title: kAppName, message: String.getString(kSharedInstance.getDictionary(data)["message"]), buttonTitle: "OK") { buttonTitle in
//                                kSharedAppDelegate?.moveTologin()
                            }
                        }
                        break
                    default:
                        DispatchQueue.main.async {
                            self.alert(message: String.getString(kSharedInstance.getDictionary(data)["message"]))
                           // self.alert(message: String.getString(kSharedInstance.getDictionary(data)["error"]))
                            }
                        break
                    }
                } catch {
                    DispatchQueue.main.async { self.alert(message: String.getString(error))}
                }
            }
        }.resume()
    }
    


    
    //MARK:- Func for Create Body for multipart Api to append Video and images
    func createBody(parameters: [String: Any], boundary: String, mimeType: String) throws -> Data {
        var body = Data()
        
        for (key, value) in parameters {
            if(value is String || value is NSString) {
                body.append("--\(boundary)\r\n")
                body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.append("\(value)\r\n")
            } else if let imagValue = value as? UIImage {
                let r = arc4random()
                let filename = "image\(r).jpg" //MARK:  put your imagename in key
                let data: Data = imagValue.jpegData(compressionQuality: 0.7) ?? Data()
                body.append("--\(boundary)\r\n")
                body.append("Content-Disposition: form-data; name=\"\(key)\"; filename=\"\(filename)\"\r\n")
                body.append("Content-Type: \(mimeType)\r\n\r\n")
                body.append(data)
                body.append("\r\n")
                
            }else if value is [String: String] {
                var body1 = Data()
                body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                for (keyy, valuee) in (value as? [String: String])! {
                    body1.append("--\(boundary)\r\n")
                    body1.append("Content-Disposition: form-data; name=\"\(keyy)\"\r\n\r\n")
                    body1.append("\(valuee)\r\n")
                }
                
                body.append(body1)
                
            } else if let images = value as? [UIImage] {
                
                for image in images {
                    let r = arc4random()
                    let filename = "image\(r).jpg" //MARK:  put your imagename in key
                    let data: Data = image.jpegData(compressionQuality: 0.5)!
                    body.append("--\(boundary)\r\n")
                    body.append("Content-Disposition: form-data; name=\"\(key)\"; filename=\"\(filename)\"\r\n")
                    body.append("Content-Type: \(mimeType)\r\n\r\n")
                    body.append(data)
                    body.append("\r\n")
                    
                }
            } else if let auidoData = value as? Data { //MARK:  it is Used for Video and pdf send to the server
                let r = arc4random()
                let filename = "\(key)\(r).m4a" //MARK:  Put you image Name in key
                let data : Data = auidoData
                body.append("--\(boundary)\r\n")
                body.append("Content-Disposition: form-data; name=\"\(key)\"; filename=\"\(filename)\"\r\n")
                body.append("Content-Type: audio/m4a\r\n\r\n")
                body.append(data)
                body.append("\r\n")
            } else if let videoData = value as? Data { //MARK:  it is Used for Video and pdf send to the server
                let r = arc4random()
                let filename = "\(key)\(r).mov" //MARK:  Put you image Name in key
                let data : Data = videoData
                body.append("--\(boundary)\r\n")
                body.append("Content-Disposition: form-data; name=\"\(key)\"; filename=\"\(filename)\"\r\n")
                body.append("Content-Type: \(mimeType)\r\n\r\n")
                body.append(data)
                body.append("\r\n")
            } else if let multipleData = value as? [Data] { //MARK:  It is used for Multiple Data to api
                for filedata in multipleData {
                    let r = arc4random()
                    let filename = "\(key)\(r).mov" //MARK:-  put your imagename in key
                    let data: Data = filedata
                    body.append("--\(boundary)\r\n")
                    body.append("Content-Disposition: form-data; name=\"\(key)\"; filename=\"\(filename)\"\r\n")
                    body.append("Content-Type: \(mimeType)\r\n\r\n")
                    body.append(data)
                    body.append("\r\n")
                    
                }
            }
        }
        body.append("--\(boundary)--\r\n")
        return body
    }
    
}




//MARK:- Class For Shared Utilities For AppsNetworkManagerInstanse
extension AppsNetworkManager {
    
    //MARK:- Func For Show Hud
    func showHudWithNoInteraction(show: Bool) {
        if show {
            SVProgressHUD.setDefaultMaskType(.clear)
            SVProgressHUD.setDefaultStyle(.custom)
            SVProgressHUD.setForegroundColor(UIColor(named: "AppThemeRed") ?? .red)
            SVProgressHUD.setBackgroundColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).withAlphaComponent(0))
            SVProgressHUD.show()
        } else {
            SVProgressHUD.dismiss()
        }
    }
    
    //MARK: - Show Alert For Error
    func alert(message:String) {
        let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        let action1 = UIAlertAction(title: AlertTitle.kOk, style: .cancel, handler: nil)
        alert.addAction(action1)
        UIApplication.topViewController()?.present(alert , animated: true)
    }
}


//MARK:- Constant for Api For Url Sessions
struct AppsNetworkManagerConstants {
    static let baseUrl               = "https://dev-safelet.herokuapp.com/api-v2022"
//    static let baseUrl               = "https://14d8-139-5-254-181.ngrok.io/api-v2022"
    static let accessToken           = "Authorization"
}

//MARK:- Enum For httpsMethos

enum httpMethod: String {
    case get  = "GET"
    case post = "POST"
    case put  = "PUT"
    case delete = "DELETE"
}

//MARK: - Extension for Downlode Image Using URl Sessions
extension UIImageView{
    
    private static var taskKey = 0
    private static var urlKey = 0

    private var currentTask: URLSessionTask? {
        get { return objc_getAssociatedObject(self, &UIImageView.taskKey) as? URLSessionTask }
        set { objc_setAssociatedObject(self, &UIImageView.taskKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }

    private var currentURL: URL? {
        get { return objc_getAssociatedObject(self, &UIImageView.urlKey) as? URL }
        set { objc_setAssociatedObject(self, &UIImageView.urlKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }

    func loadImageAsync(with urlString: String?, placeholderImage: UIImage?) {
        // cancel prior task, if any

        weak var oldTask = currentTask
        currentTask = nil
        oldTask?.cancel()

        // reset imageview's image

        self.image = placeholderImage

        // allow supplying of `nil` to remove old image and then return immediately

        guard let urlString = urlString else { return }

        // check cache

        if let cachedImage = ImageCache.shared.image(forKey: urlString) {
            self.image = cachedImage
            return
        }

        // download

        guard let url = URL(string: urlString.replacingOccurrences(of:  " ", with: "%20")) else { return }
        currentURL = url
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            self?.currentTask = nil

            //error handling

            if let error = error {
                // don't bother reporting cancelation errors

                if (error as NSError).domain == NSURLErrorDomain && (error as NSError).code == NSURLErrorCancelled {
                    return
                }

                print(error)
                return
            }

            guard let data = data, let downloadedImage = UIImage(data: data) else {
                print("unable to extract image")
                return
            }

            ImageCache.shared.save(image: downloadedImage, forKey: urlString)

            if url == self?.currentURL {
                DispatchQueue.main.async {
                    self?.image = downloadedImage
                }
            }
        }

        // save and start new task

        currentTask = task
        task.resume()
    }

}

class ImageCache {
    private let cache = NSCache<NSString, UIImage>()
    private var observer: NSObjectProtocol!

    static let shared = ImageCache()

    private init() {
        // make sure to purge cache on memory pressure

        observer = NotificationCenter.default.addObserver(forName: UIApplication.didReceiveMemoryWarningNotification, object: nil, queue: nil) { [weak self] notification in
            self?.cache.removeAllObjects()
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(observer as Any)
    }

    func image(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }

    func save(image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
}


//MARK: - Extension for Downlode Image Using URl Sessions
extension UIImageView {
    
    //MARK:- Func for downlode image
    func downlodeImage(serviceurl:String , placeHolder: UIImage?) {
        
        self.image = placeHolder
        let urlString = serviceurl
        guard let url = URL(string: urlString.replacingOccurrences(of:  " ", with: "%20")) else { return }
        
        //MARK:- Check image Store in Cache or not
        if let cachedImage = iimageCache.object(forKey: urlString.replacingOccurrences(of: " ", with: "%20") as NSString) {
            if  let image = cachedImage as? UIImage {
                self.image = image
                print("Find image on Cache : For Key" , urlString.replacingOccurrences(of: " ", with: "%20"))
                return
            }
        }
        
        print("Conecting to Host with Url:-> \(url)")
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            
            if error != nil {
                print(error!)
                DispatchQueue.main.async {
                    self.image = placeHolder
                    return
                }
            }
            if data == nil {
                DispatchQueue.main.async {
                    self.image = placeHolder
                }
                return
            }
            DispatchQueue.main.async {
                if let image = UIImage(data: data!) {
                    iimageCache.removeAllObjects()
                    self.image = image
                    iimageCache.setObject(image, forKey: urlString.replacingOccurrences(of: " ", with: "%20") as NSString)
                }
            }
        }).resume()
    }
}

//MARK:- Extension of Data For Apped String
extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
