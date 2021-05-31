//
//  RegisterViewController.swift
//  PartyBooking
//
//  Created by MAC on 7/7/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit

class ChooseUSerTypeVC : UIViewController {
    
    @IBOutlet weak var artistView : UIView!
    @IBOutlet weak var userView : UIView!
    @IBOutlet weak var regiserUser: UIButton!
    @IBOutlet weak var regiserArtist : UIButton!
    @IBOutlet weak var skipBtn: UIButton!
    @IBOutlet weak var welcomeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func skipButton(sender: UIButton) {
        let destinationVC = TabBarController.instantiate(fromAppStoryboard: .Main)
        if let appDelegate = UIApplication.shared.delegate {
            appDelegate.window??.rootViewController = destinationVC
        }
        
        
        
    }
    
    @IBAction func registerUserButton(sender: UIButton) {
        let main = MainRegisterVC.instantiateFromNib()
        main?.isUser = true
        self.navigationController!.pushViewController(main!, animated: true)
    }

    
    @IBAction func registerArtistButton(sender: UIButton) {
        let main = MainRegisterVC.instantiateFromNib()
        main?.isUser = false
        self.navigationController?.pushViewController(main!, animated: true)
    }
    
}

