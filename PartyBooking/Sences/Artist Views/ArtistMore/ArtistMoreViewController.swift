//
//  ArtistMoreViewController.swift
//  PartyBooking
//
//  Created by MAC on 7/9/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit

class ArtistMoreViewController: UIViewController {
    
    @IBOutlet weak var billView : UIView!
    @IBOutlet weak var commentView : UIView!
    @IBOutlet weak var exprienceView : UIView!
    @IBOutlet weak var settingView : UIView!
    @IBOutlet weak var logOutView : UIView!
    @IBOutlet weak var callcenterView : UIView!
    @IBOutlet weak var silentModeView : UIView!
    @IBOutlet weak var billLabel : UILabel!
    @IBOutlet weak var  commentLabel  : UILabel!
    @IBOutlet weak var exprienceLabel  : UILabel!
    @IBOutlet weak var settingLabel  : UILabel!
    @IBOutlet weak var logOutLabel  : UILabel!
    @IBOutlet weak var callCenterLabel  : UILabel!
    @IBOutlet weak var silentModeLabel  : UILabel!
    @IBOutlet weak var activeLabel  : UILabel!
    @IBOutlet weak var titleLabel  : UILabel!
    @IBOutlet weak var version  : UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bille = UITapGestureRecognizer(target: self, action:#selector(ArtistMoreViewController.billTapped(sender:)))
        billView.addGestureRecognizer(bille)
        billView.isUserInteractionEnabled = true
        
        let comment = UITapGestureRecognizer(target: self, action:#selector(ArtistMoreViewController.commentViewTapped(sender:)))
        commentView.addGestureRecognizer(comment)
        commentView.isUserInteractionEnabled = true
        
        let exprience = UITapGestureRecognizer(target: self, action:#selector(ArtistMoreViewController.exprienceViewTapped(sender:)))
        exprienceView.addGestureRecognizer(exprience)
        exprienceView.isUserInteractionEnabled = true
        
        let callCenter = UITapGestureRecognizer(target: self, action:#selector(MoreViewController.callCenterViewTapped(sender:)))
        callcenterView.addGestureRecognizer(callCenter)
        callcenterView.isUserInteractionEnabled = true
        
        let silent = UITapGestureRecognizer(target: self, action:#selector(ArtistMoreViewController.silentViewTapped(sender:)))
        silentModeView.addGestureRecognizer(silent)
        silentModeView.isUserInteractionEnabled = true
        
        let setting = UITapGestureRecognizer(target: self, action:#selector(ArtistMoreViewController.settingViewTapped(sender:)))
        settingView.addGestureRecognizer(setting)
        settingView.isUserInteractionEnabled = true
        
        setUPLocalize()
        
    }
    
    @objc func billTapped(sender: UITapGestureRecognizer) {
        let destinationVC = ReservationViewController.instantiateFromNib()
        self.navigationController?.pushViewController(destinationVC!, animated: true)
        
    }
    
    @objc func commentViewTapped(sender: UITapGestureRecognizer) {
        let destinationVC = CommentsViewController.instantiateFromNib()
        self.navigationController?.pushViewController(destinationVC!, animated: true)
    }
    
    @objc func exprienceViewTapped(sender: UITapGestureRecognizer) {
        let destinationVC = RateViewController.instantiateFromNib()
        self.navigationController?.pushViewController(destinationVC!, animated: true)
    }
    
    
    @objc func callCenterViewTapped(sender: UITapGestureRecognizer) {
        let destinationVC = CallCenterViewController.instantiateFromNib()
        self.navigationController?.pushViewController(destinationVC!, animated: true)
    }
    
    @objc func silentViewTapped(sender: UITapGestureRecognizer) {
        let destinationVC = SilentViewController.instantiateFromNib()
        self.navigationController?.pushViewController(destinationVC!, animated: true)
    }
    
    @objc func settingViewTapped(sender: UITapGestureRecognizer) {
        let destinationVC = SettingViewController()
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    
    func setUPLocalize(){
        version.text = "\("version".localized) - 2.2.1"
        titleLabel.text = "more".localized
        billLabel.text = "Bills".localized
        commentLabel.text = "UserComments".localized
        exprienceLabel.text = "UserExpeience".localized
        callCenterLabel.text = "callCenter".localized
        silentModeLabel.text = "SelintMode".localized
        activeLabel.text = "unActive".localized
        settingLabel.text = "setting".localized
        logOutLabel.text = "logOut".localized
        if MOLHLanguage.currentAppleLanguage() == "en" {
            let font = UIFont(name: "Georgia-Bold", size: 14)
            commentLabel.font = font
            exprienceLabel.font =  font
            settingLabel.font = font
            logOutLabel.font = font
            callCenterLabel.font = font
            silentModeLabel.font = font
            activeLabel.font = font
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
