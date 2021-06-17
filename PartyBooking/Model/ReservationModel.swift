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

// MARK: - Datum
struct Reservation: Codable {
    let id, userID, artistID: Int?
    let status, date: String?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case artistID = "artist_id"
        case status, date
      
    }
}

