//
//  CallCenterViewController.swift
//  PartyBooking
//
//  Created by MAC on 7/5/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit

class CallCenterViewController: UIViewController {
    
    @IBOutlet weak var sendBtn : UIButton!
    @IBOutlet weak var titleLabel : UILabel!
    
    @IBOutlet weak var NameLabel : UILabel!
    @IBOutlet weak var emailLabel : UILabel!
    @IBOutlet weak var phoneLabel : UILabel!
    @IBOutlet weak var messageLabel : UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var NameTextField: UITextField!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var backButton: UIButton! {
          didSet {
              backButton.setImage(backButton.currentImage?.flipIfNeeded(), for: .normal)
          }
      }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sendBtn.layer.cornerRadius = 7
        setUPLocalize()
    }
    
    func setUPLocalize(){
        titleLabel.text = "callCenter".localized
        sendBtn.setTitle("send".localized, for: .normal)
        NameLabel.text = "name".localized
        emailLabel.text = "email".localized
        phoneLabel.text = "phone".localized
        messageLabel.text = "message".localized
            emailTextField.textAlignment = .center
            messageTextField.textAlignment = .center
            NameTextField.textAlignment = .center
            phoneTextField.textAlignment = .center
        
        
        
        
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
