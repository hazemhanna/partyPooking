//
//  ReservationViewController.swift
//  PartyBooking
//
//  Created by MAC on 7/2/20.
//  Copyright © 2020 MAC. All rights reserved.
//



import UIKit
let CellHeight = 80

class ReservationViewController: UIViewController {
    
    @IBOutlet weak var currentReservationTableViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var currentReservationTableView: UITableView!
    @IBOutlet weak var endedReservationTableView: UITableView!
    @IBOutlet weak var currentLabel : UILabel!
    @IBOutlet weak var endedLabel : UILabel!
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var blackView : UIView!
    @IBOutlet weak var rateView : UIView!
    @IBOutlet weak var rateArtistLabel : UILabel!
    
    var products: [Int] = [1,3,4] {
        didSet {
            if products.count > 0{
                let dynamicTableHeight = products.count * CellHeight
                currentReservationTableViewConstraint.constant = CGFloat(dynamicTableHeight)
            }else{
                currentReservationTableViewConstraint.constant = 73
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentReservationTableView.register(UINib(nibName: "ReservationTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        endedReservationTableView.register(UINib(nibName: "ReservationTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        setUPLocalize()
       // let hideView = UITapGestureRecognizer(target: self, action:#selector(RegisterViewController.blackViewTapped(sender:)))
        //  blackView.addGestureRecognizer(hideView)
        // blackView.isUserInteractionEnabled = true
        rateView.layer.cornerRadius = 10
    }
    
    @objc func blackViewTapped(sender: UITapGestureRecognizer) {
          blackView.isHidden = true
          rateView.isHidden = true
      }
    
    func setUPLocalize(){
        rateArtistLabel.text = "rateArtist".localized
        titleLabel.text = "myReservation".localized
        currentLabel.text = "current".localized
        endedLabel.text = "ended".localized
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

extension ReservationViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == currentReservationTableView{
            return 1
        }else {
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ReservationTableViewCell
        cell.delegete = self
        return cell
    }
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(CellHeight)
        
    }
}
