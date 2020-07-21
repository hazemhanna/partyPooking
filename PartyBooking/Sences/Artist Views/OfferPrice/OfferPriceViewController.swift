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
    @IBOutlet weak var clientPriceLabel : UILabel!
    @IBOutlet weak var offerLabel : UILabel!
    @IBOutlet weak var commetionLabel : UILabel!
    @IBOutlet weak var callCenterLabel : UILabel!
    @IBOutlet weak var saveTimeLabel : UILabel!
    @IBOutlet weak var shoppingLabel : UILabel!
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var priceValueLabel : UILabel!
    @IBOutlet weak var currancyLabel : UILabel!

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
        clientPriceLabel.text = "clientPrice".localized
        commetionLabel.text = "\("commetion".localized)+ 5%"
        callCenterLabel.text = "callCenter".localized
        saveTimeLabel.text = "saveTime".localized
        shoppingLabel.text = "shoping".localized
        if MOLHLanguage.currentAppleLanguage() == "en" {
            let font = UIFont(name: "Georgia-Bold", size: 14)
            let font2 = UIFont(name: "Georgia-Bold", size: 11)
            titleLabel.font = font
            nextBtn.titleLabel!.font =  UIFont(name: "Georgia-Bold", size: 17)
            offerLabel.font = font
            clientPriceLabel.font = font
            callCenterLabel.font = font2
            saveTimeLabel.font = font2
            shoppingLabel.font = font2
            commetionLabel.font = font2
            priceValueLabel.font = font2
            currancyLabel.font = font2
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
        let destinationVC = InformationViewController.instantiateFromNib()
        self.navigationController?.pushViewController(destinationVC!, animated: true)
        
    }
    
    
}
