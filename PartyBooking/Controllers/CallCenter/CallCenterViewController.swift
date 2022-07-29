//
//  CallCenterViewController.swift
//  PartyBooking
//
//  Created by MAC on 7/5/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import IQKeyboardManagerSwift

class CallCenterViewController: UIViewController {
    
    @IBOutlet weak var sendBtn : UIButton!
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var messageTitleLabel : UILabel!
    @IBOutlet weak var messageTitleTextField: TextFieldDropDown!
    @IBOutlet weak var messageLabel : UILabel!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailLabel : UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!

    @IBOutlet weak var phoneLabel : UILabel!

    let def = UserDefaults.standard

    fileprivate var returnHandler : IQKeyboardReturnKeyHandler!
    @IBOutlet weak var backButton: UIButton! {
          didSet {
              backButton.setImage(backButton.currentImage?.flipIfNeeded(), for: .normal)
          }
      }
    
    private let AuthViewModel = AuthenticationViewModel()
    var disposeBag = DisposeBag()
    var type = "problem"
    var titles = ["compline".localized,"suggestion".localized]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sendBtn.layer.cornerRadius = 8
        setUPLocalize()
        titleDropDown()
        updateReturnHandler()        
        nameTextField.text = def.object(forKey: "name") as? String ?? ""
        emailTextField.text = def.object(forKey: "email") as? String ?? ""
        phoneTextField.text = def.object(forKey: "phone") as? String ?? ""

    }
    
    func titleDropDown() {
        messageTitleTextField.optionArray = self.titles
        messageTitleTextField.didSelect { (selectedText, index, id) in
            self.messageTitleTextField.text = selectedText
            if index == 0 {
                self.type =  "problem"
            }else{
                self.type =  "opinion"
            }
        }
    }
    
    func updateReturnHandler(){
        if returnHandler == nil {
            returnHandler = IQKeyboardReturnKeyHandler(controller: self)
        }else{
            returnHandler.removeResponderFromView(self.view)
            returnHandler.addResponderFromView(self.view)
        }
        returnHandler.lastTextFieldReturnKeyType = .done
    }
    
    func setUPLocalize(){
        titleLabel.text = "callCenter".localized
        sendBtn.setTitle("send".localized, for: .normal)
        messageTitleLabel.text = "message".localized
        messageLabel.text = "message2".localized
        nameLabel.text = "name".localized
        emailLabel.text = "email".localized
        phoneLabel.text = "phone".localized
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
    @IBAction func sendBtn(sender: UIButton) {
        AuthViewModel.showIndicator()
        self.ContactUS(name: nameTextField.text ?? ""  , email: emailTextField.text ?? "" , type: self.type, message:  self.messageLabel.text ?? "")
        self.messageTextField.text = ""
    }
    
    func ContactUS(name:String,email : String,type: String, message:String ) {
        AuthViewModel.ContactUS(name:name,email : email,type: type, message:message).subscribe(onNext: { (data) in
            self.AuthViewModel.dismissIndicator()
            if data.status ?? false {
                if "lang".localized == "ar" {
                    displayMessage(title: "", message: "تم بنجاح ارسال الرسالة", status: .success, forController: self)
                }else{
                    displayMessage(title: "", message: "done succesufuly send message", status: .success, forController: self)
                 }
            }
        }, onError: { (error) in
            self.AuthViewModel.dismissIndicator()
            displayMessage(title: "", message: "Something went wrong in getting terms", status: .error, forController: self)
        }).disposed(by: disposeBag)
    }
    
    
}
