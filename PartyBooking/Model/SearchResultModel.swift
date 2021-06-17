//
//  SearchResultModel.swift
//  PartyBooking
//
//  Created by MAC on 15/06/2021.
//  Copyright © 2021 MAC. All rights reserved.
//

import Foundation

// MARK: - SearchResultModelJSON
struct SearchResultModelJSON: Codable {
    let status: Bool?
    let message: String?
    let result: [Artists]?
}

// MARK: - Comment
struct Comment: Codable {
    let id: Int
    let comment: String
    let rate, artistID, userID: Int
    let createdAt, updatedAt: String
    let user: User

    enum CodingKeys: String, CodingKey {
        case id, comment, rate
        case artistID = "artist_id"
        case userID = "user_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case user
    }
}


// MARK: - PartyPrice
struct PartyPrice: Codable {
    let id: Int
    let arName, enName: String
    let price, partyPrice, breakTime, partyTime: Int

    enum CodingKeys: String, CodingKey {
        case id
        case arName = "ar_name"
        case enName = "en_name"
        case price
        case partyPrice = "party_price"
        case breakTime = "break_time"
        case partyTime = "party_time"
    }
}




