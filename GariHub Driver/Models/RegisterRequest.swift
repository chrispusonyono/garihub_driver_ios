//
//  RegisterRequest.swift
//  GariHub Driver
//
//  Created by Kevin Lagat on 11/2/20.
//  Copyright © 2020 Kevin Lagat. All rights reserved.
//

import Foundation
struct RegisterRequest: Codable {
    let firstName, lastName, gender, phoneNumber: String
    let emailAddress, userType, password: String
}


struct RegisterResponse: Codable {
    let id: Int
    let firstName, lastName, gender, phoneNumber: String
    let isRegistered, otpSent: Bool
    let emailAddress, emailStatus, accountStatus, userType: String
    let rating: JSONNull?
    let success: Bool
    let message: JSONNull?
    let createdAt, updatedAt: String
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
