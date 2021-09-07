//
//  OffersModel.swift
//  PartyBooking
//
//  Created by MAC on 08/08/2021.
//  Copyright © 2021 MAC. All rights reserved.
//

import Foundation

// MARK: - OffersModelJSON
struct OffersModelJSON: Codable {
    let status: Bool?
    let message: String?
    let result: OffersModel?
}

// MARK: - Offers
struct OffersModel: Codable {
    let data: [Offers]?
    let total, count, perPage, currentPage: Int?
    let totalPages: Int?
    let prev, next: Int?

    enum CodingKeys: String, CodingKey {
        case data, total, count
        case perPage = "per_page"
        case currentPage = "current_page"
        case totalPages = "total_pages"
        case prev, next
    }
}

// MARK: - OffersDatum
struct Offers: Codable {
    let id, artistID: Int?
    let title, datumDescription, url, attachmentType: String?
    let status, from, to: String?

    enum CodingKeys: String, CodingKey {
        case id
        case artistID = "artist_id"
        case title
        case datumDescription = "description"
        case url
        case attachmentType = "attachment_type"
        case status, from, to
    }
}

// MARK: - OffersModelJSON
struct OffersDetailsModelJSON: Codable {
    let status: Bool?
    let message: String?
    let result: OffersDetail?
}

// MARK: - Result
struct OffersDetail : Codable {
    let id, artistID: Int?
    let artistName, title, resultDescription: String?
    let offerPartyType: String?
    let url, attachmentType, status, from: String?
    let to: String?
    let offerValue: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case artistID = "artist_id"
        case artistName = "artist_name"
        case title
        case resultDescription = "description"
        case offerPartyType = "offer_party_type"
        case url
        case attachmentType = "attachment_type"
        case status, from, to
        case offerValue = "offer_value"
    }
}
