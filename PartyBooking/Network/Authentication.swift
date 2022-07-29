//
//  Authentication.swift
//  PartyBooking
//
//  Created by MAC on 31/05/2021.
//  Copyright © 2021 MAC. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import RxSwift
import SwiftyJSON

class Authentication {
    
    static let shared = Authentication()
    
    //MARK:- POST Register
    func postRegister(image: UIImage?,params: [String : Any]) -> Observable<AuthMdelsJSON> {
        return Observable.create { (observer) -> Disposable in
            let url = ConfigURLs.postRegister
            
            Alamofire.upload(multipartFormData: { (form: MultipartFormData) in
                if let data = image?.jpegData(compressionQuality: 0.8) {
                    form.append(data, withName: "image", fileName: "image.jpeg", mimeType: "image/jpeg")
                }
                for (key, value) in params {
                    form.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
                }
                        
                }, usingThreshold: SessionManager.multipartFormDataEncodingMemoryThreshold, to: url, method: .post, headers: nil) { (result: SessionManager.MultipartFormDataEncodingResult) in
                    switch result {
                case .failure(let error):
                    print(error.localizedDescription)
                    observer.onError(error)
                case .success(request: let upload, streamingFromDisk: _, streamFileURL: _):
                    upload.uploadProgress { (progress) in
                      print("Image Uploading Progress: \(progress.fractionCompleted)")
                  }.responseJSON { (response: DataResponse<Any>) in
             do {
                    let registerData = try JSONDecoder().decode(AuthMdelsJSON.self, from: response.data!)
                    print(registerData)
                 if let data = registerData.result {
                     Helper.saveAPI(token: data.accessToken ?? "", user_id: data.user?.id ?? 0, email: data.user?.email ?? "", name:data.user?.firstName ?? "",phone: data.user?.phone ?? "" )
                        }
                        observer.onNext(registerData)
                     } catch {
                         print(error.localizedDescription)
                        observer.onError(error)
                    }
                  }
                }
             }
            return Disposables.create()
        }
    }//END of POST Register
    
    //MARK:- POST Login
    func postLogin(params: [String: Any]) -> Observable<AuthMdelsJSON> {
        return Observable.create { (observer) -> Disposable in
            let url = ConfigURLs.userLogin
            
            Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil)
                .validate(statusCode: 200..<300)
                .responseJSON { (response: DataResponse<Any>) in
                    do {
                        let loginData = try JSONDecoder().decode(AuthMdelsJSON.self, from: response.data!)
                        if let data = loginData.result {
                           Helper.saveAPI(token: data.accessToken ?? "", user_id: data.user?.id ?? 0, email: data.user?.email ?? "", name: data.user?.firstName ?? "", phone: data.user?.phone ?? "")
                    }
                    observer.onNext(loginData)
                    } catch {
                        print(error.localizedDescription)
                        observer.onError(error)
                    }
            }
            
            
            return Disposables.create()
        }
    }//END of POST Login
    func postLoginWithSocial(params: [String: Any]) -> Observable<AuthMdelsJSON> {
        return Observable.create { (observer) -> Disposable in
            let url = ConfigURLs.userLoginWithSocial
            Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil)
                .validate(statusCode: 200..<300)
                .responseJSON { (response: DataResponse<Any>) in
                    do {
                        let loginData = try JSONDecoder().decode(AuthMdelsJSON.self, from: response.data!)
                        if let data = loginData.result {
                           Helper.saveAPIToken(token: data.accessToken ?? "")
                        }
                        observer.onNext(loginData)
                    } catch {
                        print(error)
                        observer.onError(error)
                }
            }
            return Disposables.create()
        }
        
    }//END of POST Login
    //MARK:- Artist
    func postRegisterArtist(params: [String: Any]) -> Observable<ArtistModelLoginJSON> {
        return Observable.create { (observer) -> Disposable in
            let url = ConfigURLs.postRegisterArtist
            Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil)
                .validate(statusCode: 200..<300)
                .responseJSON { (response: DataResponse<Any>) in
                    do {
                        let loginData = try JSONDecoder().decode(ArtistModelLoginJSON.self, from: response.data!)
                        if let data = loginData.result {
                        }
                        observer.onNext(loginData)
                    } catch {
                        print(error.localizedDescription)
                        observer.onError(error)
                    }
            }
            return Disposables.create()
        }
    }
    
    
    func artistLogin(params: [String: Any]) -> Observable<ArtistModelLoginJSON> {
        return Observable.create { (observer) -> Disposable in
            let url = ConfigURLs.artistLogin
            Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil)
                .validate(statusCode: 200..<300)
                .responseJSON { (response: DataResponse<Any>) in
                    do {
                        let loginData = try JSONDecoder().decode(ArtistModelLoginJSON.self, from: response.data!)
                        if let data = loginData.result {
                            Helper.saveAPI(token: data.accessToken ?? "", user_id: data.artist?.id ?? 0, email: data.artist?.email ?? "", name: data.artist?.firstName ?? " ",phone : data.artist?.phone ?? "")
                        }
                        observer.onNext(loginData)
                    } catch {
                        print(error.localizedDescription)
                        observer.onError(error)
                    }
            }
            
            
            return Disposables.create()
        }
    }
    

    func logOut() -> Observable<ContactUSModelJson> {
        return Observable.create { (observer) -> Disposable in
            var url = String()

            if Helper.getType() == "user" {
                 url = ConfigURLs.userLogOut
            }else{
                  url = ConfigURLs.artistLogOut
            }
            
            let token = Helper.getAPIToken() ?? ""
            let headers = [
                "Authorization": "Bearer \(token)"
            ]
            Alamofire.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers)
                .validate(statusCode: 200..<300)
                .responseJSON { (response: DataResponse<Any>) in
                    do {
                        let data = try JSONDecoder().decode(ContactUSModelJson.self, from: response.data!)
                        observer.onNext(data)
                    } catch {
                        print(error.localizedDescription)
                        observer.onError(error)
                    }
            }
            
            return Disposables.create()
        }
    }//END
    
    
    
    
}
