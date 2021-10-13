//
//  PartyPriceCell.swift
//  PartyBooking
//
//  Created by MAC on 25/05/2021.
//  Copyright © 2021 MAC. All rights reserved.
//

import UIKit

class PartyPriceCell: UITableViewCell , UITextFieldDelegate{

    @IBOutlet weak var partyName: UILabel!
    @IBOutlet weak var partyPRice: UITextField!
    @IBOutlet weak var partyTime: UITextField!
    @IBOutlet weak var restTime: UITextField!


    var updatePartyPrice : (() -> Void)? = nil
    var updatePartyTime : (() -> Void)? = nil
    var updateRestTime : (() -> Void)? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
        partyPRice.delegate = self
        restTime.delegate = self
        partyTime.delegate = self

        partyPRice.addTarget(self, action: #selector(PartyPriceCell.textFieldDidChange(_:)), for: .editingChanged)
        restTime.addTarget(self, action: #selector(PartyPriceCell.textFieldDidChange(_:)), for: .editingChanged)
        partyTime.addTarget(self, action: #selector(PartyPriceCell.textFieldDidChange(_:)), for: .editingChanged)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
            updatePartyPrice?()
    }
    
}
