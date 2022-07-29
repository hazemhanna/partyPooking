//
//  ArtistWorkVc.swift
//  PartyBooking
//
//  Created by MAC on 21/09/2021.
//  Copyright © 2021 MAC. All rights reserved.
//



import UIKit
import RxSwift
import RxCocoa

class ArtistWorkVc: UIViewController  ,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var photoCollection: UICollectionView!
    
    
    let aristId = Helper.getArtistId() ?? 0
    private let profileVM = ArtistProfileViewModel()
    var disposeBag = DisposeBag()
    var work = [ArtistWork]()
    var videoUrl :Data?
    var image :UIImage?
    
   private var idintier = "ArtistWorkCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        photoCollection.register(UINib(nibName: idintier, bundle: nil), forCellWithReuseIdentifier: idintier)
        photoCollection.delegate = self
        photoCollection.dataSource = self
        profileVM.showIndicator()
        getWork(artistId : aristId)
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
    
    @IBAction func addWorkButton(sender: UIButton) {
       showImageActionSheet()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return work.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idintier, for: indexPath) as! ArtistWorkCell
        
        cell.config(imageURL: work[indexPath.row].url ?? "", videoURL: "")
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
            let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (collectionView.frame.size.width - space) / 3.2
            return CGSize(width: size, height: 100)
        }
    
}

extension ArtistWorkVc{
    func getWork(artistId : Int) {
            profileVM.getArtistWork(artistId: artistId).subscribe(onNext: { (data) in
            self.profileVM.dismissIndicator()
            if data.status ?? false {
                self.work = data.result?.data ?? []
                self.photoCollection.reloadData()
            }
        }, onError: { (error) in
            self.profileVM.dismissIndicator()
            displayMessage(title: "", message: "Something went wrong in getting data".localized, status: .error, forController: self)
        }).disposed(by: disposeBag)
     }
    
    func uploadWork(image_url : UIImage?,videoUrl: Data?) {
            profileVM.uploadWork(image_url: image_url, videoUrl: videoUrl).subscribe(onNext: { (data) in
            if data.status ?? false {
                self.getWork(artistId : self.aristId)
            }
        }, onError: { (error) in
            self.profileVM.dismissIndicator()
            displayMessage(title: "", message: "Something went wrong in getting data".localized, status: .error, forController: self)
        }).disposed(by: disposeBag)
     }
    
}


extension ArtistWorkVc: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func showImageActionSheet() {
        self.showImagePicker(sourceType: .photoLibrary)
    }
    
    func showImagePicker(sourceType: UIImagePickerController.SourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = sourceType
        imagePickerController.mediaTypes = ["public.movie","public.image"]
        imagePickerController.view.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.image = editedImage
            self.profileVM.showIndicator()
            self.uploadWork(image_url: self.image, videoUrl: nil)
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.image = originalImage
            self.profileVM.showIndicator()
            self.uploadWork(image_url: self.image, videoUrl: nil)
        }else if let videoUrl = info[UIImagePickerController.InfoKey(rawValue: UIImagePickerController.InfoKey.mediaURL.rawValue)] as? URL  {
            do{
            let data = try Data(contentsOf: videoUrl, options: .mappedIfSafe)
            self.videoUrl =  data
            self.profileVM.showIndicator()
            self.uploadWork(image_url: nil, videoUrl: self.videoUrl)
          }catch {}
        }
      dismiss(animated: true, completion: nil)
    }
}
