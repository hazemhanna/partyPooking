//
//  LanguageScreenVC.swift
//  PartyBooking
//
//  Created by MAC on 30/08/2021.
//  Copyright © 2021 MAC. All rights reserved.
//

import UIKit
import MOLH

class LanguageScreenVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUPLocalize()
    }
    
    func setUPLocalize(){

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func EnglishLanguageAction(_ sender: CustomButtons) {
        Helper.saveLang(Lang: "en")
        Helper.saveType(token: "user")

        if MOLHLanguage.currentAppleLanguage() == "ar" {
            MOLH.setLanguageTo(MOLHLanguage.currentAppleLanguage() == "en" ? "ar" : "en")
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        } else{
            if ("lang".localized == "en") {
                displayMessage(title: "", message: "Your App is Already in English Language", status: .info, forController: self)
            } else {
                displayMessage(title: "", message: "البرنامج بالفعل على اللغة الإنجليزية", status: .info, forController: self)
            }
        }
        MOLH.reset()
    }
    @IBAction func ArabicLanguageAction(_ sender: CustomButtons) {
        Helper.saveLang(Lang: "ar")
        Helper.saveType(token: "user")
        if MOLHLanguage.currentAppleLanguage() == "en" {
            MOLH.setLanguageTo(MOLHLanguage.currentAppleLanguage() == "en" ? "ar" : "en")
            MOLH.setLanguageTo("ar")
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
            MOLH.reset()
        } else {
            if ("lang".localized == "en") {
                displayMessage(title: "", message: "Your App is Already in Arabic Language", status: .info, forController: self )
            } else {
                displayMessage(title: "", message: "البرنامج بالفعل على اللغة العربية", status: .info, forController: self )
            }
        }
    }
    
}
