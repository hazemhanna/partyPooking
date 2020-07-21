//
//  MoreViewController.swift
//  PartyBooking
//
//  Created by MAC on 7/2/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit

class MoreViewController: UIViewController {

    @IBOutlet weak var offerView : UIView!
    @IBOutlet weak var favouriteView : UIView!
    @IBOutlet weak var callcenterView : UIView!
    @IBOutlet weak var settingView : UIView!
    @IBOutlet weak var logOutView : UIView!
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var offerLabel : UILabel!
    @IBOutlet weak var favouriteLabel  : UILabel!
    @IBOutlet weak var callcenterLabel  : UILabel!
    @IBOutlet weak var settingLabel  : UILabel!
    @IBOutlet weak var logOutLabel  : UILabel!
    @IBOutlet weak var version  : UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let favourite = UITapGestureRecognizer(target: self, action:#selector(MoreViewController.favouriteViewTapped(sender:)))
               favouriteView.addGestureRecognizer(favourite)
               favouriteView.isUserInteractionEnabled = true
        
        let callCenter = UITapGestureRecognizer(target: self, action:#selector(MoreViewController.callCenterViewTapped(sender:)))
                     callcenterView.addGestureRecognizer(callCenter)
                     callcenterView.isUserInteractionEnabled = true
        
        let offers = UITapGestureRecognizer(target: self, action:#selector(MoreViewController.offersViewTapped(sender:)))
                            offerView.addGestureRecognizer(offers)
                            offerView.isUserInteractionEnabled = true
        
        
        let setting = UITapGestureRecognizer(target: self, action:#selector(MoreViewController.settingViewTapped(sender:)))
                                  settingView.addGestureRecognizer(setting)
                                  settingView.isUserInteractionEnabled = true
               
        setUPLocalize()

    }
    
    

      @objc func favouriteViewTapped(sender: UITapGestureRecognizer) {
        let destinationVC = FavouriteViewController.instantiateFromNib()
        self.navigationController?.pushViewController(destinationVC!, animated: true)
        
    }
       
    @objc func callCenterViewTapped(sender: UITapGestureRecognizer) {
           let destinationVC = CallCenterViewController.instantiateFromNib()
           self.navigationController?.pushViewController(destinationVC!, animated: true)
           
       }
    
    @objc func offersViewTapped(sender: UITapGestureRecognizer) {
              let destinationVC = OffersViewController.instantiateFromNib()
              self.navigationController?.pushViewController(destinationVC!, animated: true)
              
          }
    
    
    @objc func settingViewTapped(sender: UITapGestureRecognizer) {
             let destinationVC = SettingViewController()
             self.navigationController?.pushViewController(destinationVC, animated: true)
                
    }
    
  
    func setUPLocalize(){
         version.text = "\("version".localized) - 2.2.1"
          titleLabel.text = "more".localized
         offerLabel.text = "offer".localized
         favouriteLabel.text = "favourite".localized
         callcenterLabel.text = "callCenter".localized
         settingLabel.text = "setting".localized
         logOutLabel.text = "logOut".localized
        if MOLHLanguage.currentAppleLanguage() == "en" {
            let font = UIFont(name: "Georgia-Bold", size: 14)
            settingLabel.font =  font
            settingLabel.font = font
            logOutLabel.font = font
            callcenterLabel.font = font
            favouriteLabel.font = font
            offerLabel.font = font
            titleLabel.font = font
            version.font = font
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
