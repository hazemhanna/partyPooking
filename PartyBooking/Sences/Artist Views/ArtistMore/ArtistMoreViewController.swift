//
//  ArtistMoreViewController.swift
//  PartyBooking
//
//  Created by MAC on 7/9/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit

class ArtistMoreViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

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
       


}
