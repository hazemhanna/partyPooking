//
//  ProfileViewModel.swift
//  PartyBooking
//
//  Created by MAC on 03/08/2021.
//  Copyright © 2021 MAC. All rights reserved.
//

import Foundation
import RxSwift
import SVProgressHUD

struct ProfileViewModel{
    
    var email = BehaviorSubject<String>(value: "")
    var first_name = BehaviorSubject<String>(value: "")
    var last_name = BehaviorSubject<String>(value: "")
    var phone = BehaviorSubject<String>(value: "")
    var country = BehaviorSubject<String>(value: "")
    var password = BehaviorSubject<String>(value: "")

    func showIndicator() {
        SVProgressHUD.show()
    }
    func dismissIndicator() {
        SVProgressHUD.dismiss()
    }
    
    func showProgress(progress: Float) {
        SVProgressHUD.showProgress(progress)
    }
    
    func getProfile() -> Observable<ProfileModelJSON> {
        let observer = GetServices.shared.getProfile()
        return observer
    }
    
    func validate(country : String) -> Observable<String> {
            return Observable.create({ (observer) -> Disposable in
                let bindedName = (try? self.first_name.value()) ?? ""
                let bindedLastName = (try? self.last_name.value()) ?? ""
                let bindedEmail = (try? self.email.value()) ?? ""
                let bindedPhone = (try? self.phone.value()) ?? ""

                if bindedName.isEmpty {
                      if "lang".localized == "ar" {
                      observer.onNext("يرجى ادخال الاسم الاول")
                      } else {
                      observer.onNext("Please Enter Your First name ")
                    }
                } else if bindedLastName.isEmpty {
                    if "lang".localized == "ar" {
                    observer.onNext("الرجاء إدخال اسمك الأخير")
                    } else {
                    observer.onNext("Please Enter Your last Name ")
                  }
              } else if bindedPhone.isEmpty {
                    if "lang".localized == "ar" {
                        observer.onNext("يرجى إدخال رقم  صحيح.")
                    } else {
                        observer.onNext("Please Enter a valid  phone number")
                    }
                }else if bindedEmail.isEmpty {
                    if "lang".localized == "ar" {
                        observer.onNext("الرجاء إدخال بريدك الإلكتروني")
                    } else {
                        observer.onNext("Please Enter Your Email ")
                    }
                }else if country.isEmpty {
                    if "lang".localized == "ar" {
                         observer.onNext("الرجاء تحديد دولة")
                    } else {
                        observer.onNext("Please select your country")
                    }
                }else{
                    observer.onNext("")
                }
                return Disposables.create()
            })
        }
    //MARK:- Attempt to register
    func editProfile(country_id : Int) -> Observable<MessageModel> {
        let bindedName = (try? self.first_name.value()) ?? ""
        let bindedLastName = (try? self.last_name.value()) ?? ""
        let bindedEmail = (try? self.email.value()) ?? ""
        let bindedPhone = (try? self.phone.value()) ?? ""

        let params: [String: Any] = [
            "first_name": bindedName ,
            "last_name": bindedLastName ,
            "country_id": country_id ,
            "email": bindedEmail ,
            "phone": bindedPhone
            ]
        
        let observer = AddServices.shared.editProfile(params: params)
        return observer
    }
    
    
    //MARK:- Attempt to register
    func changePhoto(image : UIImage) -> Observable<MessageModel> {
        let observer = AddServices.shared.chageProfilePhoto(image: image)
        return observer
    }


    func getCountry() -> Observable<CountriesModelJson> {
        let observer = GetServices.shared.getAllCountry()
        return observer
    }
    
    
    func postBooking(artistId  : Int, area_id:Int, party_type_id : Int,address : String,lat: Double,long : Double, price : Int , date : String , from_time : String ,to_time : String ) -> Observable<ContactUSModelJson> {
        let params: [String: Any] = [
            "artist_id": artistId,
            "area_id": area_id,
            "party_type_id": party_type_id,
            "address": address,
            "lat": lat,
            "long": long,
            "price": price,
            "date": date,
            "from_time": from_time,
            "to_time": to_time,
            ]
        let observer = AddServices.shared.postBooking(params: params)
        return observer
    }
    
    
    //MARK:- Attempt to register
    func attemptToRegister(image : UIImage,countryId:Int) -> Observable<AuthMdelsJSON> {
        let bindedEmail = (try? self.email.value()) ?? ""
        let bindedPassword = (try? self.password.value()) ?? ""
        let bindedFirstName = (try? self.first_name.value()) ?? ""
        let bindedLastName = (try? self.last_name.value()) ?? ""
        let bindedPhone = (try? self.phone.value()) ?? ""
        
        let params: [String: Any] = [
            "email": bindedEmail,
            "password": bindedPassword,
            "country_id": countryId,
            "first_name": bindedFirstName ,
            "last_name": bindedLastName ,
            "phone": bindedPhone ,
            ]
        let observer = Authentication.shared.postRegister(image:image,params: params)
        return observer
    }
    
    func logOut() -> Observable<ContactUSModelJson> {
        let observer = Authentication.shared.logOut()
        return observer
    }
}
