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
    @IBOutlet weak var photoCollectionHeight : NSLayoutConstraint!
    @IBOutlet weak var commentTableView: UITableView!
    @IBOutlet weak var profileImage : UIImageView!
    @IBOutlet weak var profileView : UIView!
    @IBOutlet weak var reserveBtn : UIButton!
    @IBOutlet weak var amountLabel : UILabel!
    @IBOutlet weak var amountValueLabel : UILabel!
    @IBOutlet weak var taxesLabel : UILabel!
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var commentLabel : UILabel!
    @IBOutlet weak var likeBtn : UIButton!
    @IBOutlet weak var rateLabel : UILabel!
    @IBOutlet weak var addressLabel : UILabel!
    @IBOutlet weak var descreptionTV : UILabel!
    @IBOutlet weak var depositLbl  : UILabel!

    
    var token = Helper.getAPIToken() ?? ""
    
    @IBOutlet weak var backButton: UIButton! {
           didSet {
               backButton.setImage(backButton.currentImage?.flipIfNeeded(), for: .normal)
           }
       }
    
    private let homeVM = HomeViewModel()
    var disposeBag = DisposeBag()
    var comments = [Comment]()
    var work = [ArtistWork]()
    
    var partyPrice = [PartyPrice]()
    var country = [Country]()
    var search = false
    var isFavourite = Int()
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
        taxesLabel.text = "\("taxes".localized) 450 " + "SR".localized
        depositLbl.text = "\("deposite".localized) 450 " + "SR".localized
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
        getWork(artistId : artistId)
    }

    @IBAction func shareButton(sender: UIButton) {
        // text to share
        let text = "https://partybooking.dtagdev.com/"
        // set up activity view controller
        let textToShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        // exclude some activity types from the list (optional)
      activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }
   
    
    @IBAction func likeButton(sender: UIButton) {
        if token != ""{
        homeVM.showIndicator()
        if isFavourite == 0 {
            self.isFavourite = 1
            self.likeBtn.setImage(UIImage(named:"heart (2).png"), for: .normal)
        }else{
            self.isFavourite = 0
            self.likeBtn.setImage( UIImage(named:"heart"), for: .normal)
        }
      addFavourite(artistId: self.artistId)
    }else{
        if "lang".localized == "ar" {
            displayMessage(title: "", message: "من فضلك قم بتسجيل الدخول ", status: .error, forController: self)
        }else{
            displayMessage(title: "", message: "please login first", status: .error, forController: self)

        }
       }
    }
    
    @IBAction func backButton(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
   
    @IBAction func reservation(sender: UIButton) {
            if search {
                    let destinationVC = FinalBookingVC.instantiateFromNib()
                     destinationVC?.artistId = self.artistId 
                    self.navigationController?.pushViewController(destinationVC!, animated: true)
            }else{
                let destinationVC = BookingVC.instantiateFromNib()
                destinationVC?.artistId = self.artistId
                destinationVC?.partyType = self.partyPrice
                destinationVC?.country = self.country
                self.navigationController?.pushViewController(destinationVC!, animated: true)
        }
     }
  }


extension ArtistProfileViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return work.count
   }
   
 func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PhotoCollectionViewCell
      cell.confic(image : work[indexPath.row].artistImage ?? "")
       return cell
   }
       
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let schemeUrl = NSURL(string: work[indexPath.row].url ?? "")!
        if UIApplication.shared.canOpenURL(schemeUrl as URL) {
            UIApplication.shared.open(schemeUrl as URL, options: [:], completionHandler: nil)
        }
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
        cell.confic(name: (comments[indexPath.row].user?.firstName ?? "") + "" + (comments[indexPath.row].user?.lastName ?? "") , image: (comments[indexPath.row].user?.image ?? ""), comment: (comments[indexPath.row].comment ?? ""))
         return cell
}
    
 
func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return CGFloat(50)
 
 }
    
}

extension ArtistProfileViewController {
    
    func addFavourite(artistId : Int ) {
        homeVM.addFavourite(artistId: artistId).subscribe(onNext: { (data) in
            self.homeVM.dismissIndicator()
            if data.status ?? false {
                //displayMessage(title: "", message: data.message ?? "", status: .success, forController: self)
            }
        }, onError: { (error) in
            self.homeVM.dismissIndicator()
            displayMessage(title: "", message: "Something went wrong in getting data".localized, status: .error, forController: self)
        }).disposed(by: disposeBag)
     }
    
    func getProfile(artistId : Int) {
    homeVM.getArtistDetails(artistId: artistId).subscribe(onNext: { (data) in
        self.homeVM.dismissIndicator()
        if data.status ?? false {
            self.comments = data.result?.comments ?? []
            self.partyPrice = data.result?.partyPrices ?? []
            self.country = data.result?.areas ?? []
            self.commentTableView.reloadData()
            self.rateLabel.text = "\(data.result?.rate ?? 0)"
            self.amountValueLabel.text = String(data.result?.partyPrice ?? 0 ) + " " + "SR".localized
            Helper.savePrice(date: Int(data.result?.partyPrice ?? 0 ))

            if "lang".localized == "ar" {
                self.addressLabel.text = data.result?.country?.arName ?? ""
            }else{
                self.addressLabel.text = data.result?.country?.enName ?? ""
            }
            self.descreptionTV.text = data.result?.resultDescription ?? ""
            self.isFavourite = data.result?.favourite ?? 0

            if data.result?.favourite == 0 {
                self.isFavourite = 0
                self.likeBtn.setImage( UIImage(named:"heart"), for: .normal)
            }else{
                self.isFavourite = 1
                self.likeBtn.setImage(UIImage(named:"heart (2).png"), for: .normal)
            }
            if let iamg = URL(string: "https://partybooking.dtagdev.com/" + (data.result?.image ?? "")){
            self.profileImage.kf.setImage(with: iamg, placeholder: #imageLiteral(resourceName: "يريءؤر سيرلايسب-1"))
            }
        }
    }, onError: { (error) in
        self.homeVM.dismissIndicator()
        displayMessage(title: "", message: "Something went wrong in getting data".localized, status: .error, forController: self)
    }).disposed(by: disposeBag)
 }


    func getWork(artistId : Int) {
    homeVM.getArtistWork(artistId: artistId).subscribe(onNext: { (data) in
        self.homeVM.dismissIndicator()
        if data.status ?? false {
            self.work = data.result?.data ?? []
            self.photoCollection.reloadData()
            if self.work.count > 0 {
                self.photoCollectionHeight.constant = 100
            }else{
                self.photoCollectionHeight.constant = 0
            }
        }
    }, onError: { (error) in
        self.homeVM.dismissIndicator()
        displayMessage(title: "", message: "Something went wrong in getting data".localized, status: .error, forController: self)
    }).disposed(by: disposeBag)
 }
    
}
