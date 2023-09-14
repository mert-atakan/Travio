//
//  UploadResponse.swift
//  AccessTokenApi
//
//  Created by Kullanici on 25.08.2023.
//

import Foundation

struct UploadResponse: Codable {
    var messageType: String
    var message: String
    var urls: [String]
}

struct GalleryResponse: Codable {
    var message: String
    var status: String
}
