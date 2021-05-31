//
//  ArtistRegisterViewController.swift
//  PartyBooking
//
//  Created by MAC on 7/7/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit
import FlagPhoneNumber


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
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var fNameTextField: UITextField!
    @IBOutlet weak var phoneTextField: FPNTextField!
    @IBOutlet weak var areaTextField: TextFieldDropDown!
    @IBOutlet weak var serviceTextField: TextFieldDropDown!
    @IBOutlet weak var genderTextField: TextFieldDropDown!
    @IBOutlet weak var partyTextField: TextFieldDropDown!
    @IBOutlet weak var banckTextField: UITextField!
    
    var titles = ["5","4","3","2","1"]
    var gender = ["male","female"]

    let listController: FPNCountryListViewController = FPNCountryListViewController(style: .grouped)
    var dialCode = String()
    var profliePic : UIImage?
    
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
        areaTitleDropDown()
        genderDropDown()
        serviceTypeDropDown()
        partTypeDropDown()
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
        areaTextField.optionArray = self.titles
        areaTextField.didSelect { (selectedText, index, id) in
            self.areaTextField.text = selectedText
        }
    }
    
    func serviceTypeDropDown() {
        serviceTextField.optionArray = self.titles
        serviceTextField.didSelect { (selectedText, index, id) in
            self.serviceTextField.text = selectedText
        }
    }
    
    func genderDropDown() {
        genderTextField.optionArray = self.gender
        genderTextField.didSelect { (selectedText, index, id) in
            self.genderTextField.text = selectedText
        }
    }
    
    func partTypeDropDown() {
        partyTextField.optionArray = self.titles
        partyTextField.didSelect { (selectedText, index, id) in
            self.partyTextField.text = selectedText
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
        banckLabel.text = "bank".localized
        //banckTextField.placeholder = banckLabel.text
        
        if MOLHLanguage.currentAppleLanguage() == "en" {
            
            emailTextField.textAlignment = .left
            passTextField.textAlignment = .left
            lNameTextField.textAlignment = .left
            countryTextField.textAlignment = .left
            fNameTextField.textAlignment = .left
            phoneTextField.textAlignment = .left
            areaTextField.textAlignment = .left
            serviceTextField.textAlignment = .left
            banckTextField.textAlignment = .left
            
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
        }
        
    }
    
    
    @IBAction func PassWordInstructionsAction(_ sender: UIButton) {
         let vc = PassWordInstructions.instantiateFromNib()
        vc!.onClickClose = {
            self.presentingViewController?.dismiss(animated: true)
        }
        self.present(vc!, animated: true, completion: nil)
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
    
    
    @IBAction func nextButton(sender: UIButton) {
        let destinationVC = OfferPriceViewController.instantiateFromNib()
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
        if MOLHLanguage.currentAppleLanguage() == "en" {
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
            //self.ProfileImageView.image = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.profliePic =  originalImage
           // self.ProfileImageView.image = originalImage
        }
        dismiss(animated: true, completion: nil)
    }
    
}

