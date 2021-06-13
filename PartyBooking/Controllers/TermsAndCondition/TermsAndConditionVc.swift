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
    private let AuthViewModel = AuthenticationViewModel()
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.AuthViewModel.showIndicator()
        getTerms()
        termsTextView.isEditable = false
        termsTextView.isSelectable = false
    }

    @IBAction func backButton(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func getTerms() {
        AuthViewModel.getTerms().subscribe(onNext: { (data) in
            self.AuthViewModel.dismissIndicator()
            if data.status ?? false {
                if "lang".localized == "ar" {

                self.termsTextView.text = data.result?.terms?.arTerms ?? ""
                }else{
                    self.termsTextView.text = data.result?.terms?.enTerms ?? ""

                }
                }
        }, onError: { (error) in
            self.AuthViewModel.dismissIndicator()
            displayMessage(title: "", message: "Something went wrong in getting terms", status: .error, forController: self)
        }).disposed(by: disposeBag)
    }
    
}
