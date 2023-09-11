//
//  GalleryData.swift
//  AccessTokenApi
//
//  Created by Kullanici on 22.08.2023.
//

import Foundation

struct GalleryData:Codable {
    var data: Images
    var status: String
}
struct Images:Codable {
    var images: [ImageItem]
    var count: Int
}

struct ImageItem:Codable {
    var id: String
    var place_id: String
    var image_url: String
    var created_at: String
    var updated_at: String
}

struct DefaultResponse:Codable {
    var message: String
    var status: String
}
