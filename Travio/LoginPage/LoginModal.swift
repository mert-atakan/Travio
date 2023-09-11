//
//  Modal.swift
//  AccessTokenApi
//
//  Created by Kullanici on 17.08.2023.
//

import Foundation

struct RegisterResponse: Codable {
    var message: String
    var status: String
}

struct LoginResponse: Codable {
    var accessToken: String
    var refreshToken : String
}

struct ErrorResponse: Error, Codable {
    var message: String
    var status: String
}

struct AddTravelResponse: Codable {
    var message: String
    var status: String
}


