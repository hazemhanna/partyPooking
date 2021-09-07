//
//  Helper.swift
//  PartyBooking
//
//  Created by MAC on 24/05/2021.
//  Copyright © 2021 MAC. All rights reserved.
//

import Foundation
import UIKit
import FBSDKLoginKit
import GoogleSignIn
import TwitterKit

class Helper {
    
    
    class func saveAPIToken(token: String) {
        let def = UserDefaults.standard
        def.set(token, forKey: "token")
        def.synchronize()
    }
    
   class func getAPIToken() -> String? {
      let def = UserDefaults.standard
      return def.object(forKey: "token") as? String
   }
    
    //Save API Function to userDefaults
    class func saveAPI( token: String,user_id: Int,email: String, name: String) {
        let def = UserDefaults.standard
        def.set(token, forKey: "token")
        def.set(user_id, forKey: "user_id")
        def.set(email, forKey: "email")
        def.set(name, forKey: "name")
        def.synchronize()
    }
    
    
    class func LogOut() {
        GIDSignIn.sharedInstance().signOut()
        let store = TWTRTwitter.sharedInstance().sessionStore
        if let userID = store.session()?.userID {
            store.logOutUserID(userID)
        }
        
          let fbLoginManager = LoginManager()
          fbLoginManager.logOut()
          let cookies = HTTPCookieStorage.shared
          let facebookCookies = cookies.cookies(for: URL(string: "https://facebook.com/")!)
          for cookie in facebookCookies! {
              cookies.deleteCookie(cookie )
          }
        let def = UserDefaults.standard
        def.removeObject(forKey: "token")
        def.removeObject(forKey: "token_type")
        def.removeObject(forKey: "user_id")
        def.removeObject(forKey: "email")
        def.removeObject(forKey: "role")
        def.removeObject(forKey: "name")
        def.synchronize()
    }


    class func saveDate(date: String) {
        let def = UserDefaults.standard
        def.set(date, forKey: "date")
        def.synchronize()
    }

    
    class func getdate() -> String? {
       let def = UserDefaults.standard
       return def.object(forKey: "date") as? String
    }
    
    
    
    
    class func saveCName(date: String) {
        let def = UserDefaults.standard
        def.set(date, forKey: "cName")
        def.synchronize()
    }

    
    class func getCName() -> String? {
       let def = UserDefaults.standard
       return def.object(forKey: "cName") as? String
    }
    
    
    
    
    class func saveCID(date: Int) {
        let def = UserDefaults.standard
        def.set(date, forKey: "CID")
        def.synchronize()
    }

    
    class func getCID() -> Int? {
       let def = UserDefaults.standard
       return def.object(forKey: "CID") as? Int
    }
    
    class func savePName(date: String) {
        let def = UserDefaults.standard
        def.set(date, forKey: "pName")
        def.synchronize()
    }
    class func getPName() -> String? {
       let def = UserDefaults.standard
       return def.object(forKey: "pName") as? String
    }
    class func savePID(date: Int) {
        let def = UserDefaults.standard
        def.set(date, forKey: "PID")
        def.synchronize()
    }
    class func getPID() -> Int? {
       let def = UserDefaults.standard
       return def.object(forKey: "PID") as? Int
    }
    
    class func savePrice(date: Int) {
        let def = UserDefaults.standard
        def.set(date, forKey: "price")
        def.synchronize()
    }
    class func getPrice() -> Int? {
       let def = UserDefaults.standard
       return def.object(forKey: "price") as? Int
    }
    
    class func saveLang(Lang: String) {
        let def = UserDefaults.standard
        def.set(Lang, forKey: "Lang")
    }
    class func getLang() -> String? {
        let def = UserDefaults.standard
        return def.object(forKey: "Lang") as? String
    }
    
    class func saveLat(Lang: Double) {
        let def = UserDefaults.standard
        def.set(Lang, forKey: "lat")
    }
    class func getLat() -> Double? {
        let def = UserDefaults.standard
        return def.object(forKey: "lat") as? Double
    }
    
    class func saveLong(Lang: Double) {
        let def = UserDefaults.standard
        def.set(Lang, forKey: "long")
    }
    class func getLong() -> Double? {
        let def = UserDefaults.standard
        return def.object(forKey: "long") as? Double
    }
  
    
    class func saveAddress(Lang: String) {
        let def = UserDefaults.standard
        def.set(Lang, forKey: "Address")
    }
    class func getAddress() -> String? {
        let def = UserDefaults.standard
        return def.object(forKey: "Address") as? String
    }
    
}
