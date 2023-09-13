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
    
    let settingsArray = [["New Password", "New Password Confirm"], ["Camera","Photo Library","Location"]]
    
    func changePassword(password:[String:String], handler: @escaping ((Bool,String?)-> Void)) {
        apiService.makeRequest(urlConvertible: Router.changePassword(params: password)) { (result:Result<PasswordResponse,ErrorResponse>) in
            switch result {
            case .success(_):
                handler(true,nil)
            case .failure(let failure):
                handler(false,failure.message)
            }
        }
    }
    
}
