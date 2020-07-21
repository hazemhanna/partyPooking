//
//  ArtistReservationTableViewCell.swift
//  PartyBooking
//
//  Created by MAC on 7/9/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit

class ArtistReservationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var confirmBtn: UILabel!
     @IBOutlet weak var confirmnumberValue: UILabel!
    @IBOutlet weak var clientLabel: UILabel!
    @IBOutlet weak var clientValueLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var cityValueLabel: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        setUPLocalize()
    }
    
     func setUPLocalize(){
        
        confirmBtn.text = "confirmeRservation".localized
        clientLabel.text = "clientNmae".localized
        cityLabel.text = "city".localized
        if MOLHLanguage.currentAppleLanguage() == "en" {
             let font = UIFont(name: "Georgia-Bold", size: 8)
            let font2 = UIFont(name: "Georgia-Bold", size: 11)
             confirmBtn.font = font
             confirmnumberValue.font = font
             clientLabel.font =  font2
            cityLabel.font =  font2
            clientValueLabel.font =  font
            cityValueLabel.font =  font
         }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
