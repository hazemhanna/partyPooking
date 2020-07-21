//
//  ArtistRegisterViewController.swift
//  PartyBooking
//
//  Created by MAC on 7/7/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit

class ArtistRegisterViewController: UIViewController {

    @IBOutlet weak var numberView: UIView!
    @IBOutlet weak var nextBtn : UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()

        nextBtn.layer.cornerRadius = 7
        numberView.layer.borderColor = UIColor.rgb(112, green: 112, blue: 112).cgColor
        numberView.layer.borderWidth = 1
        
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
    
    
    @IBAction func nextButton(sender: UIButton) {
         let destinationVC = TakePicViewController.instantiateFromNib()
        self.navigationController?.pushViewController(destinationVC!, animated: true)
               
    }

 
}

