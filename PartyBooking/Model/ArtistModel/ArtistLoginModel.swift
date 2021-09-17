//
//  ArtistLoginModel.swift
//  PartyBooking
//
//  Created by MAC on 15/09/2021.
//  Copyright © 2021 MAC. All rights reserved.
//

import Foundation

// MARK: - ArtistModelLoginJSON
struct ArtistModelLoginJSON: Codable {
    let status: Bool?
    let message: String?
    let result: ArtistModelLogin?
}

// MARK: - Result
struct ArtistModelLogin: Codable {
    let accessToken, tokenType: String?
    let expiresIn: Int?

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
    }
}
