//
//  AllLiveCell.swift
//  PartyBooking
//
//  Created by MAC on 29/05/2021.
//  Copyright © 2021 MAC. All rights reserved.
//

import UIKit

class AllLiveCell: UITableViewCell {

    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var artistImage : UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func confic(imageUrl : String , name : String ){
        nameLabel.text = name
        if let iamg = URL(string: "https://partybooking.dtagdev.com/" + imageUrl){
        self.artistImage.kf.setImage(with: iamg, placeholder: #imageLiteral(resourceName: "يريءؤر سيرلايسب"))
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
