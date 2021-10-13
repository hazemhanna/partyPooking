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
    let artist: ArtistModel?

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
        case artist
    }
}


// MARK: - Artist
struct ArtistModel : Codable {
    let id: Int?
    let firstName, lastName, artistDescription, email: String?
    let phone: String
    let address: String?
    let image: String?
    let rate: Int?
    let status: String?
    let favourite, countryID: Int?
    let deviceToken: String?
    let areas: [Country]?
    let country: Country?
    let partPices: [PartPice]?

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case artistDescription = "description"
        case email, phone, address, image, rate, status, favourite
        case countryID = "country_id"
        case deviceToken = "device_token"
        case areas, country
        case partPices = "part_pices"
    }
}



// MARK: - PartPice
struct PartPice: Codable {
    let id: Int?
    let arName, enName: String?
    let commission: Int?
    let deleted, createdAt, updatedAt: String?
    let artistPartyID: Int?
    let pivot: Pivot?

    enum CodingKeys: String, CodingKey {
        case id
        case arName = "ar_name"
        case enName = "en_name"
        case commission, deleted
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case artistPartyID = "artist_party_id"
        case pivot
    }
}

// MARK: - Pivot
struct Pivot: Codable {
    let artistID, partyTypeID, id, price: Int?
    let breakTime, partyTime: Int?

    enum CodingKeys: String, CodingKey {
        case artistID = "artist_id"
        case partyTypeID = "party_type_id"
        case id, price
        case breakTime = "break_time"
        case partyTime = "party_time"
    }
}
