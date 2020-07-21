//
//  TakePicViewController.swift
//  PartyBooking
//
//  Created by MAC on 7/8/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit

class TakePicViewController: UIViewController {
    
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var addImagLabel : UILabel!
    @IBOutlet weak var galleryLabel : UILabel!
    
    @IBOutlet weak var nextBtn : UIButton!
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
        addImagLabel.text = "add".localized
        galleryLabel.text = "pick".localized
         if MOLHLanguage.currentAppleLanguage() == "en" {
                  let font = UIFont(name: "Georgia-Bold", size: 14)
                  titleLabel.font = font
                  addImagLabel.font = font
                  galleryLabel.font = font
                 nextBtn.titleLabel!.font =  UIFont(name: "Georgia-Bold", size: 17)
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
        let destinationVC = OfferPriceViewController.instantiateFromNib()
        self.navigationController?.pushViewController(destinationVC!, animated: true)
        
    }
    
    
}
