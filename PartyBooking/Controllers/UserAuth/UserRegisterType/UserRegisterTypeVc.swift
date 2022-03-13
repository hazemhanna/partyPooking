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
import TwitterKit
import RxSwift
import RxCocoa

class UserRegisterTypeVc: UIViewController,GIDSignInDelegate {

    
    private let AuthViewModel = AuthenticationViewModel()
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().delegate = self
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
    
    @IBAction func TwitterLogin(_ sender: UIButton) {
        self.AuthViewModel.showIndicator()
            TWTRTwitter.sharedInstance().logIn(with: self) { (session, error) in
                if let error = error {
                    print(error)
                    return
                } else {
                let client = TWTRAPIClient.withCurrentUser()
                client.requestEmail { email, error in
                    if (email != nil) {
                        let recivedEmailID = email ?? ""
                        print(recivedEmailID)
                    }else {
                        self.AuthViewModel.dismissIndicator()
                        print("error--: \(String(describing: error?.localizedDescription))");
                    }
                    
                    if let name = session?.userName ,
                    let id = session?.userID {
                    self.postRegister(email: email ?? "" , Name: name ,token: id , type: "twitter", phone: "")
                    }

                print(session?.userID , session?.userName)
                }
            }
        }
    }
    
    
    
    @IBAction func fblogin(_ sender: Any) {
        self.AuthViewModel.showIndicator()
        let loginManager = LoginManager()


        loginManager.logIn(permissions: [ .publicProfile,.email ], viewController: self) { loginResult in
            print(loginResult)
            let tokent = AccessToken.current?.tokenString
            let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields":"email, name,picture"], tokenString: tokent, version: nil, httpMethod: .get )
            request.start(completionHandler: {connection ,result,error in
                if error != nil{
                    self.AuthViewModel.dismissIndicator()
                    return
                }
            guard let json = result as? NSDictionary else { return }
            if let email = json["email"] as? String , let name  = json["name"] as? String,let id = json["id"] as? String  {
                self.postRegister(email: email  , Name: name  ,token: id , type: "facebook", phone: "")
               }
            })
        }
    }
    
    @IBAction func googlelogin(_ sender: Any) {
        self.AuthViewModel.showIndicator()
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,withError error: Error!) {
      if let error = error {
        if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
          print("The user has not signed in before or they have since signed out.")
        } else {
          print("\(error.localizedDescription)")
            self.AuthViewModel.dismissIndicator()

        }
        // [START_EXCLUDE silent]
        NotificationCenter.default.post(
          name: NSNotification.Name(rawValue: "ToggleAuthUINotification"), object: nil, userInfo: nil)
        // [END_EXCLUDE]
        return
      }
      // Perform any operations on signed in user here.
      let userId = user.userID                  // For client-side use only!
      let idToken = user.authentication.idToken // Safe to send to the server
      let fullName = user.profile.name
      let givenName = user.profile.givenName
      let familyName = user.profile.familyName
      let email = user.profile.email
        
        print(userId ?? "")
        print(idToken ?? "")
        print(fullName ?? "")
        print(givenName ?? "")
        print(familyName ?? "")
        print(email ?? "")
        
        self.postRegister(email: email ?? "" , Name: givenName ?? "" ,token: idToken ?? "" , type: "google", phone: "")
        NotificationCenter.default.post(
        name: NSNotification.Name(rawValue: "ToggleAuthUINotification"),object: nil,userInfo: ["statusText": "Signed in user:\n\(fullName!)"])
    }
    
    
    // [START disconnect_handler]
      func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // [START_EXCLUDE]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ToggleAuthUINotification"),object: nil,userInfo: ["statusText": "User has disconnected."])
      }
    
    
    func postRegister(email: String , Name : String , token : String , type : String,phone : String){
        AuthViewModel.attemptToLoginWithSocial(email: email, Name: Name, token: token, type: type, phone: phone).subscribe(onNext: { (registerData) in
           if registerData.status ?? false {
            self.AuthViewModel.dismissIndicator()
            let destinationVC = TabBarController.instantiate(fromAppStoryboard: .Main)
               if let appDelegate = UIApplication.shared.delegate {
                appDelegate.window??.rootViewController = destinationVC
            }
           }else {
            self.AuthViewModel.dismissIndicator()
            displayMessage(title: "", message: registerData.message ?? "", status: .error, forController: self)
           }
        }, onError: { (error) in
            self.AuthViewModel.dismissIndicator()
            displayMessage(title: "", message: error.localizedDescription, status: .error, forController: self)
        }).disposed(by: disposeBag)
    }
    
}


