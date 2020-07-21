//
//  CommentsTableViewCell.swift
//  PartyBooking
//
//  Created by MAC on 7/6/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit

class CommentsTableViewCell: UITableViewCell {

    @IBOutlet weak var profileView : UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        profileView.layer.cornerRadius = profileView.frame.width / 2
        if MOLHLanguage.currentAppleLanguage() == "en" {
        
        }

    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
