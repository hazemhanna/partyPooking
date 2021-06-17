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
    
    
    
}
