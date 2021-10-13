//
//  RateTableViewCell.swift
//  PartyBooking
//
//  Created by MAC on 7/6/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit
import Cosmos

class RateTableViewCell: UITableViewCell,FloatRatingViewDelegate {
    
    @IBOutlet weak var rateView : CosmosView!
    @IBOutlet weak var profileView : UIView!
    @IBOutlet weak var nameLbl : UILabel!
    @IBOutlet weak var imageProfile : UIImageView!
    @IBOutlet weak var commentLbl : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        profileView.layer.cornerRadius = profileView.frame.width / 2
        rateView.rating = 4
     }
    
    
 
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
