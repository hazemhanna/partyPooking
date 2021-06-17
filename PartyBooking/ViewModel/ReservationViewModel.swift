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
    


}
