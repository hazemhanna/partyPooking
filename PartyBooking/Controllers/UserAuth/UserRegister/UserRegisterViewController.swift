//
//  UserRegisterViewController.swift
//  PartyBooking
//
//  Created by MAC on 7/8/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit
import FlagPhoneNumber

class UserRegisterViewController: UIViewController {

    @IBOutlet weak var visaView : UIView!
    @IBOutlet weak var masterView : UIView!
    @IBOutlet weak var payView : UIView!
    @IBOutlet weak var stcView : UIView!
    @IBOutlet weak var madaView : UIView!
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var fNameLabel : UILabel!
    @IBOutlet weak var lNameLabel : UILabel!
    @IBOutlet weak var emailLabel : UILabel!
    @IBOutlet weak var phoneLabel : UILabel!
    @IBOutlet weak var passwordLabel : UILabel!
    @IBOutlet weak var countryLabel : UILabel!
    @IBOutlet weak var paymentLabel : UILabel!
    @IBOutlet weak var amountLabel : UILabel!
    @IBOutlet weak var amountValueLabel : UILabel!
    @IBOutlet weak var taxesLabel : UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var lNameTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var fNameTextField: UITextField!
    @IBOutlet weak var phoneTextField: FPNTextField!
    @IBOutlet weak var doneBtn : UIButton!
    @IBOutlet weak var privcyLabel : UILabel!
    @IBOutlet weak var termsConditionsButton: CustomButtons!

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
        doneBtn.layer.cornerRadius = 7
         style (view : visaView)
         style (view : masterView)
         style (view : payView)
         style (view : stcView)
         style (view : madaView)
        setUPLocalize()
        setupCountryPHone()
        setupMultiColorRegisterLabel()
        
        let gestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(self.PrivecyTapAction(_:)))
        privcyLabel.isUserInteractionEnabled = true
        privcyLabel.addGestureRecognizer(gestureRecognizer2)
        
    }

    func setUPLocalize(){
        titleLabel.text = "information".localized
        doneBtn.setTitle("done".localized, for: .normal)
        fNameLabel.text = "first".localized
        lNameLabel.text = "last".localized
        emailLabel.text = "email".localized
        phoneLabel.text = "phone".localized
        passwordLabel.text = "password".localized
        countryLabel.text = "country".localized
        paymentLabel.text = "payment".localized
        amountLabel.text = "amount".localized
        taxesLabel.text = "\("taxes".localized) + SR 450"
            if MOLHLanguage.currentAppleLanguage() == "en" {
                emailTextField.textAlignment = .left
                passTextField.textAlignment = .left
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
                           passwordLabel.font = font
                           passTextField.font = font
                           countryLabel.font = font
                           countryTextField.font  = font
                           doneBtn.titleLabel!.font =  UIFont(name: "Georgia-Bold", size: 17)
                
            } else {
                emailTextField.textAlignment = .right
                emailTextField.textAlignment = .right
                passTextField.textAlignment = .right
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
    
    @objc func PrivecyTapAction(_ sender: UITapGestureRecognizer) {
          let main = TermsAndConditionVc.instantiateFromNib()
          self.navigationController?.pushViewController(main!, animated: true)
      }
    
       func setupMultiColorRegisterLabel() {
          let main_string = "read and agree terms and condition"
          let coloredString2 = "terms and condition"
          let Range2 = (main_string as NSString).range(of: coloredString2)
          let attribute2 = NSMutableAttributedString.init(string: main_string)
          attribute2.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.blue , range: Range2)
          privcyLabel.attributedText = attribute2
      }
    
      var flag = true
     @IBAction func termsConditions(_ sender: UIButton) {
        if flag == true {
            self.termsConditionsButton.setImage(#imageLiteral(resourceName: "Group 37"), for: .normal)
            flag = false
        } else {
            self.termsConditionsButton.setImage(#imageLiteral(resourceName: "Rectangle 11"), for: .normal)
            flag = true
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
         self.navigationController?.navigationBar.isHidden = true
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }

        
    @IBAction func backButton(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
           
    @IBAction func nextButton(sender: UIButton) {
        let destinationVC = TabBarController.instantiate(fromAppStoryboard: .Main)
        destinationVC.type = .user
        if let appDelegate = UIApplication.shared.delegate {
            appDelegate.window??.rootViewController = destinationVC
        }
    }
    
    
    @IBAction func PassWordInstructionsAction(_ sender: UIButton) {
         let vc = PassWordInstructions.instantiateFromNib()
        vc!.onClickClose = {
            self.presentingViewController?.dismiss(animated: true)
        }
        self.present(vc!, animated: true, completion: nil)
    }
}


extension UserRegisterViewController : FPNTextFieldDelegate {
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

extension UserRegisterViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
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
