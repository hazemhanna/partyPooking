//
//  LiveViewModel.swift
//  PartyBooking
//
//  Created by MAC on 03/08/2021.
//  Copyright © 2021 MAC. All rights reserved.
//

import Foundation
import RxSwift
import SVProgressHUD


struct LiveViewModel {
   
    func showIndicator() {
        SVProgressHUD.show()
    }
    func dismissIndicator() {
        SVProgressHUD.dismiss()
    }
    
    func showProgress(progress: Float) {
        SVProgressHUD.showProgress(progress)
    }
    
    func getLive() -> Observable<LiveModelJSON> {
        let observer = GetServices.shared.getLive()
        return observer
    }
    


}
