//
//  RegisterViewController.swift
//  PartyBooking
//
//  Created by MAC on 7/7/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    
    @IBOutlet weak var googleView : UIView!
    @IBOutlet weak var faceBookView : UIView!
    @IBOutlet weak var artistView : UIView!
    @IBOutlet weak var userView : UIView!
    @IBOutlet weak var blackView : UIView!
    @IBOutlet weak var regiserView : UIView!
    @IBOutlet weak var regiserSocialView : UIView!
    @IBOutlet weak var regiserUserBtn: UIButton!
    @IBOutlet weak var regiserArtistBtn : UIButton!
    @IBOutlet weak var haveAccountBtn: UIButton!
    @IBOutlet weak var registerFirstTimeBtn : UIButton!
    @IBOutlet weak var loginBtn: UIButton!

    @IBOutlet weak var loginView : UIView!


    override func viewDidLoad() {
        super.viewDidLoad()
        style ()
           let hideView = UITapGestureRecognizer(target: self, action:#selector(RegisterViewController.blackViewTapped(sender:)))
            blackView.addGestureRecognizer(hideView)
            blackView.isUserInteractionEnabled = true
                   
            

        }

        @objc func blackViewTapped(sender: UITapGestureRecognizer) {
            blackView.isHidden = true
            regiserView.isHidden = true
            regiserSocialView.isHidden = true
            loginView.isHidden = true

            
        }

    
    func style (){
           googleView.layer.cornerRadius = 7
           faceBookView.layer.cornerRadius = 7
           artistView.layer.cornerRadius = 7
           userView.layer.cornerRadius = 7
           regiserView.layer.cornerRadius = 10
           regiserSocialView.layer.cornerRadius = 10
            loginView.layer.cornerRadius = 10
           regiserUserBtn.layer.cornerRadius = 7
           regiserArtistBtn.layer.cornerRadius = 7
           haveAccountBtn.layer.cornerRadius = 7
           loginBtn.layer.cornerRadius = 7
           registerFirstTimeBtn.layer.cornerRadius = 7
          haveAccountBtn.layer.borderColor = UIColor.rgb(112, green: 112, blue: 112).cgColor
          haveAccountBtn.layer.borderWidth = 1
         }
    
    
    @IBAction func skipButton(sender: UIButton) {
        let destinationVC = TabBarController.instantiate(fromAppStoryboard: .Main)
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    
    @IBAction func googleButton(sender: UIButton) {
        blackView.isHidden = false
        regiserSocialView.isHidden = false
       }
    
    @IBAction func faceButton(sender: UIButton) {
        blackView.isHidden = false
        regiserSocialView.isHidden = false


       }
    
    
    @IBAction func userButton(sender: UIButton) {
        blackView.isHidden = false
        regiserView.isHidden = false
    }
    
    
    @IBAction func artistButton(sender: UIButton) {
        blackView.isHidden = false
        regiserView.isHidden = false
        
       }
    
    @IBAction func haveAccountButton(sender: UIButton) {
        blackView.isHidden = false
        loginView.isHidden = false
        regiserView.isHidden = true

       }

    
    @IBAction func logInButton(sender: UIButton) {
        let destinationVC = TabBarController.instantiate(fromAppStoryboard: .Main)
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    
}

