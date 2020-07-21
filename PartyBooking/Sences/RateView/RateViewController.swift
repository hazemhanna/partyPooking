//
//  RateViewController.swift
//  PartyBooking
//
//  Created by MAC on 7/6/20.
//  Copyright © 2020 MAC. All rights reserved.
//



import UIKit


class RateViewController: UIViewController {
    
    @IBOutlet weak var rateTableView: UITableView!
    
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var backButton: UIButton! {
        didSet {
            backButton.setImage(backButton.currentImage?.flipIfNeeded(), for: .normal)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        rateTableView.register(UINib(nibName: "RateTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        setUPLocalize()
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
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RateTableViewCell
        return cell
    }
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(60)
        
    }
}
