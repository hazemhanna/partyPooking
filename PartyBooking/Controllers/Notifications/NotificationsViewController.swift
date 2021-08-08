//
//  NotificationsViewController.swift
//  PartyBooking
//
//  Created by MAC on 7/5/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit

class NotificationsViewController: UIViewController {
    
    @IBOutlet weak var notificationsTableView: UITableView!
    @IBOutlet weak var backview: UIView!
    
    @IBOutlet weak var noNotificationLabel : UILabel!
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var backButton: UIButton! {
        didSet {
            backButton.setImage(backButton.currentImage?.flipIfNeeded(), for: .normal)
        }
    }
    var notification :[Int] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        notification.append(1)
        if notification.count > 0 {
            backview.isHidden = true
        }else{
            backview.isHidden = false
        }
        notificationsTableView.register(UINib(nibName: "NotificationsTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        setUPLocalize()
    }
    
    
    
    func setUPLocalize(){
        titleLabel.text = "notification".localized
        noNotificationLabel.text = "noNotification".localized
        if MOLHLanguage.currentAppleLanguage() == "en" {
                 let font = UIFont(name: "Georgia-Bold", size: 14)
                     titleLabel.font = font
                     noNotificationLabel.font = font
                 }
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

extension NotificationsViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notification.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NotificationsTableViewCell
        return cell
    }
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(80)
        
    }
}
