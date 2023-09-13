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
    
    func register(params: [String:String], handler: @escaping ((Bool,String)->())  ) {
        apiService.objectRequest(urlConvertible: Router.register(params: params)) { (result:(Result<RegisterResponse,ErrorResponse>)) in
            
            switch result {
            case .success(let success):
                handler(true,success.message)
            case .failure(let error):
                handler(false,error.message)
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
