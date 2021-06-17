//
//  ArtistProfileViewController.swift
//  PartyBooking
//
//  Created by MAC on 7/6/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ArtistProfileViewController: UIViewController{
    
    @IBOutlet weak var photoCollection: UICollectionView!
    @IBOutlet weak var commentTableView: UITableView!
    @IBOutlet weak var profileImage : UIImageView!
    @IBOutlet weak var profileView : UIView!
    @IBOutlet weak var reserveBtn : UIButton!
    @IBOutlet weak var amountLabel : UILabel!
    @IBOutlet weak var amountValueLabel : UILabel!
    @IBOutlet weak var taxesLabel : UILabel!
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var commentLabel : UILabel!

    @IBOutlet weak var rateLabel : UILabel!
    @IBOutlet weak var addressLabel : UILabel!
    @IBOutlet weak var descreptionTV : UITextView!

    
    @IBOutlet weak var backButton: UIButton! {
           didSet {
               backButton.setImage(backButton.currentImage?.flipIfNeeded(), for: .normal)
           }
       }
    

    private let homeVM = HomeViewModel()
    var disposeBag = DisposeBag()
    var comments = [Comment]()
    var artistId = Int()
    override func viewDidLoad() {
        super.viewDidLoad()

        photoCollection.delegate = self
        photoCollection.dataSource = self
        photoCollection.register(UINib(nibName: "PhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        
        commentTableView.register(UINib(nibName: "CommentsTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        profileView.layer.cornerRadius = profileView.frame.width / 2
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
        
        profileView.layer.borderColor = UIColor.navigationColor.cgColor
        profileView.layer.borderWidth = 3
        reserveBtn.layer.cornerRadius = 7
        setUPLocalize()
        
    }

    func setUPLocalize(){
        titleLabel.text = "profile".localized
         commentLabel.text = "comments".localized
        reserveBtn.setTitle("reserve".localized, for: .normal)
        amountLabel.text = "amount".localized
        taxesLabel.text = "\("taxes".localized) + SR 450"
        if MOLHLanguage.currentAppleLanguage() == "en" {
        let font = UIFont(name: "Georgia-Bold", size: 14)
            titleLabel.font = font
            commentLabel.font = font
            reserveBtn.titleLabel!.font = font
            amountLabel.font = font
            taxesLabel.font = font
        }
     }
  
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false

    }
    
    override func viewDidAppear(_ animated: Bool) {
        homeVM.showIndicator()
        getProfile(artistId: artistId)
    }

    @IBAction func backButton(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}


extension ArtistProfileViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
 

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return 3
   }
   
 func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PhotoCollectionViewCell
       return cell
   }
   
   
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       let spacing: CGFloat = 20
       let width = (collectionView.bounds.size.width - spacing) / 3
       let height = (collectionView.bounds.size.height)
       return CGSize(width: width, height:  height)
   }

}

extension ArtistProfileViewController : UITableViewDelegate , UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return comments.count
 }
 

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CommentsTableViewCell
         return cell
}
    
 
func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return CGFloat(50)
 
 }
    
}

extension ArtistProfileViewController {

    func getProfile(artistId : Int) {
    homeVM.getArtistDetails(artistId: artistId).subscribe(onNext: { (data) in
        self.homeVM.dismissIndicator()
        if data.status ?? false {
            self.comments = data.result?.comments ?? []
            self.commentTableView.reloadData()
            self.rateLabel.text = "\(data.result?.rate ?? 0)"
            self.addressLabel.text = data.result?.address ?? ""
            self.descreptionTV.text = data.result?.resultDescription ?? ""
            self.amountValueLabel.text = "89.000 SR"
            if let iamg = URL(string: "https://partybooking.dtagdev.com/" + (data.result?.image ?? "")){
            self.profileImage.kf.setImage(with: iamg, placeholder: #imageLiteral(resourceName: "يريءؤر سيرلايسب-1"))
            }
        }
    }, onError: { (error) in
        self.homeVM.dismissIndicator()
        displayMessage(title: "", message: "Something went wrong in getting data", status: .error, forController: self)
    }).disposed(by: disposeBag)
 }
}
