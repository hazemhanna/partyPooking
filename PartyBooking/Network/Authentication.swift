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
    func postRegister(image: UIImage?,params: [String : Any]) -> Observable<AfaqModelsJSON> {
        return Observable.create { (observer) -> Disposable in
            let url = ConfigURLS.postRegister
            
            Alamofire.upload(multipartFormData: { (form: MultipartFormData) in
                if let data = image?.jpegData(compressionQuality: 0.8) {
                    form.append(data, withName: "avatar", fileName: "image.jpeg", mimeType: "image/jpeg")
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
                    let registerData = try JSONDecoder().decode(AfaqModelsJSON.self, from: response.data!)
                    print(registerData)
                    if let data = registerData.data {
                        //Helper.saveAPIToken(user_id: data.id ?? 0, email: data.email ?? "", role: data.role ?? 0, name: data.firstName ?? "", token: data.token ?? "",isVarified : data.isVerified ?? 0)
                        Helper.saveUserPhone(phone: data.phone ?? "")
                        Helper.saveUserEmail(Email : data.email ?? "")
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
    
    func validateRegister(params: [String: Any]) -> Observable<AfaqModelsJSON> {
        return Observable.create { (observer) -> Disposable in
            let url = ConfigURLS.validateRegister
            
            Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil)
                .validate(statusCode: 200..<300)
                .responseJSON { (response: DataResponse<Any>) in
                    do {
                        let loginData = try JSONDecoder().decode(AfaqModelsJSON.self, from: response.data!)
                        observer.onNext(loginData)
                    } catch {
                        print(error.localizedDescription)
                        observer.onError(error)
                    }
            }
            
            
            return Disposables.create()
        }
    }//END of POST Login
    
    //MARK:- POST Register Unstructor
      func postRegisterInstracutor(image: UIImage?,params: [String : Any]) -> Observable<AfaqModelsJSON> {
          return Observable.create { (observer) -> Disposable in
              let url = ConfigURLS.postRegister
              
              Alamofire.upload(multipartFormData: { (form: MultipartFormData) in
                if let data = image?.jpegData(compressionQuality: 0.8) {
                      form.append(data, withName: "avatar", fileName: "image.jpeg", mimeType: "image/jpeg")
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
                      let registerData = try JSONDecoder().decode(AfaqModelsJSON.self, from: response.data!)
                      print(registerData)
                     // if let data = registerData.data {
                       // Helper.saveAPIToken(user_id: data.id ?? 0, email: data.email ?? "", role: data.role ?? 0, name: data.firstName ?? "", token: data.token ?? "",isVarified : data.isVerified ?? 0)
                         // }
                       Helper.saveUserEmail(Email : registerData.data?.email ?? "")
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
    func postLogin(params: [String: Any]) -> Observable<LoginModelJSON> {
        return Observable.create { (observer) -> Disposable in
            let url = ConfigURLS.postLogin
            
            Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil)
                .validate(statusCode: 200..<300)
                .responseJSON { (response: DataResponse<Any>) in
                    do {
                        let loginData = try JSONDecoder().decode(LoginModelJSON.self, from: response.data!)
                        if let data = loginData.data {
                            Helper.saveAPIToken(user_id: data.id ?? 0, email: data.email ?? "", role: data.role ?? 0, name: "\(data.firstName ?? "") \(data.lastName ?? "")", token: data.token ?? "",isVarified : data.isVerified ?? 0)
                            Helper.saveUserPhone(phone: data.phone ?? "")
                            Helper.saveUserEmail(Email : data.email ?? "")
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
    
}
