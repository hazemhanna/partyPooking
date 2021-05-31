//
//  ForgetPasswordVC2.swift
//  PartyBooking
//
//  Created by MAC on 26/05/2021.
//  Copyright © 2021 MAC. All rights reserved.
//

import UIKit

class ForgetPasswordVC2: UIViewController {

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
    @IBAction func nextButton(sender: UIButton) {
        let destinationVC = ForgetPasswordVC3.instantiateFromNib()
        self.navigationController?.pushViewController(destinationVC!, animated: true)
    }
}
