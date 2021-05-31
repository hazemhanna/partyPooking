
//
//  ArtistLoginVC.swift
//  PartyBooking
//
//  Created by MAC on 27/04/2021.
//  Copyright © 2021 MAC. All rights reserved.
//

import UIKit

class LoginVC : UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func back(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    
    @IBAction func logInButton(sender: UIButton) {
            let destinationVC = TabBarController.instantiate(fromAppStoryboard: .Main)
            destinationVC.type = .artist
            if let appDelegate = UIApplication.shared.delegate {
                appDelegate.window??.rootViewController = destinationVC
            }
    }
}
