//
//  ArtistRegisterViewController.swift
//  PartyBooking
//
//  Created by MAC on 7/7/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit
import FlagPhoneNumber
import IQKeyboardManagerSwift
import RxSwift
import RxCocoa


class ArtistRegisterViewController: UIViewController {
    
    @IBOutlet weak var numberView: UIView!
    @IBOutlet weak var nextBtn : UIButton!
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var fNameLabel : UILabel!
    @IBOutlet weak var lNameLabel : UILabel!
    @IBOutlet weak var emailLabel : UILabel!
    @IBOutlet weak var phoneLabel : UILabel!
    @IBOutlet weak var passwordLabel : UILabel!
    @IBOutlet weak var countryLabel : UILabel!
    @IBOutlet weak var areaLabel : UILabel!
    @IBOutlet weak var serviceLabel : UILabel!
    @IBOutlet weak var banckLabel : UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var lNameTextField: UITextField!
    @IBOutlet weak var countryTextField: TextFieldDropDown!
    @IBOutlet weak var fNameTextField: UITextField!
    @IBOutlet weak var phoneTextField: FPNTextField!
    @IBOutlet weak var areaTextField: TextFieldDropDown!
    @IBOutlet weak var serviceTextField: TextFieldDropDown!
    @IBOutlet weak var genderTextField: TextFieldDropDown!
    @IBOutlet weak var banckTextField: UITextField!
    @IBOutlet weak var banckAcountTextField: UITextField!

    
    fileprivate var returnHandler : IQKeyboardReturnKeyHandler!
    private let authModel = ArtistAuthenticationVM()
    var disposeBag = DisposeBag()

