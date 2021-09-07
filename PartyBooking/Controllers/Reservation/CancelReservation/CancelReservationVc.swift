//
//  CancelReservationVc.swift
//  PartyBooking
//
//  Created by MAC on 26/05/2021.
//  Copyright © 2021 MAC. All rights reserved.
//


import UIKit

class CancelReservationVc: UIViewController {
    
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var reasonTF: UITextField!

    
    var onClickCancel :()->() = {}
    var onClickConfirm :()->() = {}
    var onClickDone :()->() = {}

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.transform = CGAffineTransform(scaleX: 0.8, y: 1.2)
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [],  animations: {
            self.view.transform = .identity
        })
    }
    
    @IBAction func dismisAction(_ sender: UIButton) {
        self.onClickCancel()
        self.presentingViewController?.dismiss(animated: true)

    }
        
    @IBAction func confirmAction(_ sender: UIButton) {
        self.onClickConfirm()
    }
    @IBAction func doneAction(_ sender: UIButton) {
        self.onClickDone()
        self.presentingViewController?.dismiss(animated: true)

    }
    
    override init(nibName: String?, bundle: Bundle?) {
        super.init(nibName: nibName, bundle: bundle)
        self.modalPresentationStyle = .custom
        self.modalTransitionStyle = .crossDissolve
    }
    convenience init() {
        self.init(nibName:nil, bundle:nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.modalPresentationStyle = .custom
        self.modalTransitionStyle = .crossDissolve
    }
    
}

