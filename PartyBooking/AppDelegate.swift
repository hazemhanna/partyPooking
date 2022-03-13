//
//  AppDelegate.swift
//  PartyBooking
//
//  Created by MAC on 7/2/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import GoogleSignIn
import MOLH
import IQKeyboardManagerSwift
import TwitterKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,MOLHResetable{
    
    var window: UIWindow?
    var token = Helper.getAPIToken() ?? ""
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //GMSServices.provideAPIKey("AIzaSyAG_FGV2ATqdGF8a4d_JyaZBcgZ6osz8J4")
        //GMSPlacesClient.provideAPIKey("AIzaSyAG_FGV2ATqdGF8a4d_JyaZBcgZ6osz8J4")
        
        MOLH.shared.activate(true)
        MOLH.shared.specialKeyWords = ["Cancel","Done"]
        
        if ("lang".localized == "en") {
            MOLHLanguage.setDefaultLanguage("en")
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }else{
            MOLHLanguage.setDefaultLanguage("ar")
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
        }
        
        if token != "" {
        window?.rootViewController = TabBarController.instantiate(fromAppStoryboard: .Main)
        }else{
          if Helper.getLang() != nil {
            window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Nav")
            }else {
                let sb = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LanguageScreenNav")
                 window?.rootViewController = sb
            }
        }
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "DoneB".localized
        
        GIDSignIn.sharedInstance().clientID = "700206282803-lgu72jq9arbf9ctem5qm1vb5i1dcnl8q.apps.googleusercontent.com"
         
        TWTRTwitter.sharedInstance().start(withConsumerKey: "w5Zb8L0AXnLyLBDSaj7bxk20E", consumerSecret: "5IbxgI8cXjWgx1CjthQBbkpaYzim7ayVqs2Umzs6eIFSurBmCj")

        
        return true
    }
    
    func reset() {
        window?.rootViewController = TabBarController.instantiate(fromAppStoryboard: .Main)
    }
    
    @available(iOS 9.0, *)
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        
        print(app , "////////" , url)
        _ = TWTRTwitter.sharedInstance().application(app, open: url, options: options)
        _ = GIDSignIn.sharedInstance().handle(url)
        
        return true
    }
    
    
}
