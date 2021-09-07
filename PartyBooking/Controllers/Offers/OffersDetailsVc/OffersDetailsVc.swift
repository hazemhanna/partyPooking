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
        getOffers(artistId:artistId)
    }
    
    @IBAction func backButton(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func resrvationBtn(sender: UIButton){
       let destinationVC = FinalBookingVC.instantiateFromNib()
       destinationVC!.artistId = artistId
       self.navigationController?.pushViewController(destinationVC!, animated: true)  
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
    func getOffers(artistId:Int) {
        homeVM.getOfferDetails(artistId: artistId).subscribe(onNext: { (data) in
            self.homeVM.dismissIndicator()
            if data.status ?? false {
                self.artitstName.text = data.result?.artistName ?? ""
                self.partyLocation.text = data.result?.title ?? ""
                self.partyType.text = data.result?.title ?? ""
                self.PartyTime.text = data.result?.to ?? ""
                self.PartyPrice.text =  "20" //data.result?.artistName ?? ""
                
                self.from = data.result?.from ?? ""
                self.to = data.result?.to ?? ""
                
                if let iamg = URL(string: "https://partybooking.dtagdev.com/" + (data.result?.url ?? "")){
                    self.offerImage.kf.setImage(with: iamg, placeholder: #imageLiteral(resourceName: "يريءؤر سيرلايسب"))
                }
                 Helper.saveCID(date: 58 )
                Helper.savePrice(date: 20)
               Helper.savePID(date:  2)
            }
        }, onError: { (error) in
            self.homeVM.dismissIndicator()
            //displayMessage(title: "", message: "Something went wrong in getting data", status: .error, forController: self)
        }).disposed(by: disposeBag)
     }
    
}
