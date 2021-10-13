//
//  ArtistProfileModel.swift
//  PartyBooking
//
//  Created by MAC on 18/09/2021.
//  Copyright © 2021 MAC. All rights reserved.


import Foundation
// MARK: - ArtistModelLoginJSON
struct ArtistHomeModelJson: Codable {
    let status: Bool?
    let message: String?
    let result: ArtistHomeModel?
}

// MARK: - Result
struct ArtistHomeModel: Codable {
    let artist: ArtistModel?
}


// MARK: - AvailableDatesModelJSON
struct AvailableDatesModelJSON: Codable {
    let status: Bool?
    let message: String?
    let result: AvailableDatesModel?
}

// MARK: - Result
struct AvailableDatesModel : Codable {
    let notAvailableDates: [NotAvailableDate]?
    let pricesDates: [pricesDates]?

    enum CodingKeys: String, CodingKey {
        case notAvailableDates = "NotAvailableDates"
        case pricesDates
    }
}

// MARK: - NotAvailableDate
struct NotAvailableDate: Codable {
    let id, artistID: Int?
    let date: String?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case artistID = "artist_id"
        case date
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

struct pricesDates: Codable {
    let id, artistID: Int?
    let date: String?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case artistID = "artist_id"
        case date
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}



// MARK: - ArtistReviewModelJSON
struct ArtistReviewModelJSON: Codable {
    let status: Bool?
    let message: String?
    let result: ArtistReviewModel?
}

// MARK: - Result
struct ArtistReviewModel: Codable {
    let data: [ArtistReview]?
    let total, count, perPage, currentPage: Int?
    let totalPages: Int?
    let prev, next: String?

    enum CodingKeys: String, CodingKey {
        case data, total, count
        case perPage = "per_page"
        case currentPage = "current_page"
        case totalPages = "total_pages"
        case prev, next
    }
}

// MARK: - Datum
struct ArtistReview: Codable {
    let id, rate: Int?
    let comment, createdAt, updatedAt: String?
    let user: User?

    enum CodingKeys: String, CodingKey {
        case id, rate, comment
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case user
    }
}
