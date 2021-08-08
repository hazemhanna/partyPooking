//
//  OffersViewController.swift
//  PartyBooking
//
//  Created by MAC on 7/5/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class OffersViewController: UIViewController {
    
    @IBOutlet weak var locationImage : UIImageView!
    @IBOutlet weak var calendeImage : UIImageView!
    @IBOutlet weak var partyImage : UIImageView!
    @IBOutlet weak var locationView : UIView!
    @IBOutlet weak var calendeview : UIView!
    @IBOutlet weak var partyView : UIView!
    @IBOutlet weak var offerTableView : UITableView!
    @IBOutlet weak var locatioLabel: UILabel!
    @IBOutlet weak var partytypeLabel: UILabel!
    @IBOutlet weak var searchBtn : UIButton!
    @IBOutlet weak var backButton: UIButton! {
             didSet {
                 backButton.setImage(backButton.currentImage?.flipIfNeeded(), for: .normal)
             }
         }

    
    
    private let homeVM = HomeViewModel()
    var disposeBag = DisposeBag()
    var offers = [Offers]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        offerTableView.register(UINib(nibName: "OffersTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        setUPLocalize()
        
    }
    
    func setUPLocalize(){
           searchBtn.setTitle("searchtitle".localized, for: .normal)
           locatioLabel.text = "location".localized
           partytypeLabel.text = "partyType".localized
        
        if MOLHLanguage.currentAppleLanguage() == "en" {
            let font = UIFont(name: "Georgia-Bold", size: 14)
            searchBtn.titleLabel!.font = font
            locatioLabel.font = font
            partytypeLabel.font = font

              }
        
            
        }
    
    func style(){
        searchBtn.layer.cornerRadius = 7
        locationImage.image = UIImage(named: "place")?.withRenderingMode(.alwaysTemplate)
        locationImage.tintColor =  UIColor.navigationColor
        locationView.layer.borderColor =  UIColor.navigationColor.cgColor
        locationView.layer.borderWidth = 2
        locationView.layer.cornerRadius = 7
        
        calendeImage.image = UIImage(named: "calendar (1)")?.withRenderingMode(.alwaysTemplate)
        calendeImage.tintColor =  UIColor.navigationColor
        calendeview.layer.borderColor =  UIColor.navigationColor.cgColor
        calendeview.layer.borderWidth = 2
        calendeview.layer.cornerRadius = 7
       
        partyImage.image = UIImage(named: "party")?.withRenderingMode(.alwaysTemplate)
        partyImage.tintColor =  UIColor.navigationColor
        partyView.layer.borderColor =  UIColor.navigationColor.cgColor
        partyView.layer.borderWidth = 2
        partyView.layer.cornerRadius = 7

        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.homeVM.showIndicator()
        getOffers()
          self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true


        }
        override func viewWillDisappear(_ animated: Bool) {
            self.navigationController?.navigationBar.isHidden = false
            self.tabBarController?.tabBar.isHidden = false

        }

    
       @IBAction func backButton(sender: UIButton) {
             self.navigationController?.popViewController(animated: true)
         }
    
}


extension OffersViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return offers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! OffersTableViewCell
        cell.confic(title: self.offers[indexPath.row].title ?? "" , image : self.offers[indexPath.row].url ?? "" , desc : self.offers[indexPath.row].datumDescription ?? "")
            return cell
        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return CGFloat(170)
    }
}

extension OffersViewController {
    
    func getOffers() {
        homeVM.getOffers().subscribe(onNext: { (data) in
            self.homeVM.dismissIndicator()
            if data.status ?? false {
                self.offers = data.result?.data ?? []
                self.offerTableView.reloadData()
            }
        }, onError: { (error) in
            self.homeVM.dismissIndicator()
            displayMessage(title: "", message: "Something went wrong in getting data", status: .error, forController: self)
        }).disposed(by: disposeBag)
     }
    
}
