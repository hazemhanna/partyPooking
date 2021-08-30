//
//  SettingVc.swift
//  PartyBooking
//
//  Created by MAC on 25/05/2021.
//  Copyright © 2021 MAC. All rights reserved.
//

import UIKit
import CollapseTableView

class SettingVc: UIViewController {
  
    @IBOutlet weak var englishBtn: UIButton!
    @IBOutlet weak var ArabicBtn: UIButton!
    @IBOutlet weak var EnglishLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var languageLbl: UILabel!

    @IBOutlet weak var arabicLbl: UILabel!
    @IBOutlet weak var contentStack: UIStackView!
    
    var hide = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if "lang".localized  == "en" {
            ArabicBtn.isHidden = false
            englishBtn.isHidden = true
        }else{
            ArabicBtn.isHidden = true
            englishBtn.isHidden = false
        }
        
        arabicLbl.text = "arabic".localized
        titleLbl.text = "setting".localized
        EnglishLbl.text = "english".localized
        
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
    
    
    @IBAction func hideButton(sender: UIButton) {
        if hide{
            contentStack.isHidden = true
            self.hide = false
        }else{
            contentStack.isHidden = false
            self.hide = true
        }
    }
    
    @IBAction func arabicButton(sender: UIButton) {
        if "lang".localized  == "en" {
            ArabicBtn.isHidden = false
            englishBtn.isHidden = true
        }
    }
    
    @IBAction func EnglishButton(sender: UIButton) {
        if "lang".localized  == "en" {
            ArabicBtn.isHidden = true
            englishBtn.isHidden = false
         }
    }
    
    
}

    

