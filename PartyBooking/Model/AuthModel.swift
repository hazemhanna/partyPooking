//
//  AuthModel.swift
//  PartyBooking
//
//  Created by MAC on 31/05/2021.
//  Copyright © 2021 MAC. All rights reserved.
//
import Foundation

struct AuthMdelsJSON: Codable {
    let status: Bool?
    let message: String?
    let result: Result?
}

// MARK: - Result
struct Result: Codable {
    let accessToken, tokenType: String?
    let user: User?
    let expiresIn: Int?

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case user
        case expiresIn = "expires_in"
    }
}

// MARK: - User
struct User: Codable {
    let id: Int?
    let firstName, lastName, email, phone: String?
    let address, image: String?
    let status: String?
    let socialID, type: String?
    let countryID: Int?
   let country: Country?
    let deviceToken: String?

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case email, phone, address, image, status
        case socialID = "social_id"
        case type
        case countryID = "country_id"
        case country
        case deviceToken = "device_token"
    }
}

// MARK: - TermsModelJSON
struct TermsModelJSON: Codable {
    let status: Bool?
    let message: String?
    let result: Terms?
}

// MARK: - Terms
struct Terms: Codable {
    let enTerms, arTerms: String?

    enum CodingKeys: String, CodingKey {
        case enTerms = "en_terms"
        case arTerms = "ar_terms"
    }
}

// MARK: - AboutUSModelJSON
struct AboutUSModelJSON: Codable {
    let status: Bool?
    let message: String?
    let result: AboutUSModel?
}

// MARK: - Result
struct AboutUSModel: Codable {
    let arAboutus, enAboutus: String?

    enum CodingKeys: String, CodingKey {
        case arAboutus = "ar_aboutus"
        case enAboutus = "en_aboutus"
    }
}


// MARK: - CompetitionsModelJSON
struct ContactUSModelJson: Codable {
    let status: Bool?
    let message: String?
    let result: String?
}
