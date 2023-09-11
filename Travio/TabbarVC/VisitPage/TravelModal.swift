//
//  TravelModal.swift
//  AccessTokenApi
//
//  Created by Kullanici on 21.08.2023.
//

import Foundation

struct TravelData: Codable {
    var data: Travel
    var status: String
}
struct Travel: Codable {
    var count: Int
    var visits: [Visits]
}

struct Visits: Codable {
    let id: String
    let place_id: String
    let visited_at: String
    let created_at: String
    let updated_at: String
    let place: PlaceItem
    
}
//struct PlaceItem: Codable {
//    let id: String
//    let creator: String
//    let place: String
//    let title: String
//    let description: String?
//    let cover_image_url: String?
//    let latitude: Double
//    let longitude: Double
//    let created_at: String
//    let updated_at: String
//}


