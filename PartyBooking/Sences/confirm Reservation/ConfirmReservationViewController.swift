//
//  ConfirmReservationViewController.swift
//  PartyBooking
//
//  Created by MAC on 7/14/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit

class ConfirmReservationViewController: UIViewController {
    
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var loadBtn: UIButton!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var contractLabel: UILabel!
    @IBOutlet weak var confirmNumbertLabel: UILabel!
    @IBOutlet weak var backButton: UIButton! {
        didSet {
            backButton.setImage(backButton.currentImage?.flipIfNeeded(), for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUPLocalize()
    }
    
    func setUPLocalize(){
        loadBtn.layer.cornerRadius = 7
        loadBtn.setTitle("laod".localized, for: .normal)
        doneBtn.setTitle("reservationDone".localized, for: .normal)
        titleLabel.text = "congratulation".localized
        contractLabel.text = "contract".localized
        confirmNumbertLabel.text = "confirmNumber".localized
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
    
    @IBAction func doneButton(sender: UIButton) {
        let destinationVC = TabBarController.instantiate(fromAppStoryboard: .Main)
        destinationVC.type = .user
        if let appDelegate = UIApplication.shared.delegate {
            appDelegate.window??.rootViewController = destinationVC
        }
    }
    
}
