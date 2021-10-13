
//
//  ArtistLoginVC.swift
//  PartyBooking
//
//  Created by MAC on 27/04/2021.
//  Copyright © 2021 MAC. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginVC : UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
     private let authModel = ArtistAuthenticationVM()
     var disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DataBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func back(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    
    @IBAction func logInButton(sender: UIButton) {
        guard self.validateInput() else { return }
        authModel.showIndicator()
        postlogin()
    }
    

    
}

extension LoginVC {
    //MARK:- DataBinding
    func DataBinding() {
        _ = self.emailTextField.rx.text.map({$0 ?? ""}).bind(to: authModel.email).disposed(by: disposeBag)
        _ = self.passTextField.rx.text.map({$0 ?? ""}).bind(to: authModel.password).disposed(by: disposeBag)
    }
    
    
    func validateInput() -> Bool {
        var valid = false
        authModel.validateLogin().subscribe(onNext: { (result) in
            if result.isEmpty {
                valid = true
            } else {
                self.authModel.dismissIndicator()
                displayMessage(title: "", message: result, status: .error, forController: self)
                valid = false
            }
        }).disposed(by: disposeBag)
        return valid
    }
    
    func postlogin(){
        authModel.attemptToLogin().subscribe(onNext: { (registerData) in
           if registerData.status ?? false {
            self.authModel.dismissIndicator()
            let destinationVC = TabBarController.instantiate(fromAppStoryboard: .Main)
            Helper.saveType(token: "artist")
            if let appDelegate = UIApplication.shared.delegate {
                appDelegate.window??.rootViewController = destinationVC
            }
           }else {
            self.authModel.dismissIndicator()
            displayMessage(title: "", message: registerData.message ?? "", status: .error, forController: self)
           }
        }, onError: { (error) in
            self.authModel.dismissIndicator()
            displayMessage(title: "", message: error.localizedDescription, status: .error, forController: self)
        }).disposed(by: disposeBag)
    }
    
}
