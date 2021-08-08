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
    let result: [SearchResult]?
}

// MARK: - Result
struct SearchResult: Codable {
    let id: Int?
    let firstName, lastName: String?
    let resultDescription: String?
    let email, phone: String?
    let address: String?
    let image: String?
    let countryID, favourite: Int?
    let partyPrices: [PartyPrice]?
    let comments: [Comment]?
    let rate, partyPrice: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case resultDescription = "description"
        case email, phone, address, image
        case countryID = "country_id"
        case favourite
        case partyPrices = "party_prices"
        case comments, rate
        case partyPrice = "party_price"
    }
}

// MARK: - Comment
struct Comment: Codable {
    let id: Int?
    let comment: String?
    let rate, artistID, userID: Int?
    let createdAt, updatedAt: String?
    let user : User?
    enum CodingKeys: String, CodingKey {
        case id, comment, rate,user
        case artistID = "artist_id"
        case userID = "user_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - PartyPrice
struct PartyPrice: Codable {
    let id: Int?
    let arName, enName: String?
    let price: Int?
    let partyPrice: Double?
    let breakTime, partyTime: Int?

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

