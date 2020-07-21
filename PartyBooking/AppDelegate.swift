//
//  AppDelegate.swift
//  PartyBooking
//
//  Created by MAC on 7/2/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit
import GoogleMaps
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,MOLHResetable {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
              
              GMSServices.provideAPIKey("AIzaSyD8z2lWzm896P2g8VhaBfrVam0JL1BaiW0")
              MOLHLanguage.setDefaultLanguage("en")
              MOLH.shared.activate(true)
              MOLH.shared.specialKeyWords = ["Cancel", "Done"]
      //window?.rootViewController = TabBarController.instantiate(fromAppStoryboard: .Main)
       window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Nav")
        return true

    }
    
    func reset() {
        window?.rootViewController = TabBarController.instantiate(fromAppStoryboard: .Main)
    }
    
    
}