    var service = [PartyType]()
    var filterService = [String]()
    var country = [Country]()
    var filterCountry = [String]()
    var areas = [Areas]()
    var filterAreas = [String]()
    var countryId :Int?
    var serviceId :Int?
    var areaId :Int?
    var gender = ["male".localized,"female".localized]
    let listController: FPNCountryListViewController = FPNCountryListViewController(style: .grouped)
    var dialCode = String()
    var profliePic : UIImage?
    var selectedgender = String()
    @IBOutlet weak var backButton: UIButton! {
        didSet {
            backButton.setImage(backButton.currentImage?.flipIfNeeded(), for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextBtn.layer.cornerRadius = 7
        numberView.layer.borderColor = UIColor.rgb(112, green: 112, blue: 112).cgColor
        numberView.layer.borderWidth = 1
        setUPLocalize()
        setupCountryPHone()
        genderDropDown()
        authModel.showIndicator()
        getServices()
        getAllCountry()
        getArea()
        DataBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
    
    func areaTitleDropDown() {
        areaTextField.optionArray = self.filterAreas
        areaTextField.didSelect { (selectedText, index, id) in
            self.areaTextField.text = selectedText
            self.areaId = self.areas[index].id ?? 0
        }
    }
    
    func serviceTypeDropDown() {
        serviceTextField.optionArray = self.filterService
        serviceTextField.didSelect { (selectedText, index, id) in
            self.serviceTextField.text = selectedText
            self.serviceId = self.service[index].id ?? 0
        }
    }
    
    func genderDropDown() {
        genderTextField.optionArray = self.gender
        genderTextField.didSelect { (selectedText, index, id) in
            self.genderTextField.text = selectedText
            if index == 0 {
                self.selectedgender = "male"
            }else{
                self.selectedgender = "female"
            }
        }
    }
    
    func countryDropDown() {
        countryTextField.optionArray = self.filterCountry
        countryTextField.didSelect { (selectedText, index, id) in
            self.countryTextField.text = selectedText
            self.countryId = self.country[index].id ?? 0
        }
    }
    
    func setUPLocalize(){
        titleLabel.text = "information".localized
        nextBtn.setTitle("next".localized, for: .normal)
        fNameLabel.text = "first".localized
        //fNameTextField.placeholder = fNameLabel.text
        lNameLabel.text = "last".localized
        //lNameTextField.placeholder = lNameLabel.text
        emailLabel.text = "email".localized
        //emailTextField.placeholder = emailLabel.text
        phoneLabel.text = "phone".localized
       // phoneTextField.placeholder =  phoneLabel.text
        passwordLabel.text = "password".localized
       // passTextField.placeholder = passwordLabel.text
        countryLabel.text = "country".localized
        //countryTextField.placeholder  = countryLabel.text
        serviceLabel.text = "service".localized
       // serviceTextField.placeholder =  serviceLabel.text
        areaLabel.text = "area".localized
        //areaTextField.placeholder =  areaLabel.text
        banckLabel.text = "bankName".localized
        banckAcountTextField.placeholder = "bank".localized
        //banckTextField.placeholder = banckLabel.text
        if "lang".localized  == "en" {

            emailTextField.textAlignment = .left
            passTextField.textAlignment = .left
            lNameTextField.textAlignment = .left
            countryTextField.textAlignment = .left
            fNameTextField.textAlignment = .left
            phoneTextField.textAlignment = .left
            areaTextField.textAlignment = .left
            serviceTextField.textAlignment = .left
            banckTextField.textAlignment = .left
            banckAcountTextField.textAlignment = .left

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
            passwordLabel.font = font
            passTextField.font = font
            countryLabel.font = font
            countryTextField.font  = font
            serviceLabel.font = font
            serviceTextField.font = font
            areaLabel.font = font
            areaTextField.font =  font
            banckLabel.font = font
            banckTextField.font = font
            nextBtn.titleLabel!.font =  UIFont(name: "Georgia-Bold", size: 17)
        } else {
            emailTextField.textAlignment = .right
            emailTextField.textAlignment = .right
            passTextField.textAlignment = .right
            lNameTextField.textAlignment = .right
            countryTextField.textAlignment = .right
            fNameTextField.textAlignment = .right
            phoneTextField.textAlignment = .right
            areaTextField.textAlignment = .right
            serviceTextField.textAlignment = .right
            banckTextField.textAlignment = .right
            banckAcountTextField.textAlignment = .right
        }
        
    }
    
    
    @IBAction func PassWordInstructionsAction(_ sender: UIButton) {
         let vc = PassWordInstructions.instantiateFromNib()
        vc!.onClickClose = {
            self.presentingViewController?.dismiss(animated: true)
        }
        self.present(vc!, animated: true, completion: nil)
    }
    
    @IBAction func backButton(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func nextButton(sender: UIButton) {
       // guard self.validateInput() else { return }
        let destinationVC = OfferPriceViewController.instantiateFromNib()
        destinationVC?.emailTextField = emailTextField.text ?? ""
        destinationVC?.passTextField =  passTextField.text ?? ""
        destinationVC?.lNameTextField =  lNameTextField.text ?? ""
        destinationVC?.countryTextField =  countryId ?? 0
        destinationVC?.fNameTextField = fNameTextField.text ?? ""
        destinationVC?.phoneTextField =  phoneTextField.text ?? ""
        destinationVC?.area = areaId ?? 0
        destinationVC?.serviceTextField =  serviceId ?? 0
        destinationVC?.banckTextField =  banckTextField.text ?? ""
        destinationVC?.banckAcountTextField =  banckAcountTextField.text ?? ""
        destinationVC?.genderTextField = selectedgender
        destinationVC?.image =  profliePic ?? #imageLiteral(resourceName: "5")
        self.navigationController?.pushViewController(destinationVC!, animated: true)
    }
}

extension ArtistRegisterViewController : FPNTextFieldDelegate {
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


extension ArtistRegisterViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBAction func choosePicGallery(_ sender: CustomButtons) {
        showImageActionSheet()
    }
    
    func showImageActionSheet() {
        if "lang".localized  == "en" {
            let chooseFromLibraryAction = UIAlertAction(title: "Choose from Library", style: .default) { (action) in
                self.showImagePicker(sourceType: .photoLibrary)
            }
            let cameraAction = UIAlertAction(title: "Take a Picture from Camera", style: .default) { (action) in
                self.showImagePicker(sourceType: .camera)
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            AlertService.showAlert(style: .actionSheet, title: "Pick Your Picture", message: nil, actions: [chooseFromLibraryAction, cameraAction, cancelAction], completion: nil)
        } else {
            let chooseFromLibraryAction = UIAlertAction(title: "أختر من مكتبة الصور", style: .default) { (action) in
                self.showImagePicker(sourceType: .photoLibrary)
            }
            let cameraAction = UIAlertAction(title: "إلتقاط صورة من الكاميرة", style: .default) { (action) in
                self.showImagePicker(sourceType: .camera)
            }
            
            let cancelAction = UIAlertAction(title: "إلغاء", style: .cancel, handler: nil)
            AlertService.showAlert(style: .actionSheet, title: "أختر صورك", message: nil, actions: [chooseFromLibraryAction, cameraAction, cancelAction], completion: nil)
        }
    }

    func showImagePicker(sourceType: UIImagePickerController.SourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = sourceType
        imagePickerController.mediaTypes = ["public.image"]
        imagePickerController.view.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.profliePic =  editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.profliePic =  originalImage
        }
        dismiss(animated: true, completion: nil)
    }
    
}


extension ArtistRegisterViewController {
    //MARK:- DataBinding
    func DataBinding() {
        _ = self.emailTextField.rx.text.map({$0 ?? ""}).bind(to: authModel.email).disposed(by: disposeBag)
        _ = self.fNameTextField.rx.text.map({$0 ?? ""}).bind(to: authModel.first_name).disposed(by: disposeBag)
        _ = self.lNameTextField.rx.text.map({$0 ?? ""}).bind(to: authModel.last_name).disposed(by: disposeBag)
        _ = self.passTextField.rx.text.map({$0 ?? ""}).bind(to: authModel.password).disposed(by: disposeBag)
        _ = self.countryTextField.rx.text.map({$0 ?? ""}).bind(to: authModel.country).disposed(by: disposeBag)
        _ = self.phoneTextField.rx.text.map({$0 ?? ""}).bind(to: authModel.phone).disposed(by: disposeBag)
        _ = self.banckTextField.rx.text.map({$0 ?? ""}).bind(to: authModel.bankName).disposed(by: disposeBag)
        _ = self.banckAcountTextField.rx.text.map({$0 ?? ""}).bind(to: authModel.bankAcount).disposed(by: disposeBag)

    }
}


extension ArtistRegisterViewController {

    func validateInput() -> Bool {
        var valid = false
        authModel.validate(country: countryTextField.text ?? "", area: areaTextField.text ?? "", service: serviceTextField.text ?? "", gender: genderTextField.text ?? "").subscribe(onNext: { (result) in
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
    
    
    func getServices() {
        authModel.getServices().subscribe(onNext: { (data) in
            if data.status ?? false {
                self.authModel.dismissIndicator()
                self.service = data.result ?? []
                for index in self.service {
                    if "lang".localized == "ar" {
                    self.filterService.append(index.arName ?? "")
                    }else{
                     self.filterService.append(index.enName ?? "")
                    }
                }
                self.serviceTypeDropDown()
            }
        }, onError: { (error) in
            self.authModel.dismissIndicator()
        }).disposed(by: disposeBag)
     }
    
    
    
    
    func getArea() {
        authModel.getArea().subscribe(onNext: { (data) in
            if data.status ?? false {
                self.authModel.dismissIndicator()
                self.areas = data.result ?? []
                for index in self.areas {
                    if "lang".localized == "ar" {
                    self.filterAreas.append(index.arName ?? "")
                    }else{
                        self.filterAreas.append(index.enName ?? "")

                    }
                }
                self.areaTitleDropDown()
            }
        }, onError: { (error) in
            self.authModel.dismissIndicator()
        }).disposed(by: disposeBag)
     }
    
    
    func getAllCountry() {
        authModel.getCountry().subscribe(onNext: { (data) in
            self.authModel.dismissIndicator()
            if data.status ?? false {
                self.country = data.result ?? []
                for index in self.country{
                    if "lang".localized == "ar" {
                        self.filterCountry.append(index.arName ?? "")
                    }else{
                        self.filterCountry.append(index.enName ?? "")
                    }
                }
                self.countryDropDown()
            }
        }, onError: { (error) in
            self.authModel.dismissIndicator()
        }).disposed(by: disposeBag)
    }
    
    
}
