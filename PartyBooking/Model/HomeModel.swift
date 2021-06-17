//
//  HomeModel.swift
//  PartyBooking
//
//  Created by MAC on 13/06/2021.
//  Copyright © 2021 MAC. All rights reserved.
//

import Foundation

import Foundation

// MARK: - HomeModelJSON
struct HomeModelJSON: Codable {
    let status: Bool?
    let message: String?
    let result: HomeModel?
}

// MARK: - Result
struct HomeModel: Codable {
    let bestArtists: BestArtistsModel?
    let offers: OffersModel?
}

// MARK: - BestArtists
struct BestArtistsModel: Codable {
    let data: [Artists]?
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

// MARK: - BestArtistsDatum
struct Artists: Codable {
    let id: Int?
    let firstName,resultDescription ,lastName: String?
    let email, phone: String
    let address: String?
    let image: String?
    let rate: Int?
    let status: String?
    let favourite, countryID: Int?
    let deviceToken: String?
    let areas: [Country]?
    let country: Country?
    let partyPrices: [PartyPrice]?
    let comments: [Comment]?

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case email, phone, address, image, rate, status, favourite,comments
        case countryID = "country_id"
        case deviceToken = "device_token"
        case areas, country
        case partyPrices = "party_prices"
        case resultDescription = "description"
    }
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


// MARK: - PartyTypeModelJSON
struct PartyTypeModelJSON: Codable {
    let status: Bool?
    let message: String?
    let result: PartyTypeModel?
}

// MARK: - Result
struct PartyTypeModel: Codable {
    let partyTypes: [PartyType]?
}

// MARK: - PartyType
struct PartyType: Codable {
    let id: Int?
    let arName, enName: String?

    enum CodingKeys: String, CodingKey {
        case id
        case arName = "ar_name"
        case enName = "en_name"
    }
}

// MARK: - BestArtistModelJSON
struct BestArtistModelJSON: Codable {
    let status: Bool?
    let message: String?
    let result: BestArtistsModel?
}


