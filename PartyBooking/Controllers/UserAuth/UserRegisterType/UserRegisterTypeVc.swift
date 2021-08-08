//
//  UserRegisterTypeVc.swift
//  PartyBooking
//
//  Created by MAC on 20/05/2021.
//  Copyright © 2021 MAC. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import GoogleSignIn


class UserRegisterTypeVc: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

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
    
    
    @IBAction func creatcountAction(sender: UIButton) {
        let destinationVC = UserRegisterViewController.instantiateFromNib()
      self.navigationController!.pushViewController(destinationVC!, animated: true)
      
    }
        
    
    @IBAction func fblogin(_ sender: Any) {
        
        let loginManager = LoginManager()
        loginManager.logIn(permissions: [ .publicProfile,.email ], viewController: self) { loginResult in
            print(loginResult)
            let tokent = AccessToken.current?.tokenString
            let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields":"email, name,picture"], tokenString: tokent, version: nil, httpMethod: .get )
            request.start(completionHandler: {connection ,result,error in
                if error != nil{
                    return
                }
            })
        }
    }
    
    @IBAction func googlelogin(_ sender: Any) {
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.signIn()
    }
    
}
