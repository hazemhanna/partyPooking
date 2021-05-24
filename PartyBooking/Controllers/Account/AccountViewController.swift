//
//  AccountViewController.swift
//  PartyBooking
//
//  Created by MAC on 7/2/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {
    
        @IBOutlet weak var editBtn : UIButton!
        @IBOutlet weak var profilehImage : UIImageView!
        @IBOutlet weak var titleLabel : UILabel!

    

    override func viewDidLoad() {
        super.viewDidLoad()
         style()
         editBtn.setTitle("chnge".localized, for: .normal)
         titleLabel.text = "myAccount".localized
        
        if MOLHLanguage.currentAppleLanguage() == "en" {
            let font = UIFont(name: "Georgia-Bold", size: 14)
            editBtn.titleLabel!.font = UIFont(name: "Georgia-Bold", size: 17)
            titleLabel.font = font
           
        }

        
    }
    func style(){
        profilehImage.layer.cornerRadius = profilehImage.frame.width / 2
        editBtn.layer.cornerRadius = 7
        editBtn.layer.borderColor = UIColor.tabBarColor.cgColor
        editBtn.layer.borderWidth = 3
        
    }
    
    
    
   
    override func viewWillAppear(_ animated: Bool) {
         self.navigationController?.navigationBar.isHidden = true
       }
       override func viewWillDisappear(_ animated: Bool) {
           self.navigationController?.navigationBar.isHidden = false
       }
    
    @IBAction func editProfileButton(sender: UIButton) {
          let destinationVC = EditProfileViewController.instantiateFromNib()
          self.navigationController?.pushViewController(destinationVC!, animated: true)
          
      }
    
    @IBAction func backButton(sender: UIButton) {
          self.navigationController?.popViewController(animated: true)
      }
    

    
}
