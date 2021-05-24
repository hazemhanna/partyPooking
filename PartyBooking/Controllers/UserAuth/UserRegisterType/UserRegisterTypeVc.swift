//
//  UserRegisterTypeVc.swift
//  PartyBooking
//
//  Created by MAC on 20/05/2021.
//  Copyright © 2021 MAC. All rights reserved.
//

import UIKit

class UserRegisterTypeVc: UIViewController {

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
    
    
    @IBAction func creatcountAction(sender: UIButton) {
        let destinationVC = UserRegisterViewController.instantiateFromNib()
      self.navigationController!.pushViewController(destinationVC!, animated: true)
      
    }
        
}
