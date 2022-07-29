//
//  ArtistProfileViewModel.swift
//  PartyBooking
//
//  Created by MAC on 18/09/2021.
//  Copyright © 2021 MAC. All rights reserved.
//


import Foundation
import RxSwift
import SVProgressHUD


struct ArtistProfileViewModel{
   
    var descritpionss = BehaviorSubject<String>(value: "")
    var first_name = BehaviorSubject<String>(value: "")
    var last_name = BehaviorSubject<String>(value: "")
    
    func showIndicator() {
        SVProgressHUD.show()
    }
    func dismissIndicator() {
        SVProgressHUD.dismiss()
    }
    
    func showProgress(progress: Float) {
        SVProgressHUD.showProgress(progress)
    }
    
    func getProfile() -> Observable<ArtistHomeModelJson> {
        let observer = GetServices.shared.getArtistProfile()
        return observer
    }
    
    //MARK:- Attempt to register
    func changePhoto(image : UIImage) -> Observable<MessageModel> {
        let observer = AddServices.shared.artistChageProfilePhoto(image: image)
        return observer
    }
    
    func getArtistWork(artistId  : Int) -> Observable<ArtistWorkModelJSON> {
        let params: [String: Any] = [
            "artist_id": artistId,
            ]
        let observer = GetServices.shared.getArtistWork(params: params)
        return observer
    }
    
    
    func updateDescription() -> Observable<MessageModel> {
        let bindedName = (try? self.first_name.value()) ?? ""
        let bindedLastName = (try? self.last_name.value()) ?? ""
        let bindedEmail = (try? self.descritpionss.value()) ?? ""
        
        let params: [String: Any] = [
            "first_name": bindedName,
            "last_name": bindedLastName,
            "description": bindedEmail,
            ]
        
        let observer = AddServices.shared.updateDescription(params: params)
        return observer
    }
    

    
    func validate() -> Observable<String> {
            return Observable.create({ (observer) -> Disposable in
                let bindedName = (try? self.first_name.value()) ?? ""
                let bindedLastName = (try? self.last_name.value()) ?? ""
                let bindedEmail = (try? self.descritpionss.value()) ?? ""

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
              }else if bindedEmail.isEmpty {
                    if "lang".localized == "ar" {
                        observer.onNext("الرجاء إدخال نبذة عنك")
                    } else {
                        observer.onNext("Please Enter Your description ")
                    }
                }else{
                    observer.onNext("")
                }
                return Disposables.create()
            })
        }
    
    
    func availability(dates : [String],status : String ) -> Observable<MessageModel> {
        let params: [String: Any] = [
            "dates": dates,
            "status": status
            ]
        let observer = AddServices.shared.availability(params: params)
        return observer
    }
    
    
    func getAvailability(month : String,year : String ) -> Observable<AvailableDatesModelJSON> {
        let params: [String: Any] = [
            "month": month,
            "year": year
            ]
        let observer = AddServices.shared.getAvailability(params: params)
        return observer
    }
    
    func uploadWork(image_url : UIImage?,videoUrl: Data?) -> Observable<MessageModel> {
        let observer = AddServices.shared.uploadWork(image_url : image_url,videoUrl: videoUrl)
        return observer
    }
    

    
}
