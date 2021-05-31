//
//  ReservetionDetailsVc.swift
//  PartyBooking
//
//  Created by MAC on 26/05/2021.
//  Copyright © 2021 MAC. All rights reserved.
//

import UIKit

class ReservetionDetailsVc : UIViewController {

    @IBOutlet weak var rateView :UIView!
    @IBOutlet weak var cancelReasonView : UIView!

    var ended = false
    var cancel = false
    
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
