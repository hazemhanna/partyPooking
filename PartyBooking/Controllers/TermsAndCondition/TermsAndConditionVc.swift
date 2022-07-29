//
//  TermsAndConditionVc.swift
//  PartyBooking
//
//  Created by MAC on 21/05/2021.
//  Copyright © 2021 MAC. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TermsAndConditionVc: UIViewController {
    
    @IBOutlet weak var termsTextView: UITextView!
    @IBOutlet weak var titleLbl : UILabel!

    private let AuthViewModel = AuthenticationViewModel()
    var disposeBag = DisposeBag()
    var type = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        termsTextView.isEditable = false
        termsTextView.isSelectable = false
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.AuthViewModel.showIndicator()

        if type == "terms"{
            getTerms()
            titleLbl.text = "terms and condition".localized
        }else if type ==  "about"{
            about()
            titleLbl.text = "about".localized
        }else {
            about()
            titleLbl.text = "privacy".localized
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
    
    func getTerms() {
        AuthViewModel.getTerms().subscribe(onNext: { (data) in
            self.AuthViewModel.dismissIndicator()
            if data.status ?? false {
                if "lang".localized == "ar" {
                  self.termsTextView.text = data.result?.arTerms ?? ""
                }else{
                    self.termsTextView.text = data.result?.enTerms ?? ""
                   }
                }
        }, onError: { (error) in
            self.AuthViewModel.dismissIndicator()
            displayMessage(title: "", message: "Something went wrong in getting terms", status: .error, forController: self)
        }).disposed(by: disposeBag)
    }
    
    
    func about() {
        AuthViewModel.about().subscribe(onNext: { (data) in
            self.AuthViewModel.dismissIndicator()
            if data.status ?? false {
                if "lang".localized == "ar" {
                    self.termsTextView.text = data.result?.arAboutus ?? ""
                }else{
                    self.termsTextView.text = data.result?.enAboutus ?? ""
                }
            }
        }, onError: { (error) in
            self.AuthViewModel.dismissIndicator()
            displayMessage(title: "", message: "Something went wrong in getting terms", status: .error, forController: self)
        }).disposed(by: disposeBag)
    }
}
