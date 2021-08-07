//
//  ProfileModel.swift
//  PartyBooking
//
//  Created by MAC on 03/08/2021.
//  Copyright © 2021 MAC. All rights reserved.
//

import Foundation

// MARK: - ProfileModelJSON
struct ProfileModelJSON: Codable {
    let status: Bool?
    let message: String?
    let result: ProfileModel?
}

// MARK: - Result
struct ProfileModel: Codable {
    let user: User?
}


