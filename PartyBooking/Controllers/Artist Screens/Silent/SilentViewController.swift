//
//  SilentViewController.swift
//  PartyBooking
//
//  Created by MAC on 7/9/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit

class SilentViewController: UIViewController {
    
    
    @IBOutlet weak var selintLabel : UILabel!
    @IBOutlet weak var titleLabel : UILabel!
//    @IBOutlet weak var activeLabel : UILabel!
    @IBOutlet weak var whenActiveLabel : UILabel!
    @IBOutlet weak var switcherSilent: UISwitch!
    
    @IBOutlet weak var backButton: UIButton! {
           didSet {
               backButton.setImage(backButton.currentImage?.flipIfNeeded(), for: .normal)
           }
       }
       
    @IBOutlet weak var selintView : UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        selintView.layer.cornerRadius = 7
        setUPLocalize()
    }
    
    func setUPLocalize(){
        titleLabel.text = "Selint".localized
        selintLabel.text = "Selint".localized
        //activeLabel.text = "Active".localized
        whenActiveLabel.text = "whenActive".localized
       
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
    
    @IBAction func btnMaleClick(sender: UISwitch){
        if sender.isOn{
            displayMessage(title: "", message: "SelintOff".localized, status: .success, forController: self)
        }else{
            displayMessage(title: "", message: "SelintOn".localized, status: .success, forController: self)
        }
    }
}
