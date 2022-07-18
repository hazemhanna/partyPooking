//
//  BookingVC.swift
//  PartyBooking
//
//  Created by MAC on 03/09/2021.
//  Copyright © 2021 MAC. All rights reserved.
//


import UIKit
import RxSwift
import RxCocoa

class BookingVC: UIViewController {
    
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var partyTypeTextField: TextFieldDropDown!
    @IBOutlet weak var countryTextField: TextFieldDropDown!
    @IBOutlet weak var costLbl : UILabel!
    
    var partyType = [PartyPrice]()
    var filterPartyType = [String]()
    var country = [Country]()
    var filterCountry = [String]()
    var countryId :Int?
    var typeId :Int?
    var artistId :Int?
    var dateTapped = false
    var selectedDate:String?
    private let homeVM = HomeViewModel()
    var disposeBag = DisposeBag()
    var token = Helper.getAPIToken() ?? ""
    override func viewDidLoad() {
        super.viewDidLoad()
        if "lang".localized == "ar" {
            partyTypeTextField.textAlignment = .right
            countryTextField.textAlignment = .right
        }else{
            partyTypeTextField.textAlignment = .left
            countryTextField.textAlignment = .left
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE,dd,MMM"
        let result = formatter.string(from: date)
        dateLbl.text =  Helper.getdate() ?? result
        countryTextField.text =  "location".localized
        partyTypeTextField.text =  "partyType".localized
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    override func viewDidAppear(_ animated: Bool) {
        for index in self.partyType {
            if "lang".localized == "ar" {
            self.filterPartyType.append(index.arName ?? "")
            }else{
                self.filterPartyType.append(index.enName ?? "")
            }
        }
        for index in self.country{
            if "lang".localized == "ar" {
                self.filterCountry.append(index.arName ?? "")
            }else{
                self.filterCountry.append(index.enName ?? "")
            }
        }
        setupCountryDropDown()
        setupTypeDropDown()
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
            self.costLbl.text = String(self.partyType[index].partyPrice ?? 0)
            Helper.savePrice(date: Int(self.partyType[index].partyPrice ?? 0))
            Helper.savePID(date:  self.partyType[index].id ?? 0)
            if "lang".localized == "ar" {
            Helper.savePName(date: self.partyType[index].arName ?? "" )
            }else{
                Helper.savePName(date: self.partyType[index].enName ?? "" )
            }
            
        }
    }
    
    @IBAction func calenderTapped(sender: UIButton) {
        self.dateTapped = true
        let destinationVC = PartyDateVc.instantiateFromNib()
        self.navigationController?.pushViewController(destinationVC!, animated: true)
      }
    
    @IBAction func backButton(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func resevrButton(sender: UIButton) {
        if typeId == nil || countryId == nil || dateLbl.text == "" {
            if "lang".localized == "ar" {
                displayMessage(title: "", message: "من فضلك ادخل البيانات كاملة", status: .error, forController: self)
            }else{
                displayMessage(title: "", message: "please complete all data", status: .error, forController: self)
            }
         }else{
         let destinationVC = FinalBookingVC.instantiateFromNib()
             destinationVC?.artistId = self.artistId
             self.navigationController?.pushViewController(destinationVC!, animated: true)
         }
    }
}
