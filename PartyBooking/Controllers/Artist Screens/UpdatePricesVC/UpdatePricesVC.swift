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
    
    var index = -1

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
    }

}

extension UpdatePricesVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return partPice.count
   }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PartyPriceCell", for: indexPath) as! PartyPriceCell
        cell.price = partPice[indexPath.row]
        cell.index = indexPath.row
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(90)
    }

}

extension UpdatePricesVC :PartyPriceCellDelegate{
  
    func partyPriceCell(_ cell: PartyPriceCell, didChangeModel at: Int,prices :PartPice){
        self.index = at
        self.updatedPrices.removeAll()
        self.prices["price"] = cell.partyPRice.text ?? ""
        self.prices["party_type_id"] = prices.id ?? 0
        self.prices["party_time"] = cell.partyTime.text ?? "1"
        self.prices["break_time"] = cell.restTime.text ?? "1"
        self.updatedPrices.insert(self.prices, at: index)
   }
    
    func updatePrices(prices: [[String : Any]]) {
        authModel.updatePrice(prices: prices).subscribe(onNext: { (data) in
            self.authModel.dismissIndicator()
            if data.status ?? false {
                self.authModel.dismissIndicator()
                self.navigationController?.popViewController(animated: true)
            }
        }, onError: { (error) in
            self.authModel.dismissIndicator()
        }).disposed(by: disposeBag)
     }
    
    
    
}
