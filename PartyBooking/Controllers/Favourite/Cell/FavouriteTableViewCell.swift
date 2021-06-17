//
//  FavouriteTableViewCell.swift
//  PartyBooking
//
//  Created by MAC on 7/4/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit

class FavouriteTableViewCell: UITableViewCell {

    @IBOutlet weak var viewImage: UIView!
    @IBOutlet weak var artistImage: UIImageView!
    @IBOutlet weak var rateView : UIView!
    @IBOutlet weak var locationImage: UIImageView!
    @IBOutlet weak var artistNameLabel : UILabel!
    @IBOutlet weak var artistNameValueLabel : UILabel!
    @IBOutlet weak var countryLabel : UILabel!
    @IBOutlet weak var rateCountLabel : UILabel!
    @IBOutlet weak var ratedegreeLabel : UILabel!

    var Favourite: (() -> Void)? = nil
    var viewProfile: (() -> Void)? = nil

       
    override func awakeFromNib() {
        super.awakeFromNib()
        viewImage.layer.cornerRadius = 10
        artistImage.layer.cornerRadius = 10
        rateView.layer.cornerRadius = 3
        setUPLocalize()
    }
    
    func confic(imageUrl : String , name : String , locaction : String,rate : Int){
        artistNameValueLabel.text = name
        countryLabel.text = locaction
        rateCountLabel.text = "\(rate)"
        if let iamg = URL(string: "https://partybooking.dtagdev.com/" + imageUrl){
        self.artistImage.kf.setImage(with: iamg, placeholder: #imageLiteral(resourceName: "يريءؤر سيرلايسب-1"))
        }
    }
    
    func setUPLocalize(){
         if MOLHLanguage.currentAppleLanguage() == "en" {
                let font = UIFont(name: "Georgia-Bold", size: 8)
              artistNameLabel.font = font
              artistNameValueLabel.font = font
              countryLabel.font = font
              rateCountLabel.font = font
              ratedegreeLabel.font = font
              }
       }
    
    
    @IBAction func FavouriteBtn(sender: UIButton) {
        Favourite?()
    }
    
    @IBAction func profileBtn(sender: UIButton) {
        viewProfile?()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
