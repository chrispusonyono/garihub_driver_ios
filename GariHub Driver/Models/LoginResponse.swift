//
//  LoginResponse.swift
//  GariHub Driver
//
//  Created by Kevin Lagat on 11/2/20.
//  Copyright © 2020 Kevin Lagat. All rights reserved.
//

import Foundation

struct LoginRequest: Codable {
    let emailAddress, password: String
}


struct LoginResponse: Codable {
    let id: Int
    let firstName, lastName, gender, phoneNumber: String
    let isRegistered, otpSent: Bool
    let emailAddress, emailStatus, accountStatus, userType: String
    let rating: JSONNull?
    let success: Bool
    let message: JSONNull?
    let createdAt, updatedAt: String
}
