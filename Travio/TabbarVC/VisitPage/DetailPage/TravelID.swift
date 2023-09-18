

import Foundation

struct PlaceData: Codable {
    var data: PlaceInfo
    var status: String
}

struct PlaceInfo:Codable{
    var place:Place
}

struct Place: Codable {
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
