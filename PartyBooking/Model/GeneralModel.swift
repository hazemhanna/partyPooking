//
//  GeneralModel.swift
//  PartyBooking
//
//  Created by MAC on 13/06/2021.
//  Copyright © 2021 MAC. All rights reserved.
//

import Foundation
import Foundation

// MARK: - CompetitionsModelJSON
struct CountriesModelJson: Codable {
    let status: Bool?
    let message: String?
    let result: CountryModel?
}

// MARK: - Result
struct CountryModel: Codable {
    let countries: [Country]?
}

// MARK: - Country
struct Country: Codable {
    let id: Int?
    let arName, enName: String?

    enum CodingKeys: String, CodingKey {
        case id
        case arName = "ar_name"
        case enName = "en_name"
    }
}


struct AreaModelJson: Codable {
    let status: Bool?
    let message: String?
    let result: areaModel?
}

// MARK: - Result
struct areaModel: Codable {
    let areas: [Areas]?
}

// MARK: - Country
struct Areas: Codable {
    let id: Int?
    let arName, enName: String?

    enum CodingKeys: String, CodingKey {
        case id
        case arName = "ar_name"
        case enName = "en_name"
    }
}
