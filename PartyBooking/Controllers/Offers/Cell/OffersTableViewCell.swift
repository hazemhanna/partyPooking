//
//  OffersTableViewCell.swift
//  PartyBooking
//
//  Created by MAC on 7/5/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit

class OffersTableViewCell: UITableViewCell {
    
    @IBOutlet weak var offerImage : UIImageView!
    @IBOutlet weak var artistImage : UIImageView!
    @IBOutlet weak var offerLabel: UILabel!
    @IBOutlet weak var titleLbl : UILabel!
    @IBOutlet weak var desLbl : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        offerImage.image = UIImage(named: "coupon")?.withRenderingMode(.alwaysTemplate)
        offerImage.tintColor =  UIColor.white
        setUPLocalize()
        
    }
    
    
    func confic (title: String , image : String , desc : String){
        desLbl.text = desc
        titleLbl.text = title
        if let iamg = URL(string: "https://partybooking.dtagdev.com/" + image){
        self.artistImage.kf.setImage(with: iamg, placeholder: #imageLiteral(resourceName: "يريءؤر سيرلايسب"))
        }
        
        
    }
    
    
    
    func setUPLocalize(){
          offerLabel.text = "offer".localized
         // teamLabel.text = "team".localized
      }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
