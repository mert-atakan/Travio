//
//  SecuritySettingsVM.swift
//  AccessTokenApi
//
//  Created by Kullanici on 1.09.2023.
//

import Foundation
import AVFoundation
import Photos
import CoreLocation

class SecuritySettingsVM {
    
    let apiService: ApiServiceProtocol
    
    init(apiService: ApiServiceProtocol = ApiService()){
        self.apiService = apiService
    }
    var statusAlert: ((String)->())?
    let settingsArray = [["New Password", "New Password Confirm"], ["Camera","Photo Library","Location"]]
    
    func changePassword(password:[String:String]) {
        apiService.makeRequest(urlConvertible: Router.changePassword(params: password)) { (result:Result<PasswordResponse,Error>) in
            switch result {
            case .success(let success):
                let value = success.status
                guard let statusAlert = self.statusAlert else {  return }
                statusAlert(value)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
}
