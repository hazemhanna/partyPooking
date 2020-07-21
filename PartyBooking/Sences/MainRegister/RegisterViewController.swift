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
    @IBOutlet weak var loginView : UIView!
    @IBOutlet weak var regiserUserBtn: UIButton!
    @IBOutlet weak var regiserArtistBtn : UIButton!
    @IBOutlet weak var regiserUser: UIButton!
    @IBOutlet weak var regiserArtist : UIButton!
    @IBOutlet weak var haveAccountBtn: UIButton!
    @IBOutlet weak var registerFirstTimeBtn : UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var googleBtn: UIButton!
    @IBOutlet weak var facebookBtn: UIButton!
    @IBOutlet weak var skipBtn: UIButton!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var ORLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var PassTF: UITextField!
    
    var isUser : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        style ()
        let hideView = UITapGestureRecognizer(target: self, action:#selector(RegisterViewController.blackViewTapped(sender:)))
        blackView.addGestureRecognizer(hideView)
        blackView.isUserInteractionEnabled = true
        setUPLocalize()
        
        for family in UIFont.familyNames {
            let sName: String = family as String
            print("family: \(sName)")
            for name in UIFont.fontNames(forFamilyName: sName) {
                print("name: \(name as String)")
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func setUPLocalize(){
        regiserUserBtn.setTitle("userRegister".localized, for: .normal)
        regiserArtistBtn.setTitle("artistRegister".localized, for: .normal)
        regiserUser.setTitle("userRegister".localized, for: .normal)
        regiserArtist.setTitle("artistRegister".localized, for: .normal)
        haveAccountBtn.setTitle("haveAccount".localized, for: .normal)
        registerFirstTimeBtn.setTitle("firstTime".localized, for: .normal)
        loginBtn.setTitle("login".localized, for: .normal)
        googleBtn.setTitle("google".localized, for: .normal)
        facebookBtn.setTitle("facebook".localized, for: .normal)
        skipBtn.setTitle("skip".localized, for: .normal)
        welcomeLabel.text = "welcome".localized
        ORLabel.text = "or".localized
        loginLabel.text = "logintitle".localized
        emailTF.placeholder = "emailOrPhone".localized
        PassTF.placeholder = "password".localized
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
        if MOLHLanguage.currentAppleLanguage() == "en" {
            let font = UIFont(name: "Georgia-Bold", size: 16)
            regiserUserBtn.titleLabel!.font = font
            regiserArtistBtn.titleLabel!.font =  font
            regiserUser.titleLabel!.font = font
            regiserArtist.titleLabel!.font = font
            haveAccountBtn.titleLabel!.font = font
            registerFirstTimeBtn.titleLabel!.font = font
            loginBtn.titleLabel!.font = font
            googleBtn.titleLabel!.font = font
            facebookBtn.titleLabel!.font = font
            skipBtn.titleLabel!.font = font
            welcomeLabel.font = font
            ORLabel.font =  font
            loginLabel.font = font
            emailTF.font = font
            PassTF.font = font
        }
    }
    
    @objc func blackViewTapped(sender: UITapGestureRecognizer) {
        blackView.isHidden = true
        regiserView.isHidden = true
        regiserSocialView.isHidden = true
        loginView.isHidden = true
    }
    
    @IBAction func skipButton(sender: UIButton) {
        let destinationVC = TabBarController.instantiate(fromAppStoryboard: .Main)
        if let appDelegate = UIApplication.shared.delegate {
            appDelegate.window??.rootViewController = destinationVC
        }
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
        isUser = true
    }
    
    @IBAction func artistButton(sender: UIButton) {
        blackView.isHidden = false
        regiserView.isHidden = false
        isUser = false
    }
    
    @IBAction func haveAccountButton(sender: UIButton) {
        blackView.isHidden = false
        loginView.isHidden = false
        regiserView.isHidden = true
    }
    
    @IBAction func logInButton(sender: UIButton) {
        if isUser{
            let destinationVC = TabBarController.instantiate(fromAppStoryboard: .Main)
            destinationVC.type = .user
            if let appDelegate = UIApplication.shared.delegate {
                appDelegate.window??.rootViewController = destinationVC
            }
        }else{
            let destinationVC = TabBarController.instantiate(fromAppStoryboard: .Main)
            destinationVC.type = .artist
            if let appDelegate = UIApplication.shared.delegate {
                appDelegate.window??.rootViewController = destinationVC
            }
        }
    }
    
    @IBAction func registerUserButton(sender: UIButton) {
        let destinationVC = UserRegisterViewController.instantiateFromNib()
        self.navigationController!.pushViewController(destinationVC!, animated: true)
        
    }
    
    @IBAction func registerArtistButton(sender: UIButton) {
        let destinationVC = ArtistRegisterViewController.instantiateFromNib()
        self.navigationController?.pushViewController(destinationVC!, animated: true)
    }
    
    @IBAction func registerFirstTimeButton(sender: UIButton) {
        if isUser{
            let destinationVC = UserRegisterViewController.instantiateFromNib()
            self.navigationController!.pushViewController(destinationVC!, animated: true)
        }else{
            let destinationVC = ArtistRegisterViewController.instantiateFromNib()
            self.navigationController?.pushViewController(destinationVC!, animated: true)
        }
    }
}

