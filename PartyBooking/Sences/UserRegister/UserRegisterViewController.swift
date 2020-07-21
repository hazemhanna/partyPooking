//
//  UserRegisterViewController.swift
//  PartyBooking
//
//  Created by MAC on 7/8/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit

class UserRegisterViewController: UIViewController {

    
    @IBOutlet weak var visaView : UIView!
    @IBOutlet weak var masterView : UIView!
    @IBOutlet weak var payView : UIView!
    @IBOutlet weak var stcView : UIView!
    @IBOutlet weak var madaView : UIView!
    
    
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var fNameLabel : UILabel!
    @IBOutlet weak var lNameLabel : UILabel!
    @IBOutlet weak var emailLabel : UILabel!
    @IBOutlet weak var phoneLabel : UILabel!
    @IBOutlet weak var passwordLabel : UILabel!
    @IBOutlet weak var countryLabel : UILabel!
    @IBOutlet weak var paymentLabel : UILabel!
    @IBOutlet weak var amountLabel : UILabel!
    @IBOutlet weak var amountValueLabel : UILabel!
    @IBOutlet weak var taxesLabel : UILabel!
    
     @IBOutlet weak var emailTextField: UITextField!
     @IBOutlet weak var passTextField: UITextField!
     @IBOutlet weak var lNameTextField: UITextField!
     @IBOutlet weak var countryTextField: UITextField!
     @IBOutlet weak var fNameTextField: UITextField!
     @IBOutlet weak var phoneTextField: UITextField!

    
    @IBOutlet weak var doneBtn : UIButton!
    @IBOutlet weak var backButton: UIButton! {
        didSet {
            backButton.setImage(backButton.currentImage?.flipIfNeeded(), for: .normal)
        }
    }

 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doneBtn.layer.cornerRadius = 7
         style (view : visaView)
         style (view : masterView)
         style (view : payView)
         style (view : stcView)
         style (view : madaView)
        setUPLocalize()
    }

    func setUPLocalize(){
        titleLabel.text = "information".localized
        doneBtn.setTitle("done".localized, for: .normal)
        fNameLabel.text = "first".localized
        lNameLabel.text = "last".localized
        emailLabel.text = "email".localized
        phoneLabel.text = "phone".localized
        passwordLabel.text = "password".localized
        countryLabel.text = "country".localized
        paymentLabel.text = "payment".localized
        amountLabel.text = "amount".localized
        taxesLabel.text = "\("taxes".localized) + SR 450"
            if MOLHLanguage.currentAppleLanguage() == "en" {
                emailTextField.textAlignment = .left
                passTextField.textAlignment = .left
                lNameTextField.textAlignment = .left
                countryTextField.textAlignment = .left
                fNameTextField.textAlignment = .left
                phoneTextField.textAlignment = .left
                let font = UIFont(name: "Georgia-Bold", size: 14)
                           titleLabel.font = font
                           fNameLabel.font = font
                           fNameTextField.font = font
                           lNameLabel.font = font
                           lNameTextField.font = font
                           emailLabel.font = font
                           emailTextField.font = font
                           phoneLabel.font = font
                           phoneTextField.font =  font
                           passwordLabel.font = font
                           passTextField.font = font
                           countryLabel.font = font
                           countryTextField.font  = font
                           doneBtn.titleLabel!.font =  UIFont(name: "Georgia-Bold", size: 17)
                
            } else {
                emailTextField.textAlignment = .right
                emailTextField.textAlignment = .right
                passTextField.textAlignment = .right
                lNameTextField.textAlignment = .right
                countryTextField.textAlignment = .right
                fNameTextField.textAlignment = .right
                phoneTextField.textAlignment = .right
            }
        
     }
    
    func style (view : UIView){
        view.layer.cornerRadius = 5.0
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.clear.cgColor
        view.layer.masksToBounds = true
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowRadius = 2.0
        view.layer.shadowOpacity = 0.5
        view.layer.masksToBounds = false
        
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
           let destinationVC = ConfirmReservationViewController.instantiateFromNib()
           self.navigationController?.pushViewController(destinationVC!, animated: true)
       }
    
}
