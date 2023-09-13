//
//  MenuVM.swift
//  AccessTokenApi
//
//  Created by Kaan Acikgoz on 31.08.2023.
//

import Foundation
import UIKit

class MenuVM {
    
    let collectionViewCellsLabels = ["Security Settings", "App Defaults", "My Added Places", "Help&Support", "About", "Terms of Use"]
    
    let collectionViewCellsLeftImages = [#imageLiteral(resourceName: "s"), #imageLiteral(resourceName: "Settings1"), #imageLiteral(resourceName: "Settings2"), #imageLiteral(resourceName: "s 1"), #imageLiteral(resourceName: "Settings3"), #imageLiteral(resourceName: "Settings4")]
    
    let collectionViewCellsRightImages = [#imageLiteral(resourceName: "Vector-5"), #imageLiteral(resourceName: "Vector-5"), #imageLiteral(resourceName: "Vector-5"), #imageLiteral(resourceName: "Vector-5"), #imageLiteral(resourceName: "Vector-5"), #imageLiteral(resourceName: "Vector-5")]
    
    let apiService: ApiServiceProtocol

    init(apiService: ApiServiceProtocol = ApiService()){
        self.apiService = apiService
    }
    
    var onDataFetch: ((Bool) -> Void)?
    
    func getLabelForRow(indexpath: IndexPath) -> String {
        return collectionViewCellsLabels[indexpath.row]
    }
    
    func getLeftImageForRow(indexpath: IndexPath) -> UIImage {
        return collectionViewCellsLeftImages[indexpath.row]
    }
    
    func getRightImageForRow(indexpath: IndexPath) -> UIImage {
        return collectionViewCellsRightImages[indexpath.row]
    }
    
    func getUserInfo(handler: @escaping ((User)->())) {
        self.onDataFetch?(true)
        apiService.makeRequest(urlConvertible: Router.me) { (result:Result<User,ErrorResponse>) in
            switch result {
            case .success(let success):
              handler(success)
                self.onDataFetch?(false)
            case .failure(let failure):
                print(failure.localizedDescription)
                self.onDataFetch?(false)
            }
        }
    }
    
    

    
}
