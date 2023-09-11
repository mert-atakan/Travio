//
//  RegisterVM.swift
//  AccessTokenApi
//
//  Created by Kullanici on 18.08.2023.
//

import Foundation
import UIKit

class RegisterVM {
    
    let apiService: ApiServiceProtocol
    
    init(apiService: ApiServiceProtocol = ApiService()){
        self.apiService = apiService
    }
    
    func register(params: [String:String], handler: @escaping ((RegisterResponse)->())  ) {
        apiService.objectRequest(urlConvertible: Router.register(params: params)) { (result:(Result<RegisterResponse,ErrorResponse>)) in
            
            switch result {
            case .success(let success):
                handler(success)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func updateLoginButtonState(isEmail: Bool, isUsername: Bool, isPassword: Bool, isPassword2: Bool, password1Text: String, password2Text:String) -> Bool {
        
        if isEmail && isUsername && isPassword && isPassword2 && password1Text == password2Text{
            return true
        } else {
            return false
        }
    }
    
    
}
