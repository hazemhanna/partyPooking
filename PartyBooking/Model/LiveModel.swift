//
//  LiveModel.swift
//  PartyBooking
//
//  Created by MAC on 03/08/2021.
//  Copyright © 2021 MAC. All rights reserved.
//

import Foundation

// MARK: - LiveModelJSON
struct LiveModelJSON: Codable {
    let status: Bool?
    let message: String?
    let result: LiveModel?
}

// MARK: - Result
struct LiveModel: Codable {
    let data: [LiveData]?
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
struct LiveData: Codable {
    let id: Int?
    let url: String?
    let type, artistName, artistImage: String?

    enum CodingKeys: String, CodingKey {
        case id, url, type
        case artistName = "artist_name"
        case artistImage = "artist_image"
    }
}
