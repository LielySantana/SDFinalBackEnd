//
//  AppDelegate.swift
//  Story Downloader
//
//  Created by Mohit Kumar Mohit on 07/10/22.
//

import UIKit
import SwiftUI
import Foundation
import RevenueCat
import AVFoundation

 @main
class AppDelegate: UIResponder, UIApplicationDelegate{

//    @StateObject var subsVM = subscriptionViewModel()

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Purchases.logLevel = .debug
        Purchases.configure(with: Configuration.Builder(withAPIKey: "appl_WbfPlXJsleWqAduRJSaVfJtQlMG")
            .with(usesStoreKit2IfAvailable: true)
            .build())


        Purchases.shared.delegate = self
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

extension AppDelegate{
    func moveToTabBar(selectedIndex:Int){
        guard  let controller = UIStoryboard(name: Storyboards.kHome, bundle: nil).instantiateViewController(withIdentifier: "TabBarController") as? TabBarController else {return}
        let navC = UINavigationController(rootViewController: controller)
       
        navC.navigationBar.isHidden = true
        navC.navigationBar.barStyle = .black
        UIApplication.shared.connectedScenes.flatMap { ($0 as? UIWindowScene)?.windows ?? [] }.first { $0.isKeyWindow }?.rootViewController = navC
        UIApplication.shared.connectedScenes.flatMap { ($0 as? UIWindowScene)?.windows ?? [] }.first { $0.isKeyWindow }?.makeKeyAndVisible()
    }
}


extension AppDelegate: PurchasesDelegate{
    func purchases(_purchases: Purchases, receivedUpdated customerInfo: CustomerInfo ){
        print("Modified")
    }
}
