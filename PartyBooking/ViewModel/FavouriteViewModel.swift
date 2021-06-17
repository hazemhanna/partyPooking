//
//  FavouriteViewModel.swift
//  PartyBooking
//
//  Created by MAC on 17/06/2021.
//  Copyright © 2021 MAC. All rights reserved.
//


import Foundation
import RxSwift
import SVProgressHUD


struct FavouriteViewModel {
   
    func showIndicator() {
        SVProgressHUD.show()
    }
    func dismissIndicator() {
        SVProgressHUD.dismiss()
    }
    
    func showProgress(progress: Float) {
        SVProgressHUD.showProgress(progress)
    }
    
    func getFavourite() -> Observable<FavouriteModelJSON> {
        let observer = GetServices.shared.getFavourite()
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
