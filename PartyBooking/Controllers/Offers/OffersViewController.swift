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
    @IBOutlet weak var searchBtn : UIButton!
    @IBOutlet weak var partyTypeTextField: TextFieldDropDown!
    @IBOutlet weak var countryTextField: TextFieldDropDown!
    @IBOutlet weak var dateLbl: UILabel!
   
    var selectedDate:String?
    var partyType = [PartyType]()
    var country = [Areas]()
    var filterPartyType = [String]()
    var filterCountry = [String]()
    var countryId :Int?
    var typeId :Int?
    var dateTapped = false
    var token = Helper.getAPIToken() ?? ""

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
        offerTableView.register(UINib(nibName: "OffersTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")

        getPartyType()
        getAllCountry()
        style()
        setUPLocalize()
        
    }
    
    func setUPLocalize(){
        
        searchBtn.setTitle("searchtitle".localized, for: .normal)
        countryTextField.text = "location".localized
        partyTypeTextField.text = "partyType".localized
        
        if "lang".localized  == "en" {
            let font = UIFont(name: "Georgia-Bold", size: 14)
            searchBtn.titleLabel!.font = font
        }
    }
    
    func setupCountryDropDown() {
        countryTextField.optionArray = self.filterCountry
        countryTextField.didSelect { (selectedText, index, id) in
            self.countryTextField.text = selectedText
            self.countryId = self.country[index].id ?? 0
            Helper.saveCID(date:  self.country[index].id ?? 0)
            if "lang".localized == "ar" {
            Helper.saveCName(date: self.country[index].arName ?? "" )
            }else{
                Helper.saveCName(date: self.country[index].enName ?? "" )
            }
        }
    }
    
    func setupTypeDropDown() {
        partyTypeTextField.optionArray = self.filterPartyType
        partyTypeTextField.didSelect { (selectedText, index, id) in
            self.partyTypeTextField.text = selectedText
            self.typeId = self.partyType[index].id ?? 0
            Helper.savePID(date:  self.partyType[index].id ?? 0)
            if "lang".localized == "ar" {
            Helper.savePName(date: self.partyType[index].arName ?? "" )
            }else{
                Helper.savePName(date: self.partyType[index].enName ?? "" )
            }
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
        selectedDate = Helper.getdate() ?? ""
        if dateTapped {
         dateLbl.text = Helper.getdate() ?? ""
        }else {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE,dd,MMM"
        let result = formatter.string(from: date)
        dateLbl.text = result
        }
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
    
    @IBAction func calenderTapped(sender: UIButton) {
        self.dateTapped = true
        let destinationVC = PartyDateVc.instantiateFromNib()
        self.navigationController?.pushViewController(destinationVC!, animated: true)
      }
    
    
   
    
    @IBAction func searchBtn(sender: UIButton) {
        if token != ""{
         if typeId == nil || countryId == nil || selectedDate == "" {
         if "lang".localized == "ar" {
             displayMessage(title: "", message: "اكمل البيانات", status: .error, forController: self)
         }else{
             displayMessage(title: "", message: "please complete all required data", status: .error, forController: self)
         }
         }else{
            self.homeVM.showIndicator()
            getSrearchOffer(area_id: countryId ?? 0 , party_type_id: typeId ?? 0 , date: self.selectedDate ?? "")
         }
         }else{
             if "lang".localized == "ar" {
                 displayMessage(title: "", message: "من فضلك قم بتسجيل الدخول ", status: .error, forController: self)
             }else{
                 displayMessage(title: "", message: "please login first", status: .error, forController: self)

             }
         }
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
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let destinationVC = OffersDetailsVc.instantiateFromNib()
        destinationVC!.artistId = offers[indexPath.row].artistID ?? 0
        self.navigationController?.pushViewController(destinationVC!, animated: true)
            
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
            //displayMessage(title: "", message: "Something went wrong in getting data", status: .error, forController: self)
        }).disposed(by: disposeBag)
     }
    
    func getPartyType() {
        homeVM.getPartyType().subscribe(onNext: { (data) in
            if data.status ?? false {
                self.homeVM.dismissIndicator()
                self.partyType = data.result ?? []
                for index in self.partyType {
                    if "lang".localized == "ar" {
                    self.filterPartyType.append(index.arName ?? "")
                    }else{
                        self.filterPartyType.append(index.enName ?? "")

                    }
                }
                self.setupTypeDropDown()
            }
        }, onError: { (error) in
            self.homeVM.dismissIndicator()
           // displayMessage(title: "", message: "Something went wrong in getting data", status: .error, forController: self)
        }).disposed(by: disposeBag)
     }
    
    func getAllCountry() {
        homeVM.getArea().subscribe(onNext: { (data) in
            self.homeVM.dismissIndicator()
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
            self.homeVM.dismissIndicator()
           // displayMessage(title: "", message: "Something went wrong in getting data", status: .error, forController: self)
        }).disposed(by: disposeBag)
    }
    
    
    
    func getSrearchOffer(area_id:Int, party_type_id : Int,date :String) {
        homeVM.getSrearchOffer(area_id: area_id, party_type_id: party_type_id, date: date).subscribe(onNext: { (data) in
            self.homeVM.dismissIndicator()
            if data.status ?? false {
                self.offers = data.result?.data ?? []
                self.offerTableView.reloadData()
            }
        }, onError: { (error) in
            self.homeVM.dismissIndicator()

        }).disposed(by: disposeBag)
     }

}
