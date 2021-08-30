//
//  AppDelegate.swift
//  PartyBooking
//
//  Created by MAC on 7/2/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit
import GoogleMaps
import FBSDKCoreKit
import GoogleSignIn
import MOLH

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,GIDSignInDelegate,MOLHResetable{
    
    var window: UIWindow?
    var token = Helper.getAPIToken() ?? ""
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            GMSServices.provideAPIKey("AIzaSyD8z2lWzm896P2g8VhaBfrVam0JL1BaiW0")
          
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
        
        GIDSignIn.sharedInstance().clientID = "700206282803-lgu72jq9arbf9ctem5qm1vb5i1dcnl8q.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().delegate = self
        return true
    }
    
    func reset() {
        window?.rootViewController = TabBarController.instantiate(fromAppStoryboard: .Main)
    }
    
    func application(_ application: UIApplication,open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
      }

    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,withError error: Error!) {
      if let error = error {
        if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
          print("The user has not signed in before or they have since signed out.")
        } else {
          print("\(error.localizedDescription)")
        }
        // [START_EXCLUDE silent]
        NotificationCenter.default.post(
          name: NSNotification.Name(rawValue: "ToggleAuthUINotification"), object: nil, userInfo: nil)
        // [END_EXCLUDE]
        return
      }
      // Perform any operations on signed in user here.
      let userId = user.userID                  // For client-side use only!
      let idToken = user.authentication.idToken // Safe to send to the server
      let fullName = user.profile.name
      let givenName = user.profile.givenName
      let familyName = user.profile.familyName
      let email = user.profile.email
        print(userId ?? "")
        print(idToken ?? "")
        print(fullName ?? "")
        print(givenName ?? "")
        print(familyName ?? "")
        print(email ?? "")

        // [START_EXCLUDE]
      NotificationCenter.default.post(
        name: NSNotification.Name(rawValue: "ToggleAuthUINotification"),
        object: nil,
        userInfo: ["statusText": "Signed in user:\n\(fullName!)"])
      // [END_EXCLUDE]
    }
    
    
    // [START disconnect_handler]
      func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
                withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // [START_EXCLUDE]
        NotificationCenter.default.post(
          name: NSNotification.Name(rawValue: "ToggleAuthUINotification"),
          object: nil,
          userInfo: ["statusText": "User has disconnected."])
        // [END_EXCLUDE]
      }
      // [END disconnect_handler]
    

}
