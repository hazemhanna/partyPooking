//
//  ConfigURLs.swift
//  PartyBooking
//
//  Created by MAC on 8/5/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import SwiftyJSON


var BASE_URL = "https://partybooking.dtagdev.com/en/"

struct ConfigURLs {

    //MARK:- user
    //MARK:- POST user Login
    static var userLogin = BASE_URL + "artist/login"
    //MARK:- POST Register
    static var postRegister = BASE_URL  + "/register"
    //MARK:- POST validateRegister
    static var validateRegister = BASE_URL  + "/validate-register"

    
    
    //MARK:- artist
    //MARK:- POST Artist Login
    static var artistLogin = BASE_URL + "artist/login"
    
}
