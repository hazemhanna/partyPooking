//
//  ArtistRegisterViewController.swift
//  PartyBooking
//
//  Created by MAC on 7/7/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit

class ArtistRegisterViewController: UIViewController {
    
    @IBOutlet weak var numberView: UIView!
    @IBOutlet weak var nextBtn : UIButton!
    
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var fNameLabel : UILabel!
    @IBOutlet weak var lNameLabel : UILabel!
    @IBOutlet weak var emailLabel : UILabel!
    @IBOutlet weak var phoneLabel : UILabel!
    @IBOutlet weak var passwordLabel : UILabel!
    @IBOutlet weak var countryLabel : UILabel!
    @IBOutlet weak var areaLabel : UILabel!
    @IBOutlet weak var serviceLabel : UILabel!
    @IBOutlet weak var banckLabel : UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var lNameTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var fNameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var areaTextField: UITextField!
    @IBOutlet weak var serviceTextField: UITextField!
    @IBOutlet weak var banckTextField: UITextField!
    
    @IBOutlet weak var backButton: UIButton! {
        didSet {
            backButton.setImage(backButton.currentImage?.flipIfNeeded(), for: .normal)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextBtn.layer.cornerRadius = 7
        numberView.layer.borderColor = UIColor.rgb(112, green: 112, blue: 112).cgColor
        numberView.layer.borderWidth = 1
        setUPLocalize()
    }
    
    func setUPLocalize(){
        titleLabel.text = "information".localized
        nextBtn.setTitle("next".localized, for: .normal)
        fNameLabel.text = "first".localized
        //fNameTextField.placeholder = fNameLabel.text
        lNameLabel.text = "last".localized
        //lNameTextField.placeholder = lNameLabel.text
        emailLabel.text = "email".localized
        //emailTextField.placeholder = emailLabel.text
        phoneLabel.text = "phone".localized
       // phoneTextField.placeholder =  phoneLabel.text
        passwordLabel.text = "password".localized
       // passTextField.placeholder = passwordLabel.text
        countryLabel.text = "country".localized
        //countryTextField.placeholder  = countryLabel.text
        serviceLabel.text = "service".localized
       // serviceTextField.placeholder =  serviceLabel.text
        areaLabel.text = "area".localized
        //areaTextField.placeholder =  areaLabel.text
        banckLabel.text = "bank".localized
        //banckTextField.placeholder = banckLabel.text
        
        if MOLHLanguage.currentAppleLanguage() == "en" {
            
            emailTextField.textAlignment = .left
            passTextField.textAlignment = .left
            lNameTextField.textAlignment = .left
            countryTextField.textAlignment = .left
            fNameTextField.textAlignment = .left
            phoneTextField.textAlignment = .left
            areaTextField.textAlignment = .left
            serviceTextField.textAlignment = .left
            banckTextField.textAlignment = .left
            
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
            serviceLabel.font = font
            serviceTextField.font = font
            areaLabel.font = font
            areaTextField.font =  font
            banckLabel.font = font
            banckTextField.font = font
            nextBtn.titleLabel!.font =  UIFont(name: "Georgia-Bold", size: 17)
        } else {
            emailTextField.textAlignment = .right
            emailTextField.textAlignment = .right
            passTextField.textAlignment = .right
            lNameTextField.textAlignment = .right
            countryTextField.textAlignment = .right
            fNameTextField.textAlignment = .right
            phoneTextField.textAlignment = .right
            areaTextField.textAlignment = .right
            serviceTextField.textAlignment = .right
            banckTextField.textAlignment = .right
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
    
    
    @IBAction func nextButton(sender: UIButton) {
        let destinationVC = TakePicViewController.instantiateFromNib()
        self.navigationController?.pushViewController(destinationVC!, animated: true)
        
    }
    
    
}

