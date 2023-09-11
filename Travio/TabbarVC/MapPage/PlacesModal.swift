//
//  PlacesModal.swift
//  AccessTokenApi
//
//  Created by Kullanici on 23.08.2023.
//

import Foundation

struct PlacesData: Codable {
    var data: Places
    var status: String
}
struct Places: Codable {
    var count: Int
    var places: [PlaceItem]
}

struct PlaceItem: Codable {
    let id: String
    let creator: String
    let place: String
    let title: String
    let description: String?
    let cover_image_url: String?
    let latitude: Double
    let longitude: Double
    let created_at: String
    let updated_at: String
}


