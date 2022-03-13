//
//  LoginUserVC.swift
//  PartyBooking
//
//  Created by MAC on 20/05/2021.
//  Copyright © 2021 MAC. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import IQKeyboardManagerSwift


class LoginUserVC: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    fileprivate var returnHandler : IQKeyboardReturnKeyHandler!

    
    private let AuthViewModel = AuthenticationViewModel()
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DataBinding()
        updateReturnHandler()
    }

    func updateReturnHandler(){
        if returnHandler == nil {
            returnHandler = IQKeyboardReturnKeyHandler(controller: self)
        }else{
            returnHandler.removeResponderFromView(self.view)
            returnHandler.addResponderFromView(self.view)
        }
        returnHandler.lastTextFieldReturnKeyType = .done
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
    
    @IBAction func forgetButton(sender: UIButton) {
        let destinationVC = ForgetPasswordVC1.instantiateFromNib()
        self.navigationController?.pushViewController(destinationVC!, animated: true)
    }
    
    @IBAction func loginButton(sender: UIButton) {
        guard self.validateInput() else { return }
        AuthViewModel.showIndicator()
        postlogin()
    }

    
}

extension LoginUserVC {
    //MARK:- DataBinding
    func DataBinding() {
        _ = self.emailTextField.rx.text.map({$0 ?? ""}).bind(to: AuthViewModel.email).disposed(by: disposeBag)
        _ = self.passTextField.rx.text.map({$0 ?? ""}).bind(to: AuthViewModel.password).disposed(by: disposeBag)
    }
}


extension LoginUserVC {
    func validateInput() -> Bool {
        var valid = false
        AuthViewModel.validateLogin().subscribe(onNext: { (result) in
            if result.isEmpty {
                valid = true
            } else {
                self.AuthViewModel.dismissIndicator()
                displayMessage(title: "", message: result, status: .error, forController: self)
                valid = false
            }
        }).disposed(by: disposeBag)
        return valid
    }
    func postlogin(){
        AuthViewModel.attemptToLogin().subscribe(onNext: { (registerData) in
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



