//
//  PartyPriceCell.swift
//  PartyBooking
//
//  Created by MAC on 25/05/2021.
//  Copyright © 2021 MAC. All rights reserved.
//

import UIKit

protocol PartyPriceCellDelegate: AnyObject {
    func partyPriceCell(_ cell: PartyPriceCell, didChangeModel at: Int,prices :PartPice)
    
}

class PartyPriceCell: UITableViewCell , UITextFieldDelegate{

    @IBOutlet weak var partyName: UILabel!
    @IBOutlet weak var partyPRice: UITextField!
    @IBOutlet weak var partyTime: UITextField!
    @IBOutlet weak var restTime: UITextField!
    
    weak var delegate: PartyPriceCellDelegate?
    var index = -1
    
    var price :PartPice!{
        didSet{
            if "lang".localized == "ar" {
                    partyName.text = price.arName ?? ""
                }else{
                   partyName.text = price.enName ?? ""
                }
             restTime.text = String(price.pivot?.breakTime ?? 0)
             partyPRice.text = String(price.pivot?.price ?? 0)
             partyTime.text = String(price.pivot?.partyTime ?? 0)
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        partyPRice.delegate = self
        restTime.delegate = self
        partyTime.delegate = self
    }

    
    
    override func didMoveToSuperview() {
        partyPRice.delegate = self
        restTime.delegate = self
        partyTime.delegate = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.partyPriceCell(self, didChangeModel: index,prices:price)
    }
}

extension UITextField {
    var isEmpty: Bool {
        return (self.text?.isEmpty)! || self.text! == String(repeating: " ", count: self.text!.count)
    }
    
     func setPlaceHolderColor(color : UIColor){
        self.attributedPlaceholder = NSAttributedString(string:(self.placeholder ?? "").localized, attributes: [NSAttributedString.Key.foregroundColor: color])

       }
}
