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
    static var getArea = BASE_URL + "api/get-all-areas"
    static var getTerms = BASE_URL + "api/terms"
    static var getAbout = BASE_URL + "api/aboutUs"
    static var getService = BASE_URL + "api/getServices"
    static var getPartyType = BASE_URL + "api/getPartyTypes"
    static var contactUs = BASE_URL + "api/contactUs"
    //MARK:- user
    //MARK:- POST user Login
    static var userLogin = BASE_URL + "user/auth/login"
    static var userLoginWithSocial = BASE_URL + "user/auth/socialLogin"    
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
    static var getArtistDetails = BASE_URL  + "user/artist/details"
    static var getArtistWork = BASE_URL  + "user/home/artist-works"
    static var getOffers = BASE_URL  + "user/offer/get"
    
    static var OffersSearch = BASE_URL  + "user/offer/search"

    
    
    //MARK:- get Live
    static var getLive = BASE_URL  + "user/setting/getLives"
    static var getProfile = BASE_URL  + "user/auth/profile"
    static var chageProfilePhoto = BASE_URL  + "user/auth/changePhoto"
    static var editProfile = BASE_URL  + "user/auth/updateProfile"
    static var offerDetails = BASE_URL  + "user/offer/details"
    // booking
    static var postBooking = BASE_URL  + "user/booking/book"
    static var getReservation = BASE_URL  + "user/booking/getBookings"
    static var cancelReservation = BASE_URL  + "user/booking/cancelBooking"
    static var getNotification = BASE_URL  + "user/notification/all"

    //MARK:- artist
    //MARK:- POST Artist Login
    static var artistLogin = BASE_URL + "artist/login"
    
}
