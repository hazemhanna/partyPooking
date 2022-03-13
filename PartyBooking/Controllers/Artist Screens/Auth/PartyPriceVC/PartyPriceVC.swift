//
//  PartyPriceVC.swift
//  PartyBooking
//
//  Created by MAC on 23/05/2021.
//  Copyright © 2021 MAC. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PartyPriceVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backButton: UIButton! {
        didSet {
            backButton.setImage(backButton.currentImage?.flipIfNeeded(), for: .normal)
        }
    }
    
    var prices : [[String:Any]] = [[:]]
    
    private let authModel = ArtistAuthenticationVM()
    var disposeBag = DisposeBag()
    var partyType = [PartyType]()

    
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
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
     authModel.showIndicator()
     getPartyType()
    }
    
    @IBAction func backButton(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func saveButton(sender: UIButton) {
    self.tableView.reloadData()
    self.navigationController?.popViewController(animated: true)
        
    }
    
    
}

extension PartyPriceVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return partyType.count
}
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PartyPriceCell", for: indexPath) as! PartyPriceCell
        if "lang".localized == "ar" {
            cell.partyName.text = self.partyType[indexPath.row].arName ?? ""
        }else{
            cell.partyName.text = self.partyType[indexPath.row].enName ?? ""
        }
        if cell.partyPRice.text != "" && cell.partyPRice.text != "" {
            self.prices.append(["party_type_id" : String(self.partyType[indexPath.row].id ?? 0), "price" : cell.partyPRice.text ?? "" , "party_time": cell.partyTime.text ?? "1", "break_time" : cell.restTime.text ?? "1"])
            Helper.savePartyPrice(id: self.prices)
        }
        return cell
    }
    
 func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(90)
    }
    
}

extension PartyPriceVC {
    func getPartyType() {
        authModel.getPartyType().subscribe(onNext: { (data) in
            if data.status ?? false {
                self.authModel.dismissIndicator()
                self.partyType = data.result ?? []
                self.tableView.reloadData()
            }
        }, onError: { (error) in
            self.authModel.dismissIndicator()
        }).disposed(by: disposeBag)
     }

}
