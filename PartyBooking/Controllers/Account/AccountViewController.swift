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


class AccountViewController: UIViewController {
    
    @IBOutlet weak var editBtn : UIButton!
    @IBOutlet weak var profilehImage : UIImageView!
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var nameLabel : UILabel!
    var token = Helper.getAPIToken() ?? ""
    private let profileVM = ProfileViewModel()
    var disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         style()
         editBtn.setTitle("chnge".localized, for: .normal)
         titleLabel.text = "myAccount".localized
        
        if "lang".localized  == "en" {
            let font = UIFont(name: "Georgia-Bold", size: 14)
            editBtn.titleLabel!.font = UIFont(name: "Georgia-Bold", size: 17)
            titleLabel.font = font
           
        }

        
    }
    func style(){
        profilehImage.layer.cornerRadius = profilehImage.frame.width / 2
        editBtn.layer.cornerRadius = 7
        editBtn.layer.borderColor = UIColor.tabBarColor.cgColor
        editBtn.layer.borderWidth = 3
        
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
    
    @IBAction func editProfileButton(sender: UIButton) {
          let destinationVC = EditProfileViewController.instantiateFromNib()
          self.navigationController?.pushViewController(destinationVC!, animated: true)
          
      }
    
    @IBAction func backButton(sender: UIButton) {
          self.navigationController?.popViewController(animated: true)
      }
    

    
}

extension AccountViewController {
func getProfile() {
    profileVM.getProfile().subscribe(onNext: { (data) in
        self.profileVM.dismissIndicator()
        if data.status ?? false {
            self.nameLabel.text =  (data.result?.user?.firstName ?? "") +  " " + (data.result?.user?.lastName ?? "")
            if let iamg = URL(string: "https://partybooking.dtagdev.com/" + (data.result?.user?.image ?? "") ){
            self.profilehImage.kf.setImage(with: iamg, placeholder: #imageLiteral(resourceName: "5"))
            }
        }
    }, onError: { (error) in
        self.profileVM.dismissIndicator()
        //displayMessage(title: "", message: "Something went wrong in getting data", status: .error, forController: self)
    }).disposed(by: disposeBag)
 }
    
    func chagePhoto(image : UIImage) {
        profileVM.changePhoto(image: image).subscribe(onNext: { (data) in
            self.profileVM.dismissIndicator()
            if data.status ?? false {
               // displayMessage(title: "", message: data.message ?? "", status: .success, forController: self)
            }
        }, onError: { (error) in
            self.profileVM.dismissIndicator()
           // displayMessage(title: "", message: "Something went wrong in getting data", status: .error, forController: self)
        }).disposed(by: disposeBag)
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
