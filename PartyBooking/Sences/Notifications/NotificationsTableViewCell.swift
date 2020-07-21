//
//  NotificationsTableViewCell.swift
//  PartyBooking
//
//  Created by MAC on 7/5/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit

class NotificationsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.layer.cornerRadius = 7
        setUPLocalize()
    }
    
    
    
    func setUPLocalize(){
        
        titleLabel.text = "confirmReservation".localized
        bodyLabel.text = "look".localized
        if MOLHLanguage.currentAppleLanguage() == "en" {
            let font = UIFont(name: "Georgia-Bold", size: 14)
            titleLabel.font = font
            bodyLabel.font = font
        }
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
