//
//  RateViewController.swift
//  PartyBooking
//
//  Created by MAC on 7/6/20.
//  Copyright © 2020 MAC. All rights reserved.
//



import UIKit
import RxSwift
import RxCocoa

class RateViewController: UIViewController {
    
    @IBOutlet weak var rateTableView: UITableView!
    
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var backButton: UIButton! {
        didSet {
            backButton.setImage(backButton.currentImage?.flipIfNeeded(), for: .normal)
        }
    }
    
    
    private let authModel = ArtistAuthenticationVM()
    var disposeBag = DisposeBag()

    var review = [ArtistReview]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rateTableView.register(UINib(nibName: "RateTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        setUPLocalize()
        authModel.showIndicator()
        getReview()
    }
    
    
    func setUPLocalize(){
          titleLabel.text = "exprience".localized
      }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        
    }
    
    @IBAction func backButton(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}


extension RateViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return review.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RateTableViewCell
        
        cell.nameLbl.text = (self.review[indexPath.row].user?.firstName ?? "") + " " + (self.review[indexPath.row].user?.lastName ?? "")
        
        if let iamg = URL(string: "https://partybooking.dtagdev.com/" + (self.review[indexPath.row].user?.image ?? "")){
        cell.imageProfile.kf.setImage(with: iamg, placeholder: #imageLiteral(resourceName: "يريءؤر سيرلايسب-1"))
        }
        
        cell.commentLbl.text = self.review[indexPath.row].comment ?? ""
        cell.rateView.rating = Double(self.review[indexPath.row].rate ?? 0)

        return cell
    }
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(100)
        
    }
}

extension RateViewController {
  
    func getReview() {
        authModel.getReview().subscribe(onNext: { (data) in
            if data.status ?? false {
                self.authModel.dismissIndicator()
                self.review = data.result?.data ?? []
                self.rateTableView.reloadData()
            }
        }, onError: { (error) in
            self.authModel.dismissIndicator()
        }).disposed(by: disposeBag)
     }
    
}
