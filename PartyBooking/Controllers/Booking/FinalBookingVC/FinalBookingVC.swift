//
//  FinalBookingVC.swift
//  PartyBooking
//
//  Created by MAC on 06/09/2021.
//  Copyright © 2021 MAC. All rights reserved.
//

import UIKit
import FlagPhoneNumber
import RxSwift
import RxCocoa
import IQKeyboardManagerSwift


class FinalBookingVC: UIViewController ,UITextFieldDelegate{
    @IBOutlet weak var visaView : UIView!
    @IBOutlet weak var masterView : UIView!
    @IBOutlet weak var payView : UIView!
    @IBOutlet weak var stcView : UIView!
    @IBOutlet weak var madaView : UIView!
    @IBOutlet weak var passwordView : UIView!
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var fNameLabel : UILabel!
    @IBOutlet weak var lNameLabel : UILabel!
    @IBOutlet weak var emailLabel : UILabel!
    @IBOutlet weak var phoneLabel : UILabel!
    @IBOutlet weak var locationLabel : UILabel!
    @IBOutlet weak var countryLabel : UILabel!
    @IBOutlet weak var paymentLabel : UILabel!
    @IBOutlet weak var amountLabel : UILabel!
    @IBOutlet weak var amountValueLabel : UILabel!
    @IBOutlet weak var taxesLabel : UILabel!
    @IBOutlet weak var locationLbl : UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var lNameTextField: UITextField!
    @IBOutlet weak var countryTextField: TextFieldDropDown!
    @IBOutlet weak var fNameTextField: UITextField!
    @IBOutlet weak var phoneTextField: FPNTextField!
    @IBOutlet weak var doneBtn : UIButton!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var passwordLabel : UILabel!
    @IBOutlet weak var timeTo: CustomTextField!
    @IBOutlet weak var timeFrom: CustomTextField!
    @IBOutlet weak var backButton: UIButton! {
        didSet {
            backButton.setImage(backButton.currentImage?.flipIfNeeded(), for: .normal)
        }
    }
    private var timePicker1: UIDatePicker?
    private var timePicker2: UIDatePicker?
    fileprivate var returnHandler : IQKeyboardReturnKeyHandler!
    let listController: FPNCountryListViewController = FPNCountryListViewController(style: .grouped)

    private let profileVM = ProfileViewModel()
    var disposeBag = DisposeBag()
    var dialCode = String()
    var profliePic = UIImage()
    var country = [Country]()
    var filterCountry = [String]()
    var countryId = Int()
    var typeId :Int?
    var artistId :Int?
    var from = String()
    var to = String()
    var token = Helper.getAPIToken() ?? ""
   
