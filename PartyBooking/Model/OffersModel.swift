//
//  OffersModel.swift
//  PartyBooking
//
//  Created by MAC on 08/08/2021.



import Foundation

// MARK: - OffersModelJSON
struct OffersModelJSON: Codable {
    let status: Bool?
    let message: String?
    let result: OffersModel?
}

// MARK: - Result
struct OffersModel: Codable {
    let data: [Offers]?
    let total, count, perPage, currentPage: Int?
    let totalPages: Int?
    let prev: String?
    let next: String?

    enum CodingKeys: String, CodingKey {
        case data, total, count
        case perPage = "per_page"
        case currentPage = "current_page"
        case totalPages = "total_pages"
        case prev, next
    }
}

// MARK: - Datum
struct Offers: Codable {
    let id, artistID: Int?
    let artistName: String?
    let title: String?
    let datumDescription: String?
    let partyTypeID: Int?
    let arArea: String?
    let enArea: String?
    let arParty: String?
    let enParty: String?
    let url: String?
    let attachmentType: String?
    let status: String?
    let from, to: String?
    let offerValue: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case artistID = "artist_id"
        case artistName = "artist_name"
        case title
        case datumDescription = "description"
        case partyTypeID = "party_type_id"
        case arArea = "ar_party_area"
        case enArea = "en_party_area"
        case arParty = "ar_party_type"
        case enParty = "en_party_type"
        case url
        case attachmentType = "attachment_type"
        case status, from, to
        case offerValue = "offer_value"
    }
}

// MARK: - OffersModelJSON
struct OffersDetailsModelJSON: Codable {
    let status: Bool?
    let message: String?
    let result: Offers?
}


