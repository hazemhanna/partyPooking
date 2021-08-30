//
//  CommentsTableViewCell.swift
//  PartyBooking
//
//  Created by MAC on 7/6/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit

class CommentsTableViewCell: UITableViewCell {
    @IBOutlet weak var profileImage : UIImageView!
    @IBOutlet weak var nameLbl : UILabel!
    @IBOutlet weak var commentLbl : UILabel!
    @IBOutlet weak var profileView : UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileView.layer.cornerRadius = profileView.frame.width / 2
        if "lang".localized  == "en" {

        }

    }
    
    func confic (name: String , image : String , comment : String){
        commentLbl.text = comment
        nameLbl.text = name
        if let iamg = URL(string: "https://partybooking.dtagdev.com/" + image){
        self.profileImage.kf.setImage(with: iamg, placeholder: #imageLiteral(resourceName: "يريءؤر سيرلايسب"))
        }
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
