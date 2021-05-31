//
//  Errors.swift
//  PartyBooking
//
//  Created by MAC on 31/05/2021.
//  Copyright © 2021 MAC. All rights reserved.
//

import Foundation

// MARK: - Errors
struct Errors: Codable {
    var email: [String]?
    var price: [String]?
    var phone : [String]?
    
    enum CodingKeys: String, CodingKey {
        case email
        case price
        case phone
    }
}
