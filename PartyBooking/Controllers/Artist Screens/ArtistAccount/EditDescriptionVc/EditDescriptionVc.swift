//
//  EditDescriptionVc.swift
//  PartyBooking
//
//  Created by MAC on 18/09/2021.
//  Copyright © 2021 MAC. All rights reserved.
//


import UIKit
import FlagPhoneNumber
import RxSwift
import RxCocoa
import IQKeyboardManagerSwift


class EditDescriptionVc: UIViewController {
    
    @IBOutlet weak var saveBtn : UIButton!
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var descriptionTextField: UITextView!
    @IBOutlet weak var fNameTextField: UITextField!
    @IBOutlet weak var lNameTextField: UITextField!

    
    fileprivate var returnHandler : IQKeyboardReturnKeyHandler!

    let aristId = Helper.getArtistId() ?? 0
    private let profileVM = ArtistProfileViewModel()
    var disposeBag = DisposeBag()
    
    
    @IBOutlet weak var backButton: UIButton! {
        didSet {
            backButton.setImage(backButton.currentImage?.flipIfNeeded(), for: .normal)
        }
    }
    
    
    let listController: FPNCountryListViewController = FPNCountryListViewController(style: .grouped)
    var dialCode = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DataBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        profileVM.showIndicator()
        getProfile()
        self.navigationController?.navigationBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
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


    
    @IBAction func backButton(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func saveButton(sender: UIButton) {
        guard self.validateInput() else { return }
        self.profileVM.showIndicator()
        updateDescription()
    }
    
}

extension EditDescriptionVc {
    func DataBinding() {
        _ = self.descriptionTextField.rx.text.map({$0 ?? ""}).bind(to: profileVM.descritpionss).disposed(by: disposeBag)
        _ = self.fNameTextField.rx.text.map({$0 ?? ""}).bind(to: profileVM.first_name).disposed(by: disposeBag)
        _ = self.lNameTextField.rx.text.map({$0 ?? ""}).bind(to: profileVM.last_name).disposed(by: disposeBag)
    }
}

extension EditDescriptionVc {
    func validateInput() -> Bool {
        var valid = false
        profileVM.validate().subscribe(onNext: { (result) in
            if result.isEmpty {
                valid = true
            } else {
                self.profileVM.dismissIndicator()
                displayMessage(title: "", message: result, status: .error, forController: self)
                valid = false
            }
        }).disposed(by: disposeBag)
        return valid
    }

    
    func getProfile() {
        profileVM.getProfile().subscribe(onNext: { (data) in
        self.profileVM.dismissIndicator()
        if data.status ?? false {
            self.fNameTextField.text = (data.result?.artist?.firstName ?? "")
            self.lNameTextField.text =  (data.result?.artist?.lastName ?? "")
            self.descriptionTextField.text = data.result?.artist?.artistDescription ?? ""
          }
        
    }, onError: { (error) in
        self.profileVM.dismissIndicator()

    }).disposed(by: disposeBag)
 }

    
    
    func updateDescription() {
        profileVM.updateDescription().subscribe(onNext: { (data) in
            self.profileVM.dismissIndicator()
            if data.status ?? false {
                self.navigationController?.popViewController(animated: true)
            }
        }, onError: { (error) in
            self.profileVM.dismissIndicator()

        }).disposed(by: disposeBag)
     }
    
    
}
