//
//  UserStruct.swift
//  AccessTokenApi
//
//  Created by Kullanici on 5.09.2023.
//

import Foundation

struct User: Codable {
     let full_name: String
     let email: String
     let role: String
     let pp_url: String
     let created_at: String
}
