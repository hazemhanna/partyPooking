//
//  OfferPriceViewController.swift
//  PartyBooking
//
//  Created by MAC on 7/8/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit

class OfferPriceViewController: UIViewController {
    
    @IBOutlet weak var nextBtn : UIButton!
    @IBOutlet weak var offerLabel : UILabel!
    @IBOutlet weak var callCenterLabel : UILabel!
    @IBOutlet weak var saveTimeLabel : UILabel!
    @IBOutlet weak var shoppingLabel : UILabel!
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var canBtn : UIButton!
    @IBOutlet weak var canNotBtn : UIButton!
    @IBOutlet weak var cancelTimeTF : UITextField!
     var emailTextField = String()
     var passTextField =  String()
     var lNameTextField =  String()
     var countryTextField =  Int()
     var fNameTextField =  String()
     var phoneTextField =  String()
      var area = Int()
     var serviceTextField = Int()
     var genderTextField =  String()
     var banckTextField =  String()
     var banckAcountTextField =  String()
     var retrieveMoney = 1
     var image = UIImage()
     var showPrice = false
    
    @IBOutlet weak var backButton: UIButton! {
        didSet {
            backButton.setImage(backButton.currentImage?.flipIfNeeded(), for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextBtn.layer.cornerRadius = 7
        setUPLocalize()
    }
    
    func setUPLocalize(){
        titleLabel.text = "information".localized
        nextBtn.setTitle("next".localized, for: .normal)
        offerLabel.text = "howMuch".localized
        callCenterLabel.text = "callCenter".localized
        saveTimeLabel.text = "saveTime".localized
        shoppingLabel.text = "shoping".localized
        if "lang".localized  == "en" {
            let font = UIFont(name: "Georgia-Bold", size: 14)
            let font2 = UIFont(name: "Georgia-Bold", size: 11)
            titleLabel.font = font
            nextBtn.titleLabel!.font =  UIFont(name: "Georgia-Bold", size: 17)
            offerLabel.font = font
            callCenterLabel.font = font2
            saveTimeLabel.font = font2
            shoppingLabel.font = font2
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
    
    @IBAction func canButton(sender: UIButton) {
        canBtn.backgroundColor = #colorLiteral(red: 0.168627451, green: 0.7058823529, blue: 0.6941176471, alpha: 1)
        canBtn.tintColor = #colorLiteral(red: 0.168627451, green: 0.7058823529, blue: 0.6941176471, alpha: 1)
        canBtn.setTitleColor(UIColor.white, for: .normal)
        canBtn.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        canBtn.layer.borderWidth = 0
        canNotBtn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        canNotBtn.layer.borderColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1).cgColor
        canNotBtn.layer.borderWidth = 1
        canNotBtn.setTitleColor(UIColor.black, for: .normal)
        retrieveMoney = 1
        
    }
    
    @IBAction func canNotButton(sender: UIButton) {
        canNotBtn.backgroundColor = #colorLiteral(red: 0.168627451, green: 0.7058823529, blue: 0.6941176471, alpha: 1)
        canNotBtn.tintColor = #colorLiteral(red: 0.168627451, green: 0.7058823529, blue: 0.6941176471, alpha: 1)
        canNotBtn.setTitleColor(UIColor.white, for: .normal)
        canBtn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        canBtn.layer.borderColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1).cgColor
        canBtn.layer.borderWidth = 1
        canBtn.setTitleColor(UIColor.black, for: .normal)
        retrieveMoney = 0

    }
    
    
    @IBAction func nextButton(sender: UIButton) {
        if showPrice {
        let destinationVC = InformationViewController.instantiateFromNib()
        destinationVC?.emailTextField = emailTextField
        destinationVC?.passTextField =  passTextField
        destinationVC?.lNameTextField =  lNameTextField
        destinationVC?.countryTextField =  countryTextField
        destinationVC?.fNameTextField = fNameTextField
        destinationVC?.phoneTextField =  phoneTextField
        destinationVC?.area = area
        destinationVC?.serviceTextField =  serviceTextField
        destinationVC?.genderTextField =  genderTextField
        destinationVC?.banckTextField =  banckTextField
        destinationVC?.banckAcountTextField =  banckAcountTextField
        destinationVC?.retrieveMoney =  retrieveMoney
        destinationVC?.image =  image
        destinationVC?.cancelTimeTF =  Int(cancelTimeTF.text ?? "0") ?? 0
        self.navigationController?.pushViewController(destinationVC!, animated: true)
        }else{
            if "lang".localized == "ar" {
            displayMessage(title: "", message: " اضف سعر الحفلات" , status: .error, forController: self)
            }else{
                displayMessage(title: "", message: " add party prices " , status: .error, forController: self)

            }
        }
    }
    
    @IBAction func offerPriceButton(sender: UIButton) {
        showPrice = true
        let destinationVC = PartyPriceVC.instantiateFromNib()
        self.navigationController?.pushViewController(destinationVC!, animated: true)
    }
    
}
