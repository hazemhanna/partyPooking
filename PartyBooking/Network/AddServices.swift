//
//  AddServices.swift
//  PartyBooking
//
//  Created by MAC on 31/05/2021.
//  Copyright © 2021 MAC. All rights reserved.
//

import Foundation
import Foundation
import Alamofire
import RxSwift
import SwiftyJSON

struct AddServices {
    
    static let shared = AddServices()
    
    func getsearchResult(params: [String : Any]) -> Observable<SearchResultModelJSON> {
        return Observable.create { (observer) -> Disposable in
            let url = ConfigURLs.getSearch
            let token = Helper.getAPIToken() ?? ""
            let headers = [
                "Authorization": "Bearer \(token)"
            ]

            Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
                .validate(statusCode: 200..<300)
                .responseJSON { (response: DataResponse<Any>) in
                    do {
                        let data = try JSONDecoder().decode(SearchResultModelJSON.self, from: response.data!)
                        observer.onNext(data)
                    } catch {
                        print(error)
                        observer.onError(error)
                    }
            }
            
            return Disposables.create()
        }
    }//END
    
    
    func addFavourite(params: [String : Any]) -> Observable<AddFavouriteModel> {
        return Observable.create { (observer) -> Disposable in
            let url = ConfigURLs.addFavourite
            let token = Helper.getAPIToken() ?? ""
            let headers = [
                "Authorization": "Bearer \(token)"
            ]
            Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
                .validate(statusCode: 200..<300)
                .responseJSON { (response: DataResponse<Any>) in
                    do {
                        let data = try JSONDecoder().decode(AddFavouriteModel.self, from: response.data!)
                        observer.onNext(data)
                    } catch {
                        print(error.localizedDescription)
                        observer.onError(error)
                    }
            }
            
            return Disposables.create()
        }
    }//END
    
    func OffersSearch(params: [String : Any]) -> Observable<OffersModelJSON> {
        return Observable.create { (observer) -> Disposable in
            let url = ConfigURLs.OffersSearch
            let token = Helper.getAPIToken() ?? ""
            let headers = [
                "Authorization": "Bearer \(token)"
            ]
            Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
                .validate(statusCode: 200..<300)
                .responseJSON { (response: DataResponse<Any>) in
                    do {
                        let data = try JSONDecoder().decode(OffersModelJSON.self, from: response.data!)
                        observer.onNext(data)
                    } catch {
                        print(error.localizedDescription)
                        observer.onError(error)
                    }
            }
            
            return Disposables.create()
        }
    }//
    
