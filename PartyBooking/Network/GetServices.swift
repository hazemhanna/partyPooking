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
    

    
    
    
}
