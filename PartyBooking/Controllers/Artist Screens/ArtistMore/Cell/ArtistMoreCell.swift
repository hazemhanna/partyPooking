//
//  ArtistMoreCell.swift
//  PartyBooking
//
//  Created by MAC on 23/05/2021.
//  Copyright © 2021 MAC. All rights reserved.
//

import UIKit

class ArtistMoreCell: UITableViewCell {
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var backButton: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func config(Name: String, image : UIImage) {
        self.NameLabel.text = Name
        self.iconImageView.image = image
    }
    
}
