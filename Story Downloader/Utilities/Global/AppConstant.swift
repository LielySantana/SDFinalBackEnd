//
//  AppConstant.swift
//  CommonCode
//
//  Created by Deepak on 6/10/17.
//  Copyright © 2017 Deepak. All rights reserved.
//
import Foundation
import UIKit


// MARK: - Structure

typealias  JSON = [String:Any]?

let kAppName                    = "Safelet"
let kIsUserLoggedIn             = "isUserLoggedIn"
let kLoggedInAccessToken        = "access_token"
let kLoggedInUserDetails        = "loggedInUserDetails"
let kDeviceToken                = "device_token"
let kLanguage                   = "language"
let kSharedAppDelegate          = UIApplication.shared.delegate as? AppDelegate
let kSharedInstance             = SharedClass.sharedInstance
@available(iOS 13.0, *)
let kSharedSceneDelegate        = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
let kSharedUserDefaults         = UserDefaults.standard
let kScreenWidth                = UIScreen.main.bounds.size.width
let kScreenHeight               = UIScreen.main.bounds.size.height
let kRootVC                     = UIApplication.shared.windows.first?.rootViewController
let kBundleID                   = Bundle.main.bundleIdentifier!


struct ServiceName {
    
    
}

struct ApiParameters {
  
}


struct  AlertMessage {
    //NETWORK CONNECTION KEYS
    static let kDefaultError = "Something went wrong. Please try again."
    static let kNoInternet = "Unable to connect to the Internet. Please try again."
}

struct Identifiers{
    static let kLoginVC = "LoginViewController"
    static let kWalkthroughVC = "WalkthroughViewController"
    static let kTabBArVC = "TabBarViewController"
    static let KHomeVC = "HomeViewController"
    static let kLogsVC = "LogsViewController"
    static let kStories = "StoriesViewController"
    static let kProVc = "ProViewController"
    static let kSettingsVC = "SettingsViewController"
    static let kLikerVC = "LikersViewController"
    static let kPostByLikes = "PostsByLikesViewController"
    static let kPostVC = "PostsViewController"
}

struct Storyboards{
    static let kMain            = "Main"
    static let kHome            = "Home"
}



struct AlertTitle {
    static let kOk                = "OK"
    static let kCancel            = "Cancel"
    static let kDone              = "Done"
    static let ChooseDate         = "Choose Date"
    static let SelectCountry      = "Select Country"
    static let logout             = "Logout"
    
}


func Localised(_ aString:String) -> String {
    
    return NSLocalizedString(aString, comment: aString)
}





enum AppColor {
   static let kAppThemeRed = UIColor(named: "AppThemeRed")
}


enum OpenMediaType: Int {
    case camera = 0
    case photoLibrary
    case videoCamera
    case videoLibrary
}



enum AppFonts {
    case bold(CGFloat),regular(CGFloat)
    var font:UIFont {
        switch self {
        case .bold(let size):
            return UIFont (name: "System", size: size)!
        case .regular(let size):
            return UIFont.systemFont(ofSize: size)
        }
    }
}




func print_debug(items: Any) {
    print(items)
}

func print_debug_fake(items: Any) {
}


