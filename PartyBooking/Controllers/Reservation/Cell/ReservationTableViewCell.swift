//
//  ReservationTableViewCell.swift
//  PartyBooking
//
//  Created by MAC on 7/3/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit

class ReservationTableViewCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var loadBtn: UIButton!
    @IBOutlet weak var contractLabel: UILabel!
    @IBOutlet weak var confirmNumberLabel: UILabel!
    @IBOutlet weak var NumberLabel: UILabel!
    @IBOutlet weak var cancelBtn: UIButton!

    var cancel: (() -> Void)? = nil


    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.layer.cornerRadius = 15
        loadBtn.layer.cornerRadius = 7
        setUPLocalize()
     }
     
     func setUPLocalize(){
        loadBtn.setTitle("laod".localized, for: .normal)
        contractLabel.text = "contract".localized
        confirmNumberLabel.text = "confirmNumber".localized
        }
       
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    @IBAction func cancelAction(_ sender: UIButton) {
        self.cancel?()
    }
    
    
}
