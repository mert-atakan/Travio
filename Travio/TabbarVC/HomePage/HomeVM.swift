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
    
    func getPopularPlaces(handler: @escaping (()->())) {
        apiService.makeRequest(urlConvertible: Router.getPopularPlaces(limit: 5)) { (result:Result<PlacesData,ErrorResponse>) in
            switch result {
            case .success(let success):
                self.popularPlaces = success.data.places
                handler()
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }

    func getLastPlaces(handler: @escaping (()->())) {
        apiService.makeRequest(urlConvertible: Router.getLastPlaces(limit: 5)) { (result:Result<PlacesData,ErrorResponse>) in
            switch result {
            case .success(let success):
                self.newPlaces = success.data.places
                handler()
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }

    func getMyVisits(handler: @escaping (()->())) {
        apiService.makeRequest(urlConvertible: Router.myAllVisits(limit: 5)) { (result:Result<TravelData,ErrorResponse>) in
            switch result {
            case .success(let success):
                self.myTravels = success.data.visits
              handler()
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }

    func convertPlaceItemArray(visitsArray: [Visits]) {
        for visit in visitsArray {
            myVisits?.append(visit.place)
        }
    }

  
}














//    var myVisitsArray: [PlaceItem]? {
//        didSet {
//            guard let reloadCollection = reloadCollection else {return}
//            reloadCollection()
//        }
//    }

//    {
//        didSet {
//            guard let reloadCollection = reloadCollection, let popularPlaces = popularPlaces else {return}
//            reloadCollection(popularPlaces)
//        }
//    }
    
   
//    {
//        didSet {
//            guard let reloadCollection = reloadCollection,let lastPlaces = lastPlaces else {return}
//            reloadCollection(lastPlaces)
//        }
//    }
    
    //var reloadCollection: (([PlaceItem])->())?
  
    
//    func getAddedPlaces(handler:(()->())) {
//        apiService.makeRequest(urlConvertible: Router.getMyAddedPlaces(limit: 5)) { (result:Result<PlacesData,Error>) in
//            switch result {
//            case .success(let success):
//                let value = success.data.places
//                self.myVisitsArray = value
//
//            case .failure(let failure):
//                print(failure.localizedDescription)
//            }
//        }
//    }
