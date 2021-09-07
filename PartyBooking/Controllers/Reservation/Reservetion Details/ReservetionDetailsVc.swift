//
//  ReservetionDetailsVc.swift
//  PartyBooking
//
//  Created by MAC on 26/05/2021.
//  Copyright © 2021 MAC. All rights reserved.
//

import UIKit
import Cosmos

class ReservetionDetailsVc : UIViewController {
    
    @IBOutlet weak var rateView :UIView!
    @IBOutlet weak var cancelReasonView : UIView!
    @IBOutlet weak var partyType :UILabel!
    @IBOutlet weak var PartyTime :UILabel!
    @IBOutlet weak var Partydate :UILabel!
    @IBOutlet weak var Partydlocation :UILabel!
    @IBOutlet weak var noteLbl  :UILabel!
    @IBOutlet weak var statusLbl :UILabel!
    @IBOutlet weak var artistName :UILabel!
    @IBOutlet weak var reservationNum :UILabel!
    @IBOutlet weak var canelReason :UILabel!
    @IBOutlet weak var ratView :CosmosView!

    var ended = false
    var cancel = false
    var reservation:Reservation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if "lang".localized == "ar" {
             partyType.text = reservation?.partyType?.arName
         }else{
            partyType.text = reservation?.partyType?.enName
        }
        
        let from = reservation?.fromTime ?? ""
        let  to =  reservation?.toTime ?? ""
        PartyTime.text =  ("From".localized + from) + ("To".localized + to)
        noteLbl.text = reservation?.partyType?.arName
        statusLbl.text = reservation?.status?.localized ?? ""
        artistName.text = (reservation?.artist?.firstName ?? "" ) + " " + (reservation?.artist?.lastName ?? "")
        reservationNum.text = String(reservation?.id ?? 0 )
        canelReason.text = reservation?.cancelReason ?? ""
        Partydate.text = reservation?.date ?? ""
        ratView.rating = Double(reservation?.rate ?? 0)
        
        if "lang".localized == "ar" {
            Partydlocation.text = reservation?.area?.arName ?? ""
         }else{
            Partydlocation.text = reservation?.area?.enName ?? ""
        }
        
        cancelReasonView.isHidden = true
        rateView.isHidden = true
        if ended {
            rateView.isHidden = false
            cancelReasonView.isHidden = true
        }
        if cancel{
            rateView.isHidden = true
            cancelReasonView.isHidden = false
        }
    }
    
    @IBAction func backButton(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
