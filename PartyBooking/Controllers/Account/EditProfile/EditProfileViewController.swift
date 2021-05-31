//
//  EditProfileViewController.swift
//  PartyBooking
//
//  Created by MAC on 7/4/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit
import FlagPhoneNumber

class EditProfileViewController: UIViewController {
    
    @IBOutlet weak var saveBtn : UIButton!
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var fNameLabel : UILabel!
    @IBOutlet weak var lNameLabel : UILabel!
    @IBOutlet weak var emailLabel : UILabel!
    @IBOutlet weak var phoneLabel : UILabel!
    @IBOutlet weak var countryLabel : UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var lNameTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var fNameTextField: UITextField!
    @IBOutlet weak var phoneTextField: FPNTextField!

    
    
    @IBOutlet weak var backButton: UIButton! {
        didSet {
            backButton.setImage(backButton.currentImage?.flipIfNeeded(), for: .normal)
        }
    }
    
    
    let listController: FPNCountryListViewController = FPNCountryListViewController(style: .grouped)
    var dialCode = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUPLocalize()
        setupCountryPHone()

    }
    func setUPLocalize(){
        saveBtn.layer.cornerRadius = 7
        titleLabel.text = "edit".localized
        saveBtn.setTitle("save".localized, for: .normal)
        fNameLabel.text = "first".localized
        lNameLabel.text = "last".localized
        emailLabel.text = "email".localized
        phoneLabel.text = "phone".localized
        countryLabel.text = "country".localized
        
        if MOLHLanguage.currentAppleLanguage() == "en" {
            emailTextField.textAlignment = .left
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
            countryLabel.font = font
            countryTextField.font  = font
            saveBtn.titleLabel!.font =  UIFont(name: "Georgia-Bold", size: 17)
        } else {
            emailTextField.textAlignment = .right
            emailTextField.textAlignment = .right
            lNameTextField.textAlignment = .right
            countryTextField.textAlignment = .right
            fNameTextField.textAlignment = .right
            phoneTextField.textAlignment = .right
        }
    }
    
    func setupCountryPHone(){
             self.phoneTextField.delegate = self
             self.phoneTextField.displayMode = .list // .picker by default
             self.phoneTextField.setCountries(excluding: [.IL])
             self.phoneTextField.setFlag(key: .SA)
             listController.setup(repository: self.phoneTextField.countryRepository)
             listController.didSelect = { [weak self] country in
             self?.phoneTextField.setFlag(countryCode: country.code)
             }
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

extension EditProfileViewController : FPNTextFieldDelegate {
    func fpnDisplayCountryList() {
        let navigationViewController = UINavigationController(rootViewController: listController)
        listController.title = "Countries"
        self.present(navigationViewController, animated: true, completion: nil)
    }
    
    func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
        print(name, dialCode, code)
        self.dialCode = dialCode
    }
    
    func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
   
    }
}
