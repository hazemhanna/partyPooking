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


struct ProfileViewModel {
   
    var email = BehaviorSubject<String>(value: "")
    var first_name = BehaviorSubject<String>(value: "")
    var last_name = BehaviorSubject<String>(value: "")
    var phone = BehaviorSubject<String>(value: "")
    var country = BehaviorSubject<String>(value: "")

    
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
    
}
