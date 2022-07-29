//
//  OffersDetailsVc.swift
//  PartyBooking
//
//  Created by MAC on 01/09/2021.
//  Copyright © 2021 MAC. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class OffersDetailsVc : UIViewController {
    @IBOutlet weak var artitstName :UILabel!
    @IBOutlet weak var partyLocation :UILabel!
    @IBOutlet weak var partyType :UILabel!
    @IBOutlet weak var PartyTime :UILabel!
    @IBOutlet weak var PartyPrice :UILabel!
    @IBOutlet weak var offerImage :UIImageView!
    @IBOutlet weak var reserveBtn  :UIButton!
    
    var dateTapped = false
    var from = String()
    var to = String()
    var token = Helper.getAPIToken() ?? ""
    private let homeVM = HomeViewModel()
    var disposeBag = DisposeBag()
    var artistId = Int()
    var typeId = Int()
    override func viewDidLoad() {
        super.viewDidLoad()
        reserveBtn.setTitle("reserve Now".localized, for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.homeVM.showIndicator()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getOffers(artistId:artistId, typeId: typeId)
    }
    
    @IBAction func backButton(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func resrvationBtn(sender: UIButton){
        if dateTapped {
          let destinationVC = FinalBookingVC.instantiateFromNib()
         destinationVC!.artistId = artistId
         self.navigationController?.pushViewController(destinationVC!, animated: true)
        }else{
            if "lang".localized == "ar" {
                displayMessage(title: "", message: "من فضلك قم باختيار تايخ الحفلة ", status: .error, forController: self)
            }else{
                displayMessage(title: "", message: "please choose part date ", status: .error, forController: self)
            }
        }
    }
    
    @IBAction func artistBtn(sender: UIButton){
       let destinationVC = ArtistProfileViewController.instantiateFromNib()
       destinationVC!.artistId = artistId
       self.navigationController?.pushViewController(destinationVC!, animated: true)
    }
    
    
    @IBAction func calenderTapped(sender: UIButton) {
        self.dateTapped = true
        let destinationVC = PartyDateVc.instantiateFromNib()
        destinationVC?.from = self.from
        destinationVC?.to =  self.to
        destinationVC?.offer = true
        self.navigationController?.pushViewController(destinationVC!, animated: true)
      }
}

extension OffersDetailsVc {
    func getOffers(artistId:Int,typeId:Int) {
        homeVM.getOfferDetails(artistId: artistId,typeId:typeId).subscribe(onNext: { (data) in
            self.homeVM.dismissIndicator()
            if data.status ?? false {
                self.artitstName.text = data.result?.artistName ?? ""
                if "lang".localized == "ar" {
                    self.partyType.text = data.result?.arParty ?? ""
                    self.partyLocation.text = data.result?.arArea ?? ""
                }else{
                    self.partyType.text = data.result?.enParty  ?? ""
                    self.partyLocation.text = data.result?.enArea ?? ""
                }
                self.PartyTime.text = data.result?.to ?? ""
                self.PartyPrice.text =  String(data.result?.offerValue ?? 0)
                self.from = data.result?.from ?? ""
                self.to = data.result?.to ?? ""
                
                if let iamg = URL(string: "https://partybooking.dtagdev.com/" + (data.result?.url ?? "")){
                    self.offerImage.kf.setImage(with: iamg, placeholder: #imageLiteral(resourceName: "يريءؤر سيرلايسب"))
                }
                Helper.savePrice(date: data.result?.offerValue  ?? 0 )
                Helper.savePID(date:   data.result?.partyTypeID ?? 0 )
            }
        }, onError: { (error) in
            self.homeVM.dismissIndicator()
            displayMessage(title: "", message: "Something went wrong in getting data".localized, status: .error, forController: self)
        }).disposed(by: disposeBag)
     }
    
}
