//
//  AllLiveVideoVC.swift
//  PartyBooking
//
//  Created by MAC on 29/05/2021.
//  Copyright © 2021 MAC. All rights reserved.
//



import UIKit

class AllLiveVideoVC: UIViewController {
    
    @IBOutlet weak var liveTableView: UITableView!
    @IBOutlet weak var titleLabel : UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        liveTableView.register(UINib(nibName: "AllLiveCell", bundle: nil), forCellReuseIdentifier: "AllLiveCell")
    }
    
    func setUPLocalize(){
        titleLabel.text = "live".localized
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

extension AllLiveVideoVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllLiveCell", for: indexPath) as! AllLiveCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
}
