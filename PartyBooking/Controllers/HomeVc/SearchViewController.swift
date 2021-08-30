//
//  SearchViewController.swift
//  PartyBooking
//
//  Created by MAC on 7/2/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SearchViewController: UIViewController ,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var locationView: UIView!
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var partyView: UIView!
    @IBOutlet weak var searchBtn : UIButton!
    @IBOutlet weak var mostFamousLabel: UILabel!
    @IBOutlet weak var offerLabel: UILabel!
    @IBOutlet weak var mostFamousCollection: UICollectionView!
    @IBOutlet weak var offerCollection: UICollectionView!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var partyTypeTextField: TextFieldDropDown!
    @IBOutlet weak var countryTextField: TextFieldDropDown!

    var offers = [Offers]()
    var best = [Artists]()
    var partyType = [PartyType]()
    var filterPartyType = [String]()
    var country = [Areas]()
    var filterCountry = [String]()
    var countryId :Int?
    var typeId :Int?
    var dateTapped = false
    var selectedDate:String?
    var notification = false
    private let homeVM = HomeViewModel()
    var disposeBag = DisposeBag()
    var token = Helper.getAPIToken() ?? ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        mostFamousCollection.delegate = self
        mostFamousCollection.dataSource = self
        mostFamousCollection.register(UINib(nibName: "MostFamousCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        offerCollection.delegate = self
        offerCollection.dataSource = self
        offerCollection.register(UINib(nibName: "MostFamousCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
   
        style ()
        setUPLocalize()
        getHome()
        getPartyType()
        getAllCountry()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if dateTapped {
         dateLbl.text = Helper.getdate() ?? ""
        }else {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE,dd,MMM"
        let result = formatter.string(from: date)
        dateLbl.text = result
        }
        
      selectedDate = Helper.getdate() ?? ""
      self.navigationController?.navigationBar.isHidden = true
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func setUPLocalize(){
        searchBtn.setTitle("searchtitle".localized, for: .normal)
        mostFamousLabel.text = "Most".localized
        offerLabel.text = "Show".localized
        countryTextField.text = "location".localized
        partyTypeTextField.text = "partyType".localized
     }
    
    
    func setupCountryDropDown() {
        countryTextField.optionArray = self.filterCountry
        countryTextField.didSelect { (selectedText, index, id) in
            self.countryTextField.text = selectedText
            self.countryId = self.country[index].id ?? 0

        }
    }
    
    func setupTypeDropDown() {
        partyTypeTextField.optionArray = self.filterPartyType
        partyTypeTextField.didSelect { (selectedText, index, id) in
            self.partyTypeTextField.text = selectedText
            self.typeId = self.partyType[index].id ?? 0
        }
    }
    
     func style (){
        locationView.layer.cornerRadius = 7
        dateView.layer.cornerRadius = 7
        partyView.layer.cornerRadius = 7
        searchBtn.layer.cornerRadius = 7
      }
    
    @IBAction func viewAllTapped(sender: UIButton) {
        let destinationVC = MostFamousVc.instantiateFromNib()
        self.navigationController?.pushViewController(destinationVC!, animated: true)
    }
    
    
    @IBAction func viewAllOffers(sender: UIButton) {
        let destinationVC = OffersViewController.instantiateFromNib()
        self.navigationController?.pushViewController(destinationVC!, animated: true)
    }
    
    
    @IBAction func calenderTapped(sender: UIButton) {
        self.dateTapped = true
        let destinationVC = PartyDateVc.instantiateFromNib()
        self.navigationController?.pushViewController(destinationVC!, animated: true)
      }
    
    
    @IBAction func notificationButton(sender: UIButton) {
          let destinationVC = NotificationsViewController.instantiateFromNib()
          self.navigationController?.pushViewController(destinationVC!, animated: true)
      }
    
     @IBAction func searchButton(sender: UIButton) {
        
       if token != ""{
        if typeId == nil || countryId == nil || selectedDate == "" {
        if "lang".localized == "ar" {
            displayMessage(title: "", message: "اكمل البيانات", status: .error, forController: self)
        }else{
            displayMessage(title: "", message: "please complete all required data", status: .error, forController: self)
        }
        }else{
        let destinationVC = SearchResultViewController.instantiateFromNib()
        destinationVC!.areaId = countryId ?? 0
        destinationVC!.typeId = typeId ?? 0
        destinationVC!.date = dateLbl.text ?? ""
        self.navigationController?.pushViewController(destinationVC!, animated: true)
        }
        }else{
            if "lang".localized == "ar" {
                displayMessage(title: "", message: "من فضلك قم بتسجيل الدخول ", status: .error, forController: self)

            }else{
                displayMessage(title: "", message: "please login first", status: .error, forController: self)

            }
        }
     }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == offerCollection{
            return offers.count
        }else{
            return best.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MostFamousCollectionViewCell
        if collectionView == offerCollection {
            cell.locationImage.isHidden = true
            cell.titleLbl.isHidden = true
            cell.locationLbl.isHidden = true
            cell.confic(imageUrl: self.offers[indexPath.row].url ?? "",name: "" ,locaction: "")
        }else{
            cell.locationImage.isHidden = false
            cell.titleLbl.isHidden = false
            cell.locationLbl.isHidden = false
            cell.confic(imageUrl: self.best[indexPath.row].image ?? "", name: ((self.best[indexPath.row].firstName ?? "") + " " + (self.best[indexPath.row].lastName ?? "")), locaction: (self.best[indexPath.row].address ?? ""))

        }
        cell.layer.cornerRadius = 7
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView ==  mostFamousCollection {
        let destinationVC = ArtistProfileViewController.instantiateFromNib()
        destinationVC!.artistId = best[indexPath.row].id ?? 0
        self.navigationController?.pushViewController(destinationVC!, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 30
        let width = (collectionView.bounds.size.width - spacing) / 1.2
        let height = (collectionView.bounds.size.height)
        return CGSize(width: width, height:  height)
    }
    

    
}

extension SearchViewController {

func getHome() {
    homeVM.getHome().subscribe(onNext: { (data) in
        self.homeVM.dismissIndicator()
        if data.status ?? false {
            self.offers = data.result?.offers?.data ?? []
            self.best = data.result?.bestArtists?.data ?? []
            self.offerCollection.reloadData()
            self.mostFamousCollection.reloadData()
        }
    }, onError: { (error) in
        self.homeVM.dismissIndicator()
       // displayMessage(title: "", message: "Something went wrong in getting data", status: .error, forController: self)
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
    
    
}
