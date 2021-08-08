//
//  PhotoCollectionViewCell.swift
//  PartyBooking
//
//  Created by MAC on 7/6/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var workImage : UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    
    func confic (image : String ){
        if let iamg = URL(string: "https://partybooking.dtagdev.com/" + image){
        self.workImage.kf.setImage(with: iamg, placeholder: #imageLiteral(resourceName: "يريءؤر سيرلايسب"))
        }
        
        
    }
    
}
