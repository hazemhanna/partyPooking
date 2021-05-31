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
    
    @IBAction func forgetButton(sender: UIButton) {
        let destinationVC = ForgetPasswordVC1.instantiateFromNib()
        self.navigationController?.pushViewController(destinationVC!, animated: true)
    }
    
    @IBAction func loginButton(sender: UIButton) {
        let destinationVC = TabBarController.instantiate(fromAppStoryboard: .Main)
        destinationVC.type = .user
        if let appDelegate = UIApplication.shared.delegate {
            appDelegate.window??.rootViewController = destinationVC
        }
    }

    
}
