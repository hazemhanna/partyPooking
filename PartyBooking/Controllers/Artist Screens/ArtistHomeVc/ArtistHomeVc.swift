//
//  ArtistHomeVc.swift
//  PartyBooking
//
//  Created by MAC on 23/05/2021.
//  Copyright © 2021 MAC. All rights reserved.
//


import UIKit
import RxSwift
import RxCocoa

class ArtistHomeVc: UIViewController  ,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var photoCollection: UICollectionView!
    @IBOutlet weak var photoCollectionHeigh: NSLayoutConstraint!
    @IBOutlet weak var profileImage : UIImageView!
    @IBOutlet weak var profileView : UIView!
    @IBOutlet weak var nameLBl : UILabel!
    @IBOutlet weak var aboutMeLabel : UILabel!
    @IBOutlet weak var aboutTextView : UILabel!
    @IBOutlet weak var myWorkLabel : UILabel!
    @IBOutlet weak var liveLabel : UILabel!
   // @IBOutlet weak var titleLabel : UILabel!
    
    let aristId = Helper.getArtistId() ?? 0
    private let profileVM = ArtistProfileViewModel()
    var disposeBag = DisposeBag()
   
    var work = [ArtistWork]()
    override func viewDidLoad() {
        super.viewDidLoad()
        photoCollection.register(UINib(nibName: "PhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        profileView.layer.cornerRadius = profileView.frame.width / 2
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
        setUPLocalize()
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
    
    func setUPLocalize(){
        aboutMeLabel.text = "aboutMe".localized
        myWorkLabel.text = "myWork".localized
        liveLabel.text = "live".localized
       // titleLabel.text = "profile".localized
    }
    
    @IBAction func backButton(sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func liveButton(sender: UIButton) {
 
        let destinationVC = LiveVideoViewController.instantiateFromNib()
         self.navigationController?.pushViewController(destinationVC!, animated: true)
    }
    
    @IBAction func notificationButton(sender: UIButton) {
          let destinationVC = NotificationsViewController.instantiateFromNib()
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

extension ArtistHomeVc{
    func getProfile() {
        profileVM.getProfile().subscribe(onNext: { (data) in
        self.profileVM.dismissIndicator()
        if data.status ?? false {
            self.nameLBl.text = (data.result?.artist?.firstName ?? "")  +  " " + (data.result?.artist?.lastName ?? "")
            self.aboutTextView.text = data.result?.artist?.artistDescription ?? ""
            if let iamg = URL(string: "https://partybooking.dtagdev.com/" + (data.result?.artist?.image ?? "")){
            self.profileImage.kf.setImage(with: iamg, placeholder: #imageLiteral(resourceName: "يريءؤر سيرلايسب-1"))
            }
        }
    }, onError: { (error) in
        self.profileVM.dismissIndicator()
        displayMessage(title: "", message: "Something went wrong in getting data".localized, status: .error, forController: self)
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
    
}
