//
//  ReservationViewModel.swift
//  PartyBooking
//
//  Created by MAC on 17/06/2021.
//  Copyright © 2021 MAC. All rights reserved.
//




import Foundation
import RxSwift
import SVProgressHUD


struct ReservationViewModel {
   
    func showIndicator() {
        SVProgressHUD.show()
    }
    func dismissIndicator() {
        SVProgressHUD.dismiss()
    }
    
    func showProgress(progress: Float) {
        SVProgressHUD.showProgress(progress)
    }
    
    
    func getReservation() -> Observable<ReservationModelJSON> {
        let observer = GetServices.shared.getReservation()
        return observer
    }
    
    
    func cancelReservation(booking_id:Int,cancel_reason : String) -> Observable<ContactUSModelJson> {
        let params: [String: Any] = [
            "booking_id": booking_id,
            "cancel_reason": cancel_reason
            ]
        
        let observer = AddServices.shared.cancelReservation(params: params)
        return observer
    }
    
    
    func rateReservation(booking_id:Int,comment : String, rate : Int) -> Observable<ContactUSModelJson> {
        let params: [String: Any] = [
            "booking_id": booking_id,
            "rate": rate,
            "comment": comment]
        let observer = AddServices.shared.rateReservation(params: params)
        return observer
    }
    
}
