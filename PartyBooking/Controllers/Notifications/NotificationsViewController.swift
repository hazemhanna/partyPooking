//
//  NotificationsViewController.swift
//  PartyBooking
//
//  Created by MAC on 7/5/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

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
    
    private let homeVM = HomeViewModel()
    var disposeBag = DisposeBag()
    
    var notification :[Notification] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        notificationsTableView.register(UINib(nibName: "NotificationsTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        setUPLocalize()
    }

    func setUPLocalize(){
        titleLabel.text = "notification".localized
        noNotificationLabel.text = "noNotification".localized
        if "lang".localized  == "en" {
                 let font = UIFont(name: "Georgia-Bold", size: 14)
                     titleLabel.font = font
                     noNotificationLabel.font = font
                 }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.homeVM.showIndicator()
        getNotification()
        
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
        cell.titleLabel.text = self.notification[indexPath.row].title ?? ""
        cell.bodyLabel.text = self.notification[indexPath.row].body ?? ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(80)
    }
    
}

extension NotificationsViewController {
    
    func getNotification() {
        homeVM.getNotification().subscribe(onNext: { (data) in
            self.homeVM.dismissIndicator()
            if data.status ?? false {
                self.notification = data.result?.data ?? []
                self.notificationsTableView.reloadData()
                if self.notification.count > 0 {
                    self.backview.isHidden = true
                }else{
                    self.backview.isHidden = false
                }
            }
        }, onError: { (error) in
            self.homeVM.dismissIndicator()
            self.backview.isHidden = false
            displayMessage(title: "", message: "Something went wrong in getting data".localized, status: .error, forController: self)
        }).disposed(by: disposeBag)
     }
}
