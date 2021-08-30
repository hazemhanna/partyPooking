//
//  EditProfileViewController.swift
//  PartyBooking
//
//  Created by MAC on 7/4/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit
import FlagPhoneNumber
import RxSwift
import RxCocoa


class EditProfileViewController: UIViewController {
    
    @IBOutlet weak var saveBtn : UIButton!
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var fNameLabel : UILabel!
    @IBOutlet weak var lNameLabel : UILabel!
    @IBOutlet weak var emailLabel : UILabel!
    @IBOutlet weak var phoneLabel : UILabel!
    @IBOutlet weak var countryLabel : UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var lNameTextField: UITextField!
    @IBOutlet weak var countryTextField: TextFieldDropDown!
    @IBOutlet weak var fNameTextField: UITextField!
    @IBOutlet weak var phoneTextField: FPNTextField!

    private let profileVM = ProfileViewModel()
    var disposeBag = DisposeBag()
    
    var country = [Country]()
    var filterCountry = [String]()
    var countryId = Int()
    
    @IBOutlet weak var backButton: UIButton! {
        didSet {
            backButton.setImage(backButton.currentImage?.flipIfNeeded(), for: .normal)
        }
    }
    
    
    let listController: FPNCountryListViewController = FPNCountryListViewController(style: .grouped)
    var dialCode = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUPLocalize()
        setupCountryPHone()
        getAllCountry()
    }
    func setUPLocalize(){
        saveBtn.layer.cornerRadius = 7
        titleLabel.text = "edit".localized
        saveBtn.setTitle("save".localized, for: .normal)
        fNameLabel.text = "first".localized
        lNameLabel.text = "last".localized
        emailLabel.text = "email".localized
        phoneLabel.text = "phone".localized
        countryLabel.text = "country".localized
        
        if "lang".localized  == "en" {
            emailTextField.textAlignment = .left
            lNameTextField.textAlignment = .left
            countryTextField.textAlignment = .left
            fNameTextField.textAlignment = .left
            phoneTextField.textAlignment = .left
            let font = UIFont(name: "Georgia-Bold", size: 14)
            titleLabel.font = font
            fNameLabel.font = font
            fNameTextField.font = font
            lNameLabel.font = font
            lNameTextField.font = font
            emailLabel.font = font
            emailTextField.font = font
            phoneLabel.font = font
            phoneTextField.font =  font
            countryLabel.font = font
            countryTextField.font  = font
            saveBtn.titleLabel!.font =  UIFont(name: "Georgia-Bold", size: 17)
        } else {
            emailTextField.textAlignment = .right
            emailTextField.textAlignment = .right
            lNameTextField.textAlignment = .right
            countryTextField.textAlignment = .right
            fNameTextField.textAlignment = .right
            phoneTextField.textAlignment = .right
        }
    }
    
    func setupCountryPHone(){
             self.phoneTextField.delegate = self
             self.phoneTextField.displayMode = .list // .picker by default
             self.phoneTextField.setCountries(excluding: [.IL])
             self.phoneTextField.setFlag(key: .SA)
             listController.setup(repository: self.phoneTextField.countryRepository)
             listController.didSelect = { [weak self] country in
             self?.phoneTextField.setFlag(countryCode: country.code)
             }
         }
    
    override func viewWillAppear(_ animated: Bool) {
        profileVM.showIndicator()
        getProfile()
        self.navigationController?.navigationBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    
    @IBAction func backButton(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func saveButton(sender: UIButton) {
        self.profileVM.showIndicator()
        editProfile(country_id: countryId)
    }
    
    
    func setupCountryDropDown() {
        countryTextField.optionArray = self.filterCountry
        countryTextField.didSelect { (selectedText, index, id) in
            self.countryTextField.text = selectedText
            self.countryId = self.country[index].id ?? 0

        }
    }
    
    
}

extension EditProfileViewController : FPNTextFieldDelegate {
    func fpnDisplayCountryList() {
        let navigationViewController = UINavigationController(rootViewController: listController)
        listController.title = "Countries"
        self.present(navigationViewController, animated: true, completion: nil)
    }
    
    func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
        print(name, dialCode, code)
        self.dialCode = dialCode
    }
    
    func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
   
    }
    
    func DataBinding() {
        _ = self.emailTextField.rx.text.map({$0 ?? ""}).bind(to: profileVM.email).disposed(by: disposeBag)
        _ = self.fNameTextField.rx.text.map({$0 ?? ""}).bind(to: profileVM.first_name).disposed(by: disposeBag)
        _ = self.lNameTextField.rx.text.map({$0 ?? ""}).bind(to: profileVM.last_name).disposed(by: disposeBag)
        _ = self.countryTextField.rx.text.map({$0 ?? ""}).bind(to: profileVM.country).disposed(by: disposeBag)
        _ = self.phoneTextField.rx.text.map({$0 ?? ""}).bind(to: profileVM.phone).disposed(by: disposeBag)
    }
    
}

extension EditProfileViewController {
    
    
    func validateInput() -> Bool {
        var valid = false
        profileVM.validate(country: countryTextField.text ?? "").subscribe(onNext: { (result) in
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
            
            self.emailTextField.text = data.result?.user?.email ?? ""
            self.lNameTextField.text =  data.result?.user?.lastName ?? ""
            self.countryTextField.text =  data.result?.user?.country?.enName ?? ""
            self.fNameTextField.text =  data.result?.user?.firstName ?? ""
            self.phoneTextField.text =  data.result?.user?.phone ?? ""
            self.DataBinding()
        }
    }, onError: { (error) in
        self.profileVM.dismissIndicator()
        displayMessage(title: "", message: "Something went wrong in getting data", status: .error, forController: self)
    }).disposed(by: disposeBag)
 }
    
    func getAllCountry() {
        profileVM.getCountry().subscribe(onNext: { (data) in
            self.profileVM.dismissIndicator()
            if data.status ?? false {
                self.country = data.result ?? []
                for index in self.country{
                    if "lang".localized == "ar" {
                        self.filterCountry.append(index.arName ?? "")
                    }else{
                        self.filterCountry.append(index.enName ?? "")
                    }
                }
                self.setupCountryDropDown()
            }
        }, onError: { (error) in
            self.profileVM.dismissIndicator()
            displayMessage(title: "", message: "Something went wrong in getting Country", status: .error, forController: self)
        }).disposed(by: disposeBag)
    }
  
    
    func editProfile(country_id : Int) {
        profileVM.editProfile(country_id: country_id).subscribe(onNext: { (data) in
            self.profileVM.dismissIndicator()
            if data.status ?? false {
                displayMessage(title: "", message: data.message ?? "", status: .success, forController: self)
                self.navigationController?.popViewController(animated: true)

            }
        }, onError: { (error) in
            self.profileVM.dismissIndicator()
            displayMessage(title: "", message: "Something went wrong in getting Country", status: .error, forController: self)
        }).disposed(by: disposeBag)
    }
}
