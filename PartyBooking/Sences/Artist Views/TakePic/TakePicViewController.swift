//
//  TakePicViewController.swift
//  PartyBooking
//
//  Created by MAC on 7/8/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit

class TakePicViewController: UIViewController {

    @IBOutlet weak var nextBtn : UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        nextBtn.layer.cornerRadius = 7

    }


  override func viewWillAppear(_ animated: Bool) {
          self.navigationController?.navigationBar.isHidden = true
        }
        override func viewWillDisappear(_ animated: Bool) {
            self.navigationController?.navigationBar.isHidden = false
        }
     
  
  @IBAction func backButton(sender: UIButton) {
      self.navigationController?.popViewController(animated: true)
  }
  
    @IBAction func nextButton(sender: UIButton) {
            let destinationVC = OfferPriceViewController.instantiateFromNib()
           self.navigationController?.pushViewController(destinationVC!, animated: true)
                  
       }
    

}