    //MARK:- POST Register
    func chageProfilePhoto(image: UIImage?) -> Observable<MessageModel> {
        return Observable.create { (observer) -> Disposable in
            let url = ConfigURLs.chageProfilePhoto
            let token = Helper.getAPIToken() ?? ""
            let headers = [
                "Authorization": "Bearer \(token)"
            ]
            
            Alamofire.upload(multipartFormData: { (form: MultipartFormData) in
                if let data = image?.jpegData(compressionQuality: 0.8) {
                    form.append(data, withName: "image", fileName: "image.jpeg", mimeType: "image/jpeg")
                }
                }, usingThreshold: SessionManager.multipartFormDataEncodingMemoryThreshold, to: url, method: .post, headers: headers) { (result: SessionManager.MultipartFormDataEncodingResult) in
                    switch result {
                case .failure(let error):
                    print(error.localizedDescription)
                    observer.onError(error)
                case .success(request: let upload, streamingFromDisk: _, streamFileURL: _):
                    upload.uploadProgress { (progress) in
                      print("Image Uploading Progress: \(progress.fractionCompleted)")
                  }.responseJSON { (response: DataResponse<Any>) in
             do {
                    let data = try JSONDecoder().decode(MessageModel.self, from: response.data!)
                    observer.onNext(data)
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
    
    func editProfile(params: [String : Any]) -> Observable<MessageModel> {
        return Observable.create { (observer) -> Disposable in
            let url = ConfigURLs.editProfile
            let token = Helper.getAPIToken() ?? ""
            let headers = [
                "Authorization": "Bearer \(token)"
            ]
            Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
                .validate(statusCode: 200..<300)
                .responseJSON { (response: DataResponse<Any>) in
                    do {
                        let data = try JSONDecoder().decode(MessageModel.self, from: response.data!)
                        observer.onNext(data)
                    } catch {
                        print(error.localizedDescription)
                        observer.onError(error)
                    }
            }
            
            return Disposables.create()
        }
    }//END
    
    
    
    func OffersDetails(params: [String : Any]) -> Observable<OffersDetailsModelJSON> {
        return Observable.create { (observer) -> Disposable in
            let url = ConfigURLs.offerDetails
            let token = Helper.getAPIToken() ?? ""
            let headers = [
                "Authorization": "Bearer \(token)"
            ]
            Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
                .validate(statusCode: 200..<300)
                .responseJSON { (response: DataResponse<Any>) in
                    do {
                        let data = try JSONDecoder().decode(OffersDetailsModelJSON.self, from: response.data!)
                        observer.onNext(data)
                    } catch {
                        print(error.localizedDescription)
                        observer.onError(error)
                    }
            }
            
            return Disposables.create()
        }
    }//END
    
    
    func cancelReservation(params: [String : Any]) -> Observable<ContactUSModelJson> {
        return Observable.create { (observer) -> Disposable in
            var url = String()
            if Helper.getType() == "user" {
             url = ConfigURLs.cancelReservation
            }else{
             url = ConfigURLs.cancelBooking
            }
            
            
            let token = Helper.getAPIToken() ?? ""
            let headers = [
                "Authorization": "Bearer \(token)"
            ]
            Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
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
    func rateReservation(params: [String : Any]) -> Observable<ContactUSModelJson> {
        return Observable.create { (observer) -> Disposable in
            var url = String()
             url = ConfigURLs.rateReservation
                let token = Helper.getAPIToken() ?? ""
            let headers = [
                "Authorization": "Bearer \(token)"
            ]
            Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
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
    
    func postBooking(params: [String : Any]) -> Observable<ContactUSModelJson> {
        return Observable.create { (observer) -> Disposable in
            let url = ConfigURLs.postBooking
            let token = Helper.getAPIToken() ?? ""
            let headers = [
                "Authorization": "Bearer \(token)"
            ]
            Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
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
    
    
    //MARK:- POST Register
    func artistChageProfilePhoto(image: UIImage?) -> Observable<MessageModel> {
        return Observable.create { (observer) -> Disposable in
            let url = ConfigURLs.artistChageProfilePhoto
            let token = Helper.getAPIToken() ?? ""
            let headers = [
                "Authorization": "Bearer \(token)"
            ]
            
            Alamofire.upload(multipartFormData: { (form: MultipartFormData) in
                if let data = image?.jpegData(compressionQuality: 0.8) {
                    form.append(data, withName: "image", fileName: "image.jpeg", mimeType: "image/jpeg")
                }
                }, usingThreshold: SessionManager.multipartFormDataEncodingMemoryThreshold, to: url, method: .post, headers: headers) { (result: SessionManager.MultipartFormDataEncodingResult) in
                    switch result {
                case .failure(let error):
                    print(error.localizedDescription)
                    observer.onError(error)
                case .success(request: let upload, streamingFromDisk: _, streamFileURL: _):
                    upload.uploadProgress { (progress) in
                      print("Image Uploading Progress: \(progress.fractionCompleted)")
                  }.responseJSON { (response: DataResponse<Any>) in
             do {
                    let data = try JSONDecoder().decode(MessageModel.self, from: response.data!)
                    observer.onNext(data)
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
    
    
    
    func updateDescription(params: [String : Any]) -> Observable<MessageModel> {
        return Observable.create { (observer) -> Disposable in
            let url = ConfigURLs.updateDescription
            let token = Helper.getAPIToken() ?? ""
            let headers = [
                "Authorization": "Bearer \(token)"
            ]
            Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
                .validate(statusCode: 200..<300)
                .responseJSON { (response: DataResponse<Any>) in
                    do {
                        let data = try JSONDecoder().decode(MessageModel.self, from: response.data!)
                        observer.onNext(data)
                    } catch {
                        print(error.localizedDescription)
                        observer.onError(error)
                    }
            }
            
            return Disposables.create()
        }
    }//END
    
    func updatePrices(params: [String:Any])  -> Observable<MessageModel> {
        return Observable.create { (observer) -> Disposable in

        let url = ConfigURLs.updatePrices
            let token = Helper.getAPIToken() ?? ""
            let headers = [
                "Authorization": "Bearer \(token)"
            ]
            Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON { (response: DataResponse<Any>) in
                do {
                    let data = try JSONDecoder().decode(MessageModel.self, from: response.data!)
                    observer.onNext(data)
                } catch {
                    print(error)
                    observer.onError(error)
                }
        }
            return Disposables.create()
        }
    }
    
    
    func availability(params: [String:Any])  -> Observable<MessageModel> {
        return Observable.create { (observer) -> Disposable in

        let url = ConfigURLs.availability
            let token = Helper.getAPIToken() ?? ""
            let headers = [
                "Authorization": "Bearer \(token)"
            ]
            Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON { (response: DataResponse<Any>) in
                do {
                    let data = try JSONDecoder().decode(MessageModel.self, from: response.data!)
                    observer.onNext(data)
                } catch {
                    print(error.localizedDescription)
                    observer.onError(error)
                }
        }
            return Disposables.create()
        }
    }
    
    func getAvailability(params: [String:Any])  -> Observable<AvailableDatesModelJSON> {
        return Observable.create { (observer) -> Disposable in
        let url = ConfigURLs.getAvailability
            let token = Helper.getAPIToken() ?? ""
            let headers = [
                "Authorization": "Bearer \(token)"
            ]
            Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON { (response: DataResponse<Any>) in
                do {
                    let data = try JSONDecoder().decode(AvailableDatesModelJSON.self, from: response.data!)
                    observer.onNext(data)
                } catch {
                    print(error.localizedDescription)
                    observer.onError(error)
                }
        }
            return Disposables.create()
        }
    }
    
    func uploadWork(image_url: UIImage?,videoUrl: Data?) -> Observable<MessageModel> {
          return Observable.create { (observer) -> Disposable in
              
             let url = ConfigURLs.artistAddWork
             let token = Helper.getAPIToken() ?? ""
             let headers = [
                  "Authorization": "Bearer \(token)"]
              
           Alamofire.upload(multipartFormData: { (form: MultipartFormData) in
               if let video = videoUrl {
                form.append(video, withName: "file", fileName: "video.mp4", mimeType: "video/mp4")
               }

               if let data = image_url?.jpegData(compressionQuality: 0.5) {
                form.append(data, withName: "file", fileName: "image.jpeg", mimeType: "image/jpeg")
                }
                  
              }, usingThreshold: UInt64.init(), to: url, method: .post, headers: headers) { (result: SessionManager.MultipartFormDataEncodingResult) in
                      switch result {
                  case .failure(let error):
                      print(error.localizedDescription)
                      observer.onError(error)
                  case .success(request: let upload, streamingFromDisk: _, streamFileURL: _):
                      upload.uploadProgress { (progress) in
                        print("Image Uploading Progress: \(progress.fractionCompleted)")
                    }.responseJSON { (response: DataResponse<Any>) in
               do {
                      let data = try JSONDecoder().decode(MessageModel.self, from: response.data!)
                        print(data)
                        observer.onNext(data)
                       } catch {
                           print(error.localizedDescription)
                          observer.onError(error)
                      }
                    }
                  }
               }
              return Disposables.create()
          }
      }
}
    

