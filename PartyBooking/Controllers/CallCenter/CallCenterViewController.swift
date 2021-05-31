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
    

    @IBOutlet weak var messageTitleLabel : UILabel!
    @IBOutlet weak var messageTitleTextField: TextFieldDropDown!

    var titles = ["compline".localized,"suggestion".localized]

    @IBOutlet weak var messageLabel : UILabel!
    @IBOutlet weak var messageTextField: UITextField!
  
    @IBOutlet weak var backButton: UIButton! {
          didSet {
              backButton.setImage(backButton.currentImage?.flipIfNeeded(), for: .normal)
          }
      }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sendBtn.layer.cornerRadius = 8
        setUPLocalize()
        titleDropDown()
    }
    
    
    func titleDropDown() {
        messageTitleTextField.optionArray = self.titles
        messageTitleTextField.didSelect { (selectedText, index, id) in
            self.messageTitleTextField.text = selectedText
        }
    }
    
    
    
    func setUPLocalize(){
        titleLabel.text = "callCenter".localized
        sendBtn.setTitle("send".localized, for: .normal)
        messageTitleLabel.text = "message".localized
        messageLabel.text = "message2".localized
        messageTextField.textAlignment = .center
        messageTitleTextField.textAlignment = .center
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
