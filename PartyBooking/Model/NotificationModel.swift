//
//  NotificationModel.swift
//  PartyBooking
//
//  Created by MAC on 04/09/2021.
//  Copyright © 2021 MAC. All rights reserved.
//

import Foundation

// MARK: - NotificationModelJSON
struct NotificationModelJSON: Codable {
    let status: Bool?
    let message: String?
    let result: NotificationModel?
}

// MARK: - Result
struct NotificationModel: Codable {
    let data: [Notification]?
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
struct Notification : Codable {
    let id: Int?
    let title, body: String?
    let itemID: Int?
    let itemType: String?
    let view: Int?
    let createdAt, datumFor: String?
    let userID: Int?

    enum CodingKeys: String, CodingKey {
        case id, title, body
        case itemID = "item_id"
        case itemType = "item_type"
        case view
        case createdAt = "created_at"
        case datumFor = "for"
        case userID = "user_id"
    }
}
