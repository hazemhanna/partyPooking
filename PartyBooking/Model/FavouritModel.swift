//
//  FavouritModel.swift
//  PartyBooking
//
//  Created by MAC on 17/06/2021.
//  Copyright © 2021 MAC. All rights reserved.
//

import Foundation


// MARK: - FavouriteModelJSON
struct FavouriteModelJSON: Codable {
    let status: Bool?
    let message: String?
    let result: FavouriteModel?
}

// MARK: - Result
struct FavouriteModel: Codable {
    let data: [Favourite]?
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
struct Favourite: Codable {
    let id, artistID, userID: Int?
    let artist: Artists?

    enum CodingKeys: String, CodingKey {
        case id
        case artistID = "artist_id"
        case userID = "user_id"
        case artist
    }
}



// MARK: - FavouriteModelJSON
struct AddFavouriteModel: Codable {
    let status: Bool?
    let message: String?
    let result: String?
}
