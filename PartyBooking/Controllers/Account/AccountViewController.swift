//
//  AccountViewController.swift
//  PartyBooking
//
//  Created by MAC on 7/2/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import FlagPhoneNumber
import IQKeyboardManagerSwift


class AccountViewController: UIViewController {
    
    @IBOutlet weak var profilehImage : UIImageView!
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var saveBtn : UIButton!
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
    
    var token = Helper.getAPIToken() ?? ""
    private let profileVM = ProfileViewModel()
    var disposeBag = DisposeBag()
    var country = [Country]()
    var filterCountry = [String]()
    var countryId = Int()
    let listController: FPNCountryListViewController = FPNCountryListViewController(style: .grouped)
    var dialCode = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         style()
         titleLabel.text = "myAccount".localized
        setupCountryPHone()
        getAllCountry()
    }
    
    func style(){
        
        profilehImage.layer.cornerRadius = profilehImage.frame.width / 2
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
    
    override func viewWillAppear(_ animated: Bool) {
        if token == "" {
            let main = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Nav")
           if let appDelegate = UIApplication.shared.delegate {
               appDelegate.window??.rootViewController = main
           }
        }else{
             self.profileVM.showIndicator()
             getProfile()
             self.navigationController?.navigationBar.isHidden = true
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
           self.navigationController?.navigationBar.isHidden = false
       }

    @IBAction func backButton(sender: UIButton) {
          self.navigationController?.popViewController(animated: true)
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

extension AccountViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
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
            self.profilehImage.image =  editedImage
            self.chagePhoto(image: editedImage)
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.profilehImage.image =  originalImage
            self.chagePhoto(image: originalImage)

        }
        dismiss(animated: true, completion: nil)
    }
    
}

extension AccountViewController : FPNTextFieldDelegate {
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

extension AccountViewController {

    func chagePhoto(image : UIImage) {
        profileVM.changePhoto(image: image).subscribe(onNext: { (data) in
            self.profileVM.dismissIndicator()
            if data.status ?? false {
               // displayMessage(title: "", message: data.message ?? "", status: .success, forController: self)
            }
        }, onError: { (error) in
            self.profileVM.dismissIndicator()
            displayMessage(title: "", message: "Something went wrong in getting data".localized, status: .error, forController: self)
        }).disposed(by: disposeBag)
     }
    
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
            if "lang".localized == "ar" {
               self.countryTextField.text =  data.result?.user?.country?.arName ?? ""
            }else{
                self.countryTextField.text =  data.result?.user?.country?.enName ?? ""
            }
            self.fNameTextField.text =  data.result?.user?.firstName ?? ""
            self.phoneTextField.text =  data.result?.user?.phone ?? ""
            if let iamg = URL(string: "https://partybooking.dtagdev.com/" + (data.result?.user?.image ?? "") ){
            self.profilehImage.kf.setImage(with: iamg, placeholder: #imageLiteral(resourceName: "5"))
            }
          self.DataBinding()
        }
    }, onError: { (error) in
        self.profileVM.dismissIndicator()
        displayMessage(title: "", message: "Something went wrong in getting data".localized, status: .error, forController: self)
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
            displayMessage(title: "", message: "Something went wrong in getting data".localized, status: .error, forController: self)
        }).disposed(by: disposeBag)
    }
  
    
    func editProfile(country_id : Int) {
        profileVM.editProfile(country_id: country_id).subscribe(onNext: { (data) in
            self.profileVM.dismissIndicator()
            if data.status ?? false {
                if "lang".localized  == "en" {
                    displayMessage(title: "", message: "done change profile", status: .success, forController: self)
                }else{
                    displayMessage(title: "", message: "تم تغير الملف الشخصي", status: .success, forController: self)
                }
                self.navigationController?.popViewController(animated: true)
            }else {
                self.profileVM.dismissIndicator()
                displayMessage(title: "", message: data.message ?? "", status: .error, forController: self)
            }
        }, onError: { (error) in
            self.profileVM.dismissIndicator()
            displayMessage(title: "", message: "Something went wrong in getting data".localized, status: .error, forController: self)
        }).disposed(by: disposeBag)
    }
}
