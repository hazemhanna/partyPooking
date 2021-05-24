//
//  MainRegisterVC.swift
//  PartyBooking
//
//  Created by MAC on 27/04/2021.
//  Copyright © 2021 MAC. All rights reserved.
//

import UIKit

class MainRegisterVC: UIViewController {
    
    var isUser : Bool = true
   
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func registerFirstTimeAction(sender: UIButton) {
        if isUser{
            let destinationVC = UserRegisterTypeVc.instantiateFromNib()
            self.navigationController!.pushViewController(destinationVC!, animated: true)
        }else{
            let destinationVC = ArtistRegisterViewController.instantiateFromNib()
            self.navigationController?.pushViewController(destinationVC!, animated: true)
        }
    }

    @IBAction func back(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func haveAcountAction(sender: UIButton) {
        if isUser{
            let main = LoginUserVC.instantiateFromNib()
            self.navigationController?.pushViewController(main!, animated: true)
        }else{
            let main = LoginVC.instantiateFromNib()
            self.navigationController?.pushViewController(main!, animated: true)
        }
    }
}
