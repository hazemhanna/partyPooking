//
//  InformationViewController.swift
//  PartyBooking
//
//  Created by MAC on 7/8/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit

class InformationViewController: UIViewController {
    
    @IBOutlet weak var nextBtn : UIButton!
    
    @IBOutlet weak var ImportantInfLabel : UILabel!
    @IBOutlet weak var fastLabel : UILabel!
    @IBOutlet weak var yesLabel : UILabel!
    @IBOutlet weak var choosePepoleLabel : UILabel!
    @IBOutlet weak var noLabel : UILabel!
    @IBOutlet weak var timeRecieveingLabel : UILabel!
    @IBOutlet weak var termsLabel : UILabel!
    @IBOutlet weak var yes2Label : UILabel!
    @IBOutlet weak var agreeLabel : UILabel!
    @IBOutlet weak var readLabel : UILabel!
    @IBOutlet weak var ReadyBtn : UIButton!
    @IBOutlet weak var notReadyLabel : UILabel!
    @IBOutlet weak var titleLabel : UILabel!
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
        ReadyBtn.setTitle("Ready".localized, for: .normal)
        ImportantInfLabel.text = "ImportantInf".localized
        fastLabel.text = "fast".localized
        yesLabel.text = "yes".localized
        choosePepoleLabel.text = "choosePepole".localized
        noLabel.text = "no".localized
        timeRecieveingLabel.text = "timeRecieveing".localized
        yes2Label.text = "yes2".localized
        agreeLabel.text = "agree".localized
        readLabel.text = "read".localized
        notReadyLabel.text = "notReady".localized
        termsLabel.text = "terms".localized
        if MOLHLanguage.currentAppleLanguage() == "en" {
            let font = UIFont(name: "Georgia-Bold", size: 14)
            let font2 = UIFont(name: "Georgia-Bold", size: 11)
            titleLabel.font = font
            nextBtn.titleLabel!.font =  UIFont(name: "Georgia-Bold", size: 14)
            ReadyBtn.titleLabel!.font =  UIFont(name: "Georgia-Bold", size: 17)
            ImportantInfLabel.font = font
            fastLabel.font = font2
            yesLabel.font = font2
            choosePepoleLabel.font = font2
            noLabel.font = font2
            timeRecieveingLabel.font = font2
            yes2Label.font = font2
            agreeLabel.font = font2
            readLabel.font = font2
            notReadyLabel.font = font2
            termsLabel.font = font2
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
        let destinationVC = TabBarController.instantiate(fromAppStoryboard: .Main)
        destinationVC.type = .artist
        if let appDelegate = UIApplication.shared.delegate {
            appDelegate.window??.rootViewController = destinationVC
        }
    }
    
    var unchecked = true
    @IBAction func tick(sender: UIButton) {
        if unchecked {
            sender.setImage(UIImage(named:"checked.png"), for: .normal)
            unchecked = false
        }
        else {
            sender.setImage( UIImage(named:"unchecked.png"), for: .normal)
            unchecked = true
        }
    }
    
    var termsUnchecked = true
    @IBAction func termsBtn(sender: UIButton) {
        if unchecked {
            sender.setImage(UIImage(named:"checked.png"), for: .normal)
            termsUnchecked = false
        }
        else {
            sender.setImage( UIImage(named:"unchecked.png"), for: .normal)
            termsUnchecked = true
        }
    }
    
}
