//
//  TermsAndConditionVc.swift
//  PartyBooking
//
//  Created by MAC on 21/05/2021.
//  Copyright © 2021 MAC. All rights reserved.
//

import UIKit

class TermsAndConditionVc: UIViewController {

    @IBOutlet weak var termsTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        termsTextView.isEditable = false
        termsTextView.isSelectable = false
    }

    @IBAction func backButton(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
