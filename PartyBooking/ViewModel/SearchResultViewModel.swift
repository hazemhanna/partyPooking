//
//  SearchResultViewModel.swift
//  PartyBooking
//
//  Created by MAC on 15/06/2021.
//  Copyright © 2021 MAC. All rights reserved.
//

import Foundation
import RxSwift
import SVProgressHUD


struct SearchResultViewModel {
   
    func showIndicator() {
        SVProgressHUD.show()
    }
    func dismissIndicator() {
        SVProgressHUD.dismiss()
    }
    
    func showProgress(progress: Float) {
        SVProgressHUD.showProgress(progress)
    }
    
    func getSearchResult(area : Int , date : String , type : Int) -> Observable<SearchResultModelJSON> {
        let params: [String: Any] = [
            "area_id": area,
            "date": date,
            "part_type_id": type
            ]
        let observer = AddServices.shared.getsearchResult(params: params)
        return observer
    }
    
    func addFavourite(artistId : Int ) -> Observable<AddFavouriteModel> {
        let params: [String: Any] = [
            "artist_id": artistId,
            ]
        let observer = AddServices.shared.addFavourite(params: params)
        return observer
    }

}
