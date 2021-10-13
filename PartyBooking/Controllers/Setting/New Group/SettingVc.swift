//
//  SettingVc.swift
//  PartyBooking
//
//  Created by MAC on 25/05/2021.
//  Copyright © 2021 MAC. All rights reserved.
//

import UIKit
import CollapseTableView
import MOLH

class SettingVc: UIViewController {
  
    @IBOutlet weak var englishBtn: UIButton!
    @IBOutlet weak var ArabicBtn: UIButton!

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var contentStack: UIStackView!
    
    var hide = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLbl.text = "setting".localized
        
    }

    override func viewWillAppear(_ animated: Bool) {
        
        if "lang".localized  == "en" {
            ArabicBtn.isHidden = true
            englishBtn.isHidden = false
        }else{
            ArabicBtn.isHidden = false
            englishBtn.isHidden = true
        }
        self.navigationController?.navigationBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    
    @IBAction func backButton(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func hideButton(sender: UIButton) {
        if hide{
            contentStack.isHidden = true
            self.hide = false
        }else{
            contentStack.isHidden = false
            self.hide = true
        }
    }
    
    @IBAction func EnglishLanguageAction(_ sender: CustomButtons) {
        Helper.saveLang(Lang: "en")
        if MOLHLanguage.currentAppleLanguage() == "ar" {
            MOLH.setLanguageTo(MOLHLanguage.currentAppleLanguage() == "en" ? "ar" : "en")
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
            MOLH.reset()

        } else{
            if ("lang".localized == "en") {
                displayMessage(title: "", message: "Your App is Already in English Language", status: .info, forController: self)
            } else {
                displayMessage(title: "", message: "البرنامج بالفعل على اللغة الإنجليزية", status: .info, forController: self)
            }
        }
    }
    @IBAction func ArabicLanguageAction(_ sender: CustomButtons) {
        Helper.saveLang(Lang: "ar")
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

    

