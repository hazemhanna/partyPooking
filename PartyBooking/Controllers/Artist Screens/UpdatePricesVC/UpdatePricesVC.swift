//
//  UpdatePricesVC.swift
//  PartyBooking
//
//  Created by MAC on 21/09/2021.
//  Copyright © 2021 MAC. All rights reserved.
//


import UIKit
import RxSwift
import RxCocoa

class UpdatePricesVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backButton: UIButton! {
        didSet {
            backButton.setImage(backButton.currentImage?.flipIfNeeded(), for: .normal)
        }
    }
    
    var updatedPrices : [[String:Any]] = [[:]]
    var prices : [String:Any] = [:]
    

    private let authModel = ArtistAuthenticationVM()
    var disposeBag = DisposeBag()

    var partPice = [PartPice]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "PartyPriceCell", bundle: nil), forCellReuseIdentifier: "PartyPriceCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tableView.reloadData()
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
       tableView.reloadData()
    }
    
    @IBAction func backButton(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func saveButton(sender: UIButton) {
         authModel.showIndicator()
         self.updatePrices(prices: updatedPrices)
         self.navigationController?.popViewController(animated: true)
    }

}

extension UpdatePricesVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return partPice.count
   }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PartyPriceCell", for: indexPath) as! PartyPriceCell
            
        if "lang".localized == "ar" {
                cell.partyName.text = self.partPice[indexPath.row].arName ?? ""
            }else{
                cell.partyName.text = self.partPice[indexPath.row].enName ?? ""
            }
            cell.restTime.text = String(self.partPice[indexPath.row].pivot?.breakTime ?? 0)
            cell.partyPRice.text = String(self.partPice[indexPath.row].pivot?.price ?? 0)
            cell.partyTime.text = String(self.partPice[indexPath.row].pivot?.partyTime ?? 0)
            
        cell.updatePartyPrice = {
            self.prices["price"] = cell.partyPRice.text ?? ""
            self.prices["party_type_id"] = self.partPice[indexPath.row].id ?? 0
            self.prices["party_time"] = cell.partyTime.text ?? "1"
            self.prices["break_time"] = cell.restTime.text ?? "1"
            self.updatedPrices.append(self.prices)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(90)
    }

}

extension UpdatePricesVC {
  
    func updatePrices(prices: [[String : Any]]) {
        authModel.updatePrice(prices: prices).subscribe(onNext: { (data) in
            if data.status ?? false {
                self.authModel.dismissIndicator()
                self.tableView.reloadData()
           
            }
        }, onError: { (error) in
            self.authModel.dismissIndicator()
        }).disposed(by: disposeBag)
     }
    
}
