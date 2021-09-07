//
//  ReservationModel.swift
//  PartyBooking
//
//  Created by MAC on 17/06/2021.
//  Copyright © 2021 MAC. All rights reserved.
//

import Foundation

// MARK: - ReservationModelJSON
struct ReservationModelJSON: Codable {
    let status: Bool?
    let message: String?
    let result: ReservationTypeModel?
}

// MARK: - Result
struct ReservationTypeModel: Codable {
    let currentBookings, completedBookings, cancelledBookings: ReservationModel?
}

// MARK: - Bookings
struct ReservationModel: Codable {
    let data: [Reservation]?
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



struct Reservation : Codable {
    let id, userID, artistID: Int?
    let status: String?
    let date: String?
    let fromTime, toTime: String?
    let price, taxes, rate: Int
    let address: String?
    let isRated: Int?
    let cancelReason: String?
    let artist: artistName?
    let partyType, area: Areas?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case artistID = "artist_id"
        case status, date
        case fromTime = "from_time"
        case toTime = "to_time"
        case price, taxes, rate, address
        case isRated = "is_rated"
        case cancelReason = "cancel_reason"
        case artist
        case partyType = "party_type"
        case area
    }
}


// MARK: - Country
struct artistName: Codable {
    let id: Int?
    let firstName,lastName: String?
    let favourite: Int?

    
    enum CodingKeys: String, CodingKey {
        case id
        case favourite
        case firstName = "first_name"
        case lastName = "last_name"
    }
}
