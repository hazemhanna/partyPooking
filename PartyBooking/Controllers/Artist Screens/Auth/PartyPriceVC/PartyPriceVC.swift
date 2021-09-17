//
//  PartyPriceVC.swift
//  PartyBooking
//
//  Created by MAC on 23/05/2021.
//  Copyright © 2021 MAC. All rights reserved.
//

import UIKit

class PartyPriceVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backButton: UIButton! {
        didSet {
            backButton.setImage(backButton.currentImage?.flipIfNeeded(), for: .normal)
        }
    }
    
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
    
    @IBAction func backButton(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func saveButton(sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
        
    }

}

extension PartyPriceVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PartyPriceCell", for: indexPath) as! PartyPriceCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(90)
    }

}
