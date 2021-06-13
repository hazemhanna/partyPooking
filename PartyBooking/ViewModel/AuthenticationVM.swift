//
//  AuthenticationVM.swift
//  PartyBooking
//
//  Created by MAC on 12/06/2021.
//  Copyright © 2021 MAC. All rights reserved.
//

import Foundation
import RxSwift
import SVProgressHUD


struct AuthenticationViewModel {
    var email = BehaviorSubject<String>(value: "")
    var password = BehaviorSubject<String>(value: "")
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
    
    func validate(country : String) -> Observable<String> {
            return Observable.create({ (observer) -> Disposable in
                let bindedName = (try? self.first_name.value()) ?? ""
                let bindedLastName = (try? self.last_name.value()) ?? ""
                let bindedEmail = (try? self.email.value()) ?? ""
                let bindedPhone = (try? self.phone.value()) ?? ""
                let bindedPassword = (try? self.password.value()) ?? ""

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
                }else if bindedPassword.isEmpty {
                    if "lang".localized == "ar" {
                        observer.onNext("الرجاء إدخال كلمة مرور")
                    } else {
                        observer.onNext("Please select your password")
                    }
                }else if bindedPassword.isPasswordValid() {
                    if "lang".localized == "ar" {
                        observer.onNext("الرجاء إدخال كلمة مرور صالحة")
                    } else {
                        observer.onNext("Please enter your correct password")
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
    func attemptToLogin() -> Observable<AuthMdelsJSON> {
        let bindedEmail = try? email.value()
        let bindedPassword = try? password.value()
        
        let params: [String: Any] = [
            "email": bindedEmail ?? "",
            "password": (bindedPassword ?? "").arToEnDigits,
            ]
        let observer = Authentication.shared.postLogin(params: params)
        return observer
    }

    func validateLogin() -> Observable<String> {
            return Observable.create({ (observer) -> Disposable in
                let bindedEmail = (try? self.email.value()) ?? ""
                let bindedPassword = (try? self.password.value()) ?? ""
               if bindedEmail.isEmpty {
                    if "lang".localized == "ar" {
                        observer.onNext("الرجاء إدخال بريدك الإلكتروني")
                    } else {
                        observer.onNext("Please Enter Your Email ")
                    }
                }else if bindedPassword.isEmpty {
                    if "lang".localized == "ar" {
                        observer.onNext("الرجاء إدخال كلمة مرور")
                    } else {
                        observer.onNext("Please select your password")
                    }
                }else{
                    observer.onNext("")
                }
                
                return Disposables.create()
            })
        }

    
    func getCountry() -> Observable<CountriesModelJson> {
        let observer = GetServices.shared.getAllCountry()
        return observer
    }
    
    func getTerms() -> Observable<TermsModelJSON> {
        let observer = GetServices.shared.getTerms()
        return observer
    }
    
    
    
}
