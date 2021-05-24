//
//  SideMenuModel.swift
//  PartyBooking
//
//  Created by MAC on 23/05/2021.
//  Copyright © 2021 MAC. All rights reserved.
//


import Foundation
import UIKit


struct SideMenuModel {
    var Name: String
     var Id: String
    var image: UIImage
    
    init(Name: String, Id: String, image: UIImage) {
        self.Name = Name
        self.Id = Id
        self.image = image
    }
}
