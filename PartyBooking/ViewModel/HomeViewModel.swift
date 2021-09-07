//
//  HomeViewModel.swift
//  PartyBooking
//
//  Created by MAC on 13/06/2021.
//  Copyright © 2021 MAC. All rights reserved.
//


import Foundation
import RxSwift
import SVProgressHUD


struct HomeViewModel {
   
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

    
    func getHome() -> Observable<HomeModelJSON> {
        let observer = GetServices.shared.getHome()
        return observer
    }
    
    func getPartyType() -> Observable<PartyTypeModelJSON> {
        let observer = GetServices.shared.getPartyType()
        return observer
    }
    
    func getCountry() -> Observable<CountriesModelJson> {
        let observer = GetServices.shared.getAllCountry()
        return observer
    }
    
    
    func getArea() -> Observable<AreaModelJson> {
        let observer = GetServices.shared.getArea()
        return observer
    }
    
    
    func getBestArtist() -> Observable<BestArtistModelJSON> {
        let observer = GetServices.shared.getBestArtist()
        return observer
    }
    
    func getArtistDetails(artistId  : Int) -> Observable<ArtistProfileModelJSON> {
        let params: [String: Any] = [
            "artist_id": artistId,
            ]
        let observer = GetServices.shared.getArtistDetails(params: params)
        return observer
    }
    
    
    func getArtistWork(artistId  : Int) -> Observable<ArtistWorkModelJSON> {
        let params: [String: Any] = [
            "artist_id": artistId,
            ]
        let observer = GetServices.shared.getArtistWork(params: params)
        return observer
    }
    
    
    func addFavourite(artistId : Int ) -> Observable<AddFavouriteModel> {
        let params: [String: Any] = [
            "artist_id": artistId,
            ]
        let observer = AddServices.shared.addFavourite(params: params)
        return observer
    }
    
    func getOffers() -> Observable<OffersModelJSON> {
        let observer = GetServices.shared.getOffers()
        return observer
    }
    
    func getOfferDetails(artistId : Int ) -> Observable<OffersDetailsModelJSON> {
        let params: [String: Any] = [
            "artist_id": artistId,
            ]
        let observer = AddServices.shared.OffersDetails(params: params)
        return observer
    }
   
    func getSrearchOffer(area_id:Int, party_type_id : Int,date :String) -> Observable<OffersModelJSON> {
        
        let params: [String: Any] = [
            "date": date,
            "area_id": area_id,
            "part_type_id": party_type_id,]
        
        let observer = AddServices.shared.OffersSearch(params: params)
        return observer
    }
    
    
    func getNotification() -> Observable<NotificationModelJSON> {
        let observer = GetServices.shared.getNotification()
        return observer
    }
    
}
