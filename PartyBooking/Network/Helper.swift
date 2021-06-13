//
//  Helper.swift
//  PartyBooking
//
//  Created by MAC on 24/05/2021.
//  Copyright © 2021 MAC. All rights reserved.
//

import Foundation
import UIKit

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
        let def = UserDefaults.standard
        def.removeObject(forKey: "token")
        def.removeObject(forKey: "token_type")
        def.removeObject(forKey: "user_id")
        def.removeObject(forKey: "email")
        def.removeObject(forKey: "role")
        def.removeObject(forKey: "name")
        def.synchronize()
    }
}
