//
//  GetServices.swift
//  PartyBooking
//
//  Created by MAC on 8/5/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import RxSwift


struct GetServices {
    
    static let shared = GetServices()
    
    
    func getAllCountry() -> Observable<CountriesModelJson> {
        return Observable.create { (observer) -> Disposable in
            let url = ConfigURLs.getCountry
            
            Alamofire.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: nil)
                .validate(statusCode: 200..<300)
                .responseJSON { (response: DataResponse<Any>) in
                    do {
                        let data = try JSONDecoder().decode(CountriesModelJson.self, from: response.data!)
                        observer.onNext(data)
                    } catch {
                        print(error.localizedDescription)
                        observer.onError(error)
                    }
            }
            
            return Disposables.create()
        }
    }//END of GET All Jobs
    
    func getArea() -> Observable<AreaModelJson> {
        return Observable.create { (observer) -> Disposable in
            let url = ConfigURLs.getArea
            
            Alamofire.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: nil)
                .validate(statusCode: 200..<300)
                .responseJSON { (response: DataResponse<Any>) in
                    do {
                        let data = try JSONDecoder().decode(AreaModelJson.self, from: response.data!)
                        observer.onNext(data)
                    } catch {
                        print(error.localizedDescription)
                        observer.onError(error)
                    }
            }
            
            return Disposables.create()
        }
    }
    
    
    
    func getTerms() -> Observable<TermsModelJSON> {
        return Observable.create { (observer) -> Disposable in
            let url = ConfigURLs.getTerms
            
            Alamofire.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: nil)
                .validate(statusCode: 200..<300)
                .responseJSON { (response: DataResponse<Any>) in
                    do {
                        let data = try JSONDecoder().decode(TermsModelJSON.self, from: response.data!)
                        observer.onNext(data)
                    } catch {
                        print(error.localizedDescription)
                        observer.onError(error)
                    }
            }
            
            return Disposables.create()
        }
    }//END of GET All Jobs
    
    
    func about() -> Observable<AboutUSModelJSON> {
        return Observable.create { (observer) -> Disposable in
            let url = ConfigURLs.getAbout
            
            Alamofire.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: nil)
                .validate(statusCode: 200..<300)
                .responseJSON { (response: DataResponse<Any>) in
                    do {
                        let data = try JSONDecoder().decode(AboutUSModelJSON.self, from: response.data!)
                        observer.onNext(data)
                    } catch {
                        print(error.localizedDescription)
                        observer.onError(error)
                    }
            }
            
            return Disposables.create()
        }
    }//END of GET All Jobs
    
    func contactUs(params: [String : Any]) -> Observable<ContactUSModelJson> {
        return Observable.create { (observer) -> Disposable in
            let url = ConfigURLs.contactUs
            
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
    }//END of GET All Jobs
    
    
    
    func getHome() -> Observable<HomeModelJSON> {
        return Observable.create { (observer) -> Disposable in
            let url = ConfigURLs.getHome
            
            Alamofire.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: nil)
                .validate(statusCode: 200..<300)
                .responseJSON { (response: DataResponse<Any>) in
                    do {
                        let data = try JSONDecoder().decode(HomeModelJSON.self, from: response.data!)
                        observer.onNext(data)
                    } catch {
                        print(error.localizedDescription)
                        observer.onError(error)
                    }
            }
            
            return Disposables.create()
        }
    }//END of GET All Jobs
    
    
  
    func getPartyType() -> Observable<PartyTypeModelJSON> {
        return Observable.create { (observer) -> Disposable in
            let url = ConfigURLs.getPartType
            
            Alamofire.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: nil)
                .validate(statusCode: 200..<300)
                .responseJSON { (response: DataResponse<Any>) in
                    do {
                        let data = try JSONDecoder().decode(PartyTypeModelJSON.self, from: response.data!)
                        observer.onNext(data)
                    } catch {
                        print(error.localizedDescription)
                        observer.onError(error)
                    }
            }
            
            return Disposables.create()
        }
    }//END of GET All Jobs
    
      func getServices() -> Observable<PartyTypeModelJSON> {
          return Observable.create { (observer) -> Disposable in
              let url = ConfigURLs.getService
              
              Alamofire.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: nil)
                  .validate(statusCode: 200..<300)
                  .responseJSON { (response: DataResponse<Any>) in
                      do {
                          let data = try JSONDecoder().decode(PartyTypeModelJSON.self, from: response.data!)
                          observer.onNext(data)
                      } catch {
                          print(error.localizedDescription)
                          observer.onError(error)
                      }
              }
              
              return Disposables.create()
          }
      }
    
    func getBestArtist() -> Observable<BestArtistModelJSON> {
        return Observable.create { (observer) -> Disposable in
            let url = ConfigURLs.getBestArtist
            
            Alamofire.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: nil)
                .validate(statusCode: 200..<300)
                .responseJSON { (response: DataResponse<Any>) in
                    do {
                        let data = try JSONDecoder().decode(BestArtistModelJSON.self, from: response.data!)
                        observer.onNext(data)
                    } catch {
                        print(error.localizedDescription)
                        observer.onError(error)
                    }
            }
            
            return Disposables.create()
        }
    }//END
    
    
    
    
    func getFavourite() -> Observable<FavouriteModelJSON> {
        return Observable.create { (observer) -> Disposable in
            let url = ConfigURLs.getFavourite
            
            let token = Helper.getAPIToken() ?? ""
            let headers = [
                "Authorization": "Bearer \(token)"
            ]
            
            Alamofire.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers)
                .validate(statusCode: 200..<300)
                .responseJSON { (response: DataResponse<Any>) in
                    do {
                        let data = try JSONDecoder().decode(FavouriteModelJSON.self, from: response.data!)
                        observer.onNext(data)
                    } catch {
                        print(error.localizedDescription)
                        observer.onError(error)
                    }
            }
            
            return Disposables.create()
        }
    }//END
    
    func getReservation() -> Observable<ReservationModelJSON> {
        return Observable.create { (observer) -> Disposable in
            let url = ConfigURLs.getReservation
            
            let token = Helper.getAPIToken() ?? ""
            let headers = [
                "Authorization": "Bearer \(token)"
            ]
            
            Alamofire.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers)
                .validate(statusCode: 200..<300)
                .responseJSON { (response: DataResponse<Any>) in
                    do {
                        let data = try JSONDecoder().decode(ReservationModelJSON.self, from: response.data!)
                        observer.onNext(data)
                    } catch {
                        print(error.localizedDescription)
                        observer.onError(error)
                    }
            }
            
            return Disposables.create()
        }
    }//END
    
    
    
    
    func getArtistDetails(params: [String : Any]) -> Observable<ArtistProfileModelJSON> {
        return Observable.create { (observer) -> Disposable in
            let url = ConfigURLs.getArtistDetails
            let token = Helper.getAPIToken() ?? ""
            let headers = [
                "Authorization": "Bearer \(token)"
            ]
            Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
                .validate(statusCode: 200..<300)
                .responseJSON { (response: DataResponse<Any>) in
                    do {
                        let data = try JSONDecoder().decode(ArtistProfileModelJSON.self, from: response.data!)
                        observer.onNext(data)
                    } catch {
                        print(error.localizedDescription)
                        observer.onError(error)
                    }
            }
            
            return Disposables.create()
        }
    }//END
    
    
    
    func getArtistWork(params: [String : Any]) -> Observable<ArtistWorkModelJSON> {
        return Observable.create { (observer) -> Disposable in
            let url = ConfigURLs.getArtistWork
            let token = Helper.getAPIToken() ?? ""
            let headers = [
                "Authorization": "Bearer \(token)"
            ]
            Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
                .validate(statusCode: 200..<300)
                .responseJSON { (response: DataResponse<Any>) in
                    do {
                        let data = try JSONDecoder().decode(ArtistWorkModelJSON.self, from: response.data!)
                        observer.onNext(data)
                    } catch {
                        print(error.localizedDescription)
                        observer.onError(error)
                    }
            }
            
            return Disposables.create()
        }
    }//END
    
    
    
    
    
    
    
    func getLive() -> Observable<LiveModelJSON> {
        return Observable.create { (observer) -> Disposable in
            let url = ConfigURLs.getLive
            let token = Helper.getAPIToken() ?? ""
            let headers = [
                "Authorization": "Bearer \(token)"
            ]
            Alamofire.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers)
                .validate(statusCode: 200..<300)
                .responseJSON { (response: DataResponse<Any>) in
                    do {
                        let data = try JSONDecoder().decode(LiveModelJSON.self, from: response.data!)
                        observer.onNext(data)
                    } catch {
                        print(error.localizedDescription)
                        observer.onError(error)
                    }
            }
            return Disposables.create()
        }
    }//END
    
    
    
    func getOffers() -> Observable<OffersModelJSON> {
        return Observable.create { (observer) -> Disposable in
            let url = ConfigURLs.getOffers
            let token = Helper.getAPIToken() ?? ""
            let headers = [
                "Authorization": "Bearer \(token)"
            ]
            Alamofire.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers)
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
    }
    
    
    
    
    func getProfile() -> Observable<ProfileModelJSON> {
        return Observable.create { (observer) -> Disposable in
            let url = ConfigURLs.getProfile
            let token = Helper.getAPIToken() ?? ""
            let headers = [
                "Authorization": "Bearer \(token)"
            ]
            Alamofire.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers)
                .validate(statusCode: 200..<300)
                .responseJSON { (response: DataResponse<Any>) in
                    do {
                        let data = try JSONDecoder().decode(ProfileModelJSON.self, from: response.data!)
                        observer.onNext(data)
                    } catch {
                        print(error.localizedDescription)
                        observer.onError(error)
                    }
            }
            return Disposables.create()
        }
    }//END
    
    func getNotification() -> Observable<NotificationModelJSON> {
        return Observable.create { (observer) -> Disposable in
            let url = ConfigURLs.getNotification
            let token = Helper.getAPIToken() ?? ""
            let headers = [
                "Authorization": "Bearer \(token)"
            ]
            Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
                .validate(statusCode: 200..<300)
                .responseJSON { (response: DataResponse<Any>) in
                    do {
                        let data = try JSONDecoder().decode(NotificationModelJSON.self, from: response.data!)
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
