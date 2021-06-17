//
//  MostFamousCollectionViewCell.swift
//  PartyBooking
//
//  Created by MAC on 7/2/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit
import Kingfisher

class MostFamousCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var bannerImage: UIImageView!
    @IBOutlet weak var locationImage: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func confic(imageUrl : String , name : String , locaction : String){
      
        titleLbl.text = name
        locationLbl.text = locaction
        if let iamg = URL(string: "https://partybooking.dtagdev.com/" + imageUrl){
        self.bannerImage.kf.setImage(with: iamg, placeholder: #imageLiteral(resourceName: "يريءؤر سيرلايسب"))
        }
        
    }
    
}
