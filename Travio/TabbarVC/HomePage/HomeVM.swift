//
//  HomeVM.swift
//  AccessTokenApi
//
//  Created by Kullanici on 1.09.2023.
//

import Foundation
class HomeVM {
    
    let apiService: ApiServiceProtocol
    
    init(apiService: ApiServiceProtocol = ApiService()){
        self.apiService = apiService
    }
    
    let sectionNames = ["Popular Places", "New Places", "My Visited Places"]
    
    func getHeaderNameForSection(section:Int) -> String {
        return sectionNames[section]
    }
    
    var popularPlaces: [PlaceItem]?
    var newPlaces: [PlaceItem]?
    var myVisits: [PlaceItem]?
    var myTravels: [Visits]? {
        didSet {
            myVisits = convertPlaceItemArray(visitsArray: myTravels!)
            guard let closure = closure, let myVisits = myVisits else {return}
            closure(myVisits)
        }
    }
    
    var closure: (([PlaceItem])->())?
    
    func convertPlaceItemArray(visitsArray: [Visits]) -> [PlaceItem] {
        var array = [PlaceItem]()
        for visit in visitsArray {
            array.append(visit.place)
        }
        return array
    }
    
    func getPopularPlaces(handler: @escaping ((Bool,String?)->())) {
        apiService.makeRequest(urlConvertible: Router.getPopularPlaces(limit: 5)) { (result:Result<PlacesData,ErrorResponse>) in
            switch result {
            case .success(let success):
                self.popularPlaces = success.data.places
                handler(true,nil)
            case .failure(let failure):
                handler(false,failure.message)
            }
        }
    }
    
    func getLastPlaces(handler: @escaping ((Bool,String?)->())) {
        apiService.makeRequest(urlConvertible: Router.getLastPlaces(limit: 5)) { (result:Result<PlacesData,ErrorResponse>) in
            switch result {
            case .success(let success):
                self.newPlaces = success.data.places
                handler(true,nil)
            case .failure(let failure):
                handler(false,failure.message)
            }
        }
    }
    
    func getMyVisits(handler: @escaping ((Bool,String?)->())) {
        apiService.makeRequest(urlConvertible: Router.myAllVisits(limit: 5)) { (result:Result<TravelData,ErrorResponse>) in
            switch result {
            case .success(let success):
                self.myTravels = success.data.visits
                handler(true,nil)
            case .failure(let failure):
                handler(false,failure.message)
            }
        }
    }
    
    func convertPlaceItemArray(visitsArray: [Visits]) {
        for visit in visitsArray {
            myVisits?.append(visit.place)
        }
    }
    
}

