

import Foundation


class SeeAllPlacesVM {
    
    private var placeArray = [PlaceItem]()
   
    var place:String?
    
    let apiService: ApiServiceProtocol
    
    init(apiService: ApiServiceProtocol = ApiService()){
        self.apiService = apiService
    }
    

func getPlaces (callback: @escaping (Bool,String?)->Void) {
    DispatchQueue.global().async { [self] in
        let router: Router
        switch self.place {
        case "popularPlaces":
            router = Router.getPopularPlaces(limit: nil)
        case "myVisits":
            router = Router.myAllVisits(limit: nil)
        case "newPlaces":
            router = Router.getLastPlaces(limit: nil)
        case "myAddedPlaces":
            router = Router.getAddedPlaces
        default:
            fatalError("Invalid place value")
        }
        
        if self.place == "myVisits" {
            apiService.makeRequest(urlConvertible: router) { (result:Result<TravelData,ErrorResponse>) in
                switch result {
                case .success(let data):
                    for visit in data.data.visits {
                        self.placeArray.append(visit.place)
                    }
                        callback(true,nil)
                case .failure(let failure):
                    callback(false,failure.message)
                }
            }
        } else {
            
            apiService.makeRequest(urlConvertible: router) { (result:Result<PlacesData,ErrorResponse>) in
                switch result {
                case .success(let data):
                    self.placeArray = data.data.places
                    callback(true,nil)
                case .failure(let failure):
                    callback(false,failure.message)
                }
            }
        }
        
        
       
        
    }
}

    func getPlacesIndex(index:Int) -> PlaceItem {
        return placeArray[index]
    }

    func countOfPlaces() -> Int {
        return placeArray.count
    }


    func sortArray (ascending:Bool) {
        if ascending {
            placeArray = placeArray.sorted { $0.title.lowercased() < $1.title.lowercased() }
        } else {
            placeArray = placeArray.sorted { $0.title.lowercased() > $1.title.lowercased() }
        }
    }

    func setTitle() -> String {
        if place == "popularPlaces" {
            return "Popular Places"
        } else if place == "myVisits"{
            return "My Visits"
        } else if place == "newPlaces" {
            return "New Places"
        } else if place == "myAddedPlaces"{
            return "My Added Places"
        }
        return ""
    }
    

}
