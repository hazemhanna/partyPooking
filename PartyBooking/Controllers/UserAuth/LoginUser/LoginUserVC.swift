//
//  LoginUserVC.swift
//  PartyBooking
//
//  Created by MAC on 20/05/2021.
//  Copyright © 2021 MAC. All rights reserved.
//

import UIKit

class LoginUserVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