    override func viewDidLoad() {
        super.viewDidLoad()
        doneBtn.layer.cornerRadius = 7
         style (view : visaView)
         style (view : masterView)
         style (view : payView)
         style (view : stcView)
         style (view : madaView)
        setUPLocalize()
        setupCountryPHone()
        DataBinding()
        profileVM.showIndicator()
        getAllCountry()
    //  updateReturnHandler()
        getProfile()
        amountValueLabel.text = String(Helper.getPrice() ?? 0 ) + " " + ("SR".localized)
        if token != "" {
            passwordView.isHidden = true
        }else{
            passwordView.isHidden = false
        }
        
        timePicker1 = UIDatePicker()
        timePicker2 = UIDatePicker()
        let loc = Locale.current
        timePicker1?.locale = loc
        timePicker2?.locale = loc
        timePicker1?.datePickerMode = .time
        timePicker1?.addTarget(self, action: #selector(time1Changed(TimePicker:)), for: .valueChanged)
        timeFrom .inputView = timePicker1
        timeFrom.delegate = self
        timePicker2?.datePickerMode = .time
        timePicker2?.addTarget(self, action: #selector(time2Changed(TimePicker:)), for: .valueChanged)
        timeTo.inputView = timePicker2
        timeTo.delegate = self
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
    

    func setUPLocalize(){
        titleLabel.text = "reserve".localized
        doneBtn.setTitle("reserve".localized, for: .normal)
        fNameLabel.text = "first".localized
        lNameLabel.text = "last".localized
        emailLabel.text = "email".localized
        phoneLabel.text = "phone".localized
        locationLabel.text = "location".localized
        countryLabel.text = "country".localized
        paymentLabel.text = "payment".localized
        amountLabel.text = "amount".localized
        passwordLabel.text = "password".localized
        taxesLabel.text = "\("taxes".localized) 450 \("SR".localized)"
        
        if "lang".localized  == "en" {
                emailTextField.textAlignment = .left
                lNameTextField.textAlignment = .left
                countryTextField.textAlignment = .left
                fNameTextField.textAlignment = .left
                phoneTextField.textAlignment = .left
                passTextField.textAlignment = .left
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
                          locationLabel.font = font
                           countryLabel.font = font
                           countryTextField.font  = font
                           doneBtn.titleLabel!.font =  UIFont(name: "Georgia-Bold", size: 17)
                
            } else {
                emailTextField.textAlignment = .right
                emailTextField.textAlignment = .right
                lNameTextField.textAlignment = .right
                countryTextField.textAlignment = .right
                fNameTextField.textAlignment = .right
                phoneTextField.textAlignment = .right
                passTextField.textAlignment = .right
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
    
    func setupCountryDropDown() {
        countryTextField.optionArray = self.filterCountry
        countryTextField.didSelect { (selectedText, index, id) in
            self.countryTextField.text = selectedText
            self.countryId = self.country[index].id ?? 0
        }
    }
    
    func style (view : UIView){
        view.layer.cornerRadius = 5.0
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.clear.cgColor
        view.layer.masksToBounds = true
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowRadius = 2.0
        view.layer.shadowOpacity = 0.5
        view.layer.masksToBounds = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.locationLbl.text = Helper.getAddress() ?? "location".localized
         self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func backButton(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func resevrButton(sender: UIButton) {
       if timeTo.text == "" {
        if "lang".localized == "ar" {
            displayMessage(title: "", message: "اختر الوقت", status: .error, forController: self)
        }else{
            displayMessage(title: "", message: "choose time", status: .error, forController: self)
        }
       }else if  timeTo.text == "" {
         
        if "lang".localized == "ar" {
            displayMessage(title: "", message: "اختر الوقت", status: .error, forController: self)
        }else{
            displayMessage(title: "", message: "choose time", status: .error, forController: self)
        }
       } else if locationLbl.text == ""{
            if "lang".localized == "ar" {
                displayMessage(title: "", message: "اختر الموقع", status: .error, forController: self)
            }else{
                displayMessage(title: "", message: "choose party location", status: .error, forController: self)
            }
        }else{
        if token != ""{
           self.profileVM.showIndicator()
           self.postBooking(artistId: artistId ?? 0
                            , area_id: Helper.getCID() ?? 0
                            , party_type_id: Helper.getPID() ?? 0
                            , address: Helper.getAddress() ?? ""
                            , lat: Helper.getLat() ?? 0.0
                            , long: Helper.getLong() ?? 0.0
                            , price:  Helper.getPrice() ?? 0
                            , date: Helper.getdate() ?? ""
                            , from_time: timeFrom.text ?? ""
                            , to_time: timeTo.text ?? "")
        
             }else{
                guard self.validateInput() else { return }
                profileVM.showIndicator()
                postRegister()
       }
    }
 }
    @IBAction func locationTapped(sender: UIButton) {
        let destinationVC = LocationVC.instantiate(fromAppStoryboard: .Main)
        self.navigationController?.pushViewController(destinationVC, animated: true)
      }
    
    @IBAction func PassWordInstructionsAction(_ sender: UIButton) {
         let vc = PassWordInstructions.instantiateFromNib()
        vc!.onClickClose = {
            self.presentingViewController?.dismiss(animated: true)
        }
        self.present(vc!, animated: true, completion: nil)
    }
    
    
    @objc func time1Changed(TimePicker: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = "hh:mm"
        timeFrom.text = formatter.string(from: TimePicker.date)
    }
    
    
    @objc func time2Changed(TimePicker: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = "hh:mm"
        timeTo.text = formatter.string(from: TimePicker.date)
    }
    
}


extension FinalBookingVC {
    //MARK:- DataBinding
    func DataBinding() {
        _ = self.emailTextField.rx.text.map({$0 ?? ""}).bind(to: profileVM.email).disposed(by: disposeBag)
        _ = self.fNameTextField.rx.text.map({$0 ?? ""}).bind(to: profileVM.first_name).disposed(by: disposeBag)
        _ = self.lNameTextField.rx.text.map({$0 ?? ""}).bind(to: profileVM.last_name).disposed(by: disposeBag)
        _ = self.countryTextField.rx.text.map({$0 ?? ""}).bind(to: profileVM.country).disposed(by: disposeBag)
        _ = self.phoneTextField.rx.text.map({$0 ?? ""}).bind(to: profileVM.phone).disposed(by: disposeBag)
        _ = self.passTextField.rx.text.map({$0 ?? ""}).bind(to: profileVM.password).disposed(by: disposeBag)

    }
}

extension FinalBookingVC {
    
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
    
    func postBooking(artistId  : Int, area_id:Int, party_type_id : Int,address : String,lat: Double,long : Double, price : Int , date : String , from_time : String ,to_time : String ) {
        profileVM.postBooking(artistId: artistId, area_id: area_id, party_type_id: party_type_id, address: address, lat: lat, long: long, price: price, date: date, from_time: from_time, to_time: to_time).subscribe(onNext: { (data) in
        self.profileVM.dismissIndicator()
        if data.status ?? false {
            if "lang".localized == "ar" {
                displayMessage(title: "تم", message: "في انتظار قبول الفنان", status: .success, forController: self)
            }else{
                displayMessage(title: "done", message: "wait to artist confirm", status: .success, forController: self)
            }
            
            let main = TabBarController.instantiate(fromAppStoryboard: .Main)
           if let appDelegate = UIApplication.shared.delegate {
               appDelegate.window??.rootViewController = main
           }
        }else{
            displayMessage(title: "", message: data.message ?? "", status: .error, forController: self)

        }
    }, onError: { (error) in
        self.profileVM.dismissIndicator()
    }).disposed(by: disposeBag)
 }
    
    func postRegister(){
        profileVM.attemptToRegister(image: self.profliePic, countryId: self.countryId).subscribe(onNext: { (registerData) in
           if registerData.status ?? false {
            self.postBooking(artistId: self.artistId ?? 0
                             , area_id: Helper.getCID() ?? 0
                             , party_type_id: Helper.getPID() ?? 0
                             , address: self.countryTextField.text ?? ""
                             , lat: Helper.getLat() ?? 0.0
                             , long: Helper.getLong() ?? 0.0
                             , price:  Helper.getPrice() ?? 0
                             , date: Helper.getdate() ?? ""
                             , from_time: self.timeFrom.text ?? ""
                             , to_time: self.timeTo.text ?? "")
            
           }else {
            self.profileVM.dismissIndicator()
            displayMessage(title: "", message: registerData.message ?? "", status: .error, forController: self)
           }
        }, onError: { (error) in
            self.profileVM.dismissIndicator()
            displayMessage(title: "", message: error.localizedDescription, status: .error, forController: self)
        }).disposed(by: disposeBag)
    }
}

extension FinalBookingVC : FPNTextFieldDelegate {
    
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

}


