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
    @IBOutlet weak var amountLabel : UILabel!
    @IBOutlet weak var amountValueLabel : UILabel!
    @IBOutlet weak var taxesLabel : UILabel!
    
    @IBOutlet weak var artistNameLabel : UILabel!
    @IBOutlet weak var artistNameValueLabel : UILabel!
    @IBOutlet weak var countryLabel : UILabel!
    @IBOutlet weak var rateCountLabel : UILabel!
    @IBOutlet weak var ratedegreeLabel : UILabel!

    
       
    override func awakeFromNib() {
        super.awakeFromNib()
        viewImage.layer.cornerRadius = 10
        artistImage.layer.cornerRadius = 10
        rateView.layer.cornerRadius = 3
        setUPLocalize()
    }

    
    func setUPLocalize(){
           amountLabel.text = "amount".localized
           taxesLabel.text = "\("taxes".localized) + SR 450"
         if MOLHLanguage.currentAppleLanguage() == "en" {
                let font = UIFont(name: "Georgia-Bold", size: 8)
              amountLabel.font = font
              taxesLabel.font = font
              amountValueLabel.font = font
              artistNameLabel.font = font
              artistNameValueLabel.font = font
              countryLabel.font = font
              rateCountLabel.font = font
              ratedegreeLabel.font = font
              
              }
        
       }
    
    
    var isFavourite = true
    @IBAction func FavouriteBtn(sender: UIButton) {
        if isFavourite {
            sender.setImage(UIImage(named:"heart (1).png"), for: .normal)
            isFavourite = false
        }
        else {
            sender.setImage( UIImage(named:"heart (2).png"), for: .normal)
            isFavourite = true
        }
    }
  
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
