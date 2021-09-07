//
//  SearchResultTableViewCell.swift
//  PartyBooking
//
//  Created by MAC on 7/6/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {
    
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
    @IBOutlet weak var favourtieBtn : UIButton!

    var addFavourite: (() -> Void)? = nil
    var isFavourite = true

    override func awakeFromNib() {
        super.awakeFromNib()
        viewImage.layer.cornerRadius = 10
        artistImage.layer.cornerRadius = 10
        rateView.layer.cornerRadius = 3
        setUPLocalize()
    }
    
    func confic(imageUrl : String , name : String , locaction : String,rate : Int,price : Int ,isFavourite:Int){
        artistNameValueLabel.text = name
        countryLabel.text = locaction
        rateCountLabel.text = "\(rate)"
        amountValueLabel.text = "\(price)" + ("SR".localized)
        if isFavourite == 0 {
            self.isFavourite = false
            favourtieBtn.setImage( UIImage(named:"heart (1).png"), for: .normal)
        }else{
            self.isFavourite = true
            favourtieBtn.setImage(UIImage(named:"heart (2).png"), for: .normal)
        }
        if let iamg = URL(string: "https://partybooking.dtagdev.com/" + imageUrl){
        self.artistImage.kf.setImage(with: iamg, placeholder: #imageLiteral(resourceName: "يريءؤر سيرلايسب-1"))
        }
    }
    
    
    func setUPLocalize(){
        amountLabel.text = "amount".localized
        taxesLabel.text = "\("taxes".localized) 450 \("SR".localized)"
        if "lang".localized  == "en" {
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
    
    
    
    @IBAction func FavouriteBtn(sender: UIButton) {
        addFavourite?()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
