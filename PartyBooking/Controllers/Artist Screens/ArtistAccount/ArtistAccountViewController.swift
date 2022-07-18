//
//  ArtistAccountViewController.swift
//  PartyBooking
//
//  Created by MAC on 7/8/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ArtistAccountViewController: UIViewController  ,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var photoCollection: UICollectionView!
    @IBOutlet weak var photoCollectionHeigh: NSLayoutConstraint!
    @IBOutlet weak var profileImage : UIImageView!
    @IBOutlet weak var profileView : UIView!
    @IBOutlet weak var nameLBl : UILabel!
    @IBOutlet weak var aboutMeLabel : UILabel!
    @IBOutlet weak var myWorkLabel : UILabel!
    @IBOutlet weak var clientPriceLabel : UILabel!
    @IBOutlet weak var liveLabel : UILabel!
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var aboutTextView : UILabel!

    
    let aristId = Helper.getArtistId() ?? 0
    private let profileVM = ArtistProfileViewModel()
    var disposeBag = DisposeBag()
    var work = [ArtistWork]()
    var partPice = [PartPice]()
    override func viewDidLoad() {
        super.viewDidLoad()
        photoCollection.register(UINib(nibName: "PhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        profileView.layer.cornerRadius = profileView.frame.width / 2
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
        setUPLocalize()
    }
    
    func setUPLocalize(){
        titleLabel.text = "profile".localized
        aboutMeLabel.text = "aboutMe".localized
        myWorkLabel.text = "myWork".localized
        clientPriceLabel.text = "clientPrice".localized
        liveLabel.text = "live".localized

    }
    
    override func viewWillAppear(_ animated: Bool) {
        profileVM.showIndicator()
        getProfile()
        getWork(artistId: aristId)
    self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
    self.navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func backButton(sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func liveButton(sender: UIButton) {
    let destinationVC = LiveVideoViewController.instantiateFromNib()
    self.navigationController?.pushViewController(destinationVC!, animated: true)
    }
    
    @IBAction func editDescription(sender: UIButton) {
    let destinationVC = EditDescriptionVc.instantiateFromNib()
    self.navigationController?.pushViewController(destinationVC!, animated: true)
    }
    
    @IBAction func addWorkBtn (sender: UIButton) {
        let destinationVC = ArtistWorkVc.instantiateFromNib()
        self.navigationController?.pushViewController(destinationVC!, animated: true)
    }
    
    @IBAction func addPriceBtn (sender: UIButton) {
        let destinationVC = UpdatePricesVC.instantiateFromNib()
        destinationVC?.partPice = self.partPice
        self.navigationController?.pushViewController(destinationVC!, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return work.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PhotoCollectionViewCell
        cell.confic(image : work[indexPath.row].artistImage ?? "")
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 20
        let width = (collectionView.bounds.size.width - spacing) / 3
        let height = (collectionView.bounds.size.height)
        return CGSize(width: width, height:  height)
    }
    
}

extension ArtistAccountViewController{
    
    func getProfile() {
        profileVM.getProfile().subscribe(onNext: { (data) in
        self.profileVM.dismissIndicator()
        if data.status ?? false {
            self.nameLBl.text = (data.result?.artist?.firstName ?? "")  +  " " + (data.result?.artist?.lastName ?? "")
            self.aboutTextView.text = data.result?.artist?.artistDescription ?? ""
            self.partPice = data.result?.artist?.partPices ?? []
            if let iamg = URL(string: "https://partybooking.dtagdev.com/" + (data.result?.artist?.image ?? "")){
            self.profileImage.kf.setImage(with: iamg, placeholder: #imageLiteral(resourceName: "يريءؤر سيرلايسب-1"))
            }
        }
    }, onError: { (error) in
        self.profileVM.dismissIndicator()

    }).disposed(by: disposeBag)
 }


    func getWork(artistId : Int) {
        profileVM.getArtistWork(artistId: artistId).subscribe(onNext: { (data) in
        self.profileVM.dismissIndicator()
        if data.status ?? false {
            self.work = data.result?.data ?? []
            if self.work.count > 0 {
                self.photoCollectionHeigh.constant = 150
            }else{
                self.photoCollectionHeigh.constant = 0
            }
            
            self.photoCollection.reloadData()
        }
    }, onError: { (error) in
        self.profileVM.dismissIndicator()
        displayMessage(title: "", message: "Something went wrong in getting data".localized, status: .error, forController: self)
    }).disposed(by: disposeBag)
 }
    
    func chagePhoto(image : UIImage) {
        profileVM.changePhoto(image: image).subscribe(onNext: { (data) in
            self.profileVM.dismissIndicator()
            if data.status ?? false {
            }
        }, onError: { (error) in
            self.profileVM.dismissIndicator()

        }).disposed(by: disposeBag)
     }
    
    

}
extension ArtistAccountViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
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
            self.profileImage.image =  editedImage
            self.chagePhoto(image: editedImage)
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.profileImage.image =  originalImage
            self.chagePhoto(image: originalImage)
        }
        dismiss(animated: true, completion: nil)
    }
    
}
