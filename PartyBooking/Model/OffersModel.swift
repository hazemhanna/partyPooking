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
    let offerPartyType: OfferPartyType?
    let offerArea: OfferArea?
    let url: String?
    let attachmentType: String?
    let status: String?
    let from, to: String?
    let offerPrice, offerValue: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case artistID = "artist_id"
        case artistName = "artist_name"
        case title
        case datumDescription = "description"
        case partyTypeID = "party_type_id"
        case offerPartyType = "offer_party_type"
        case offerArea = "offer_area"
        case url
        case attachmentType = "attachment_type"
        case status, from, to
        case offerPrice = "offer_price"
        case offerValue = "offer_value"
    }
}

// MARK: - OfferArea
struct OfferArea: Codable {
    let id: Int?
    let arName: String?
    let enName: String?
    let countryID, deleted: Int?
    let createdAt: String?
    let updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case arName = "ar_name"
        case enName = "en_name"
        case countryID = "country_id"
        case deleted
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - OfferPartyType
struct OfferPartyType: Codable {
    let id: Int?
    let arName, enName: String?
    let commission: Int?
    let deleted: String?
    let createdAt: String?
    let updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case arName = "ar_name"
        case enName = "en_name"
        case commission, deleted
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - OffersModelJSON
struct OffersDetailsModelJSON: Codable {
    let status: Bool?
    let message: String?
    let result: Offers?
}


