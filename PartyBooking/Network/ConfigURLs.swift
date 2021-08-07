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

    //MARK:- General
    static var getCountry = BASE_URL + "api/getCountries"
    static var getArea = BASE_URL + "api/getAreas"
    static var getTerms = BASE_URL + "api/terms"
    static var getService = BASE_URL + "api/getServices"
    static var getPartyType = BASE_URL + "api/getPartyTypes"
    
    //MARK:- user
    //MARK:- POST user Login
    static var userLogin = BASE_URL + "user/auth/login"
    //MARK:- POST Register
    static var postRegister = BASE_URL  + "user/auth/register"
    //MARK:- get home
    static var getHome = BASE_URL  + "user/home/main"
    
    //MARK:- get PartType
    static var getPartType = BASE_URL  + "api/getPartyTypes"
    //MARK:- get best Artist
    static var getBestArtist = BASE_URL  + "user/home/best-artists"
    //MARK:- get search
    static var getSearch = BASE_URL  + "user/home/search"
    //MARK:- get search
    static var addFavourite = BASE_URL  + "user/favourite/add"
    static var getFavourite = BASE_URL  + "user/favourite/get"
    static var getReservation = BASE_URL  + "user/booking/getBookings"
    static var getArtistDetails = BASE_URL  + "user/home/artistDetails"
    //MARK:- get Live
    static var getLive = BASE_URL  + "user/setting/getLives"
    static var getProfile = BASE_URL  + "user/auth/profile"
    static var chageProfilePhoto = BASE_URL  + "user/auth/changePhoto"
    static var editProfile = BASE_URL  + "user/auth/updateProfile"
    //MARK:- artist
    //MARK:- POST Artist Login
    static var artistLogin = BASE_URL + "artist/login"
    
}
