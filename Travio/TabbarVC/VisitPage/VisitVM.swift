//
//  VisitVM.swift
//  AccessTokenApi
//
//  Created by Kullanici on 21.08.2023.
//

import Foundation

class VisitVM {
    let apiService: ApiServiceProtocol
    
    init(apiService: ApiServiceProtocol = ApiService()){
        self.apiService = apiService
    }
    
    var travelArray: [Visits]?
    var onDataFetch: ((Bool) -> Void)?
    
    func fetchTravels(callback: @escaping ()->Void) {
        self.onDataFetch?(true)
        apiService.makeRequest(urlConvertible: Router.myAllVisits(limit: nil)) { (result:Result<TravelData,Error>) in
            switch result {
            case .success(let success):
                self.travelArray = success.data.visits
                callback()
                self.onDataFetch?(false)
            case .failure(let failure):
                print(failure)
                self.onDataFetch?(false)
            }
        }
    }
    
    //MARK: - DataSource
    
    func getNumberOfRowsInSection() -> Int {
        guard let travelArray = travelArray else {return 0 }
        return travelArray.count
    }
    
    func getObjectForRowAt(indexpath: IndexPath) -> Visits? {
        guard let travelArray = travelArray else {  return nil  }
        return travelArray[indexpath.row]
    }
}
