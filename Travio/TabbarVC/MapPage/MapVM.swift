//
//  MapVM.swift
//  AccessTokenApi
//
//  Created by Kullanici on 22.08.2023.
//

import Foundation

class MapVM {
    
    let apiService: ApiServiceProtocol
    
    init(apiService: ApiServiceProtocol = ApiService()){
        self.apiService = apiService
    }
    
    var placeItems : [PlaceItem]? {
        didSet {
            self.reloadCell!()
        }
    }
    
    var fillMapp: (([PlaceItem])->Void)?
    
    var reloadCell: (()->Void)?
    
    func getLocations(callback: @escaping ((Bool,String?)-> Void)) {
        apiService.makeRequest(urlConvertible: Router.places) { (result:Result<PlacesData,ErrorResponse>) in
            switch result {
            case .success(let success):
                self.placeItems = success.data.places
                
               guard let placeItems = self.placeItems else { return }
                guard let fillMapp = self.fillMapp else { return }
                fillMapp(placeItems)
                callback(true,nil)
            case .failure(let failure):
                callback(false,failure.message)
            }
        }
    }
    
    
    
    
    //MARK: - DataSource Functions
    func NumberOfRows()-> Int {
        return placeItems.ifNil([]).count
    }
    
    func getObjectForRow(indexpath: IndexPath) -> PlaceItem? {
        guard let placeItems = placeItems else { return nil }

        return placeItems[indexpath.row]

    }
    
    func getAllArray() -> [String]? {
        guard let placeItems = placeItems else { return nil }
        var titleArray = [String]()
        for place in placeItems {
            titleArray.append(place.title)
        }
        return titleArray
    }
    
}
