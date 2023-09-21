//
//  NavigationHelper.swift
//  AccessTokenApi
//
//  Created by Kullanici on 23.08.2023.
//

import UIKit
import JWTDecode
class NavigationHelper {

    func goToVC() -> UIViewController {
        let token = getTokenFromChain()
        let status = isTokenExpired(jwtToken: token)
        
        if status {
            return LoginVC()
        } else {
            return MainTabBarController()
        }
    }
    func isTokenExpired(jwtToken: String) -> Bool {
        if jwtToken == "" {
            return true
        }
        do {
            let jwt = try decode(jwt: jwtToken)
            if let expirationDate = jwt.expiresAt {
                return expirationDate < Date()
            }
            return false
        } catch {
            return false
        }
    }
    
    func getTokenFromChain()->String {
        guard let token = KeychainHelper.shared.read(service: "access-token", account: "api.Iosclass") else {return""}
        guard let tokenstr = String(data: token, encoding: .utf8) else {return""}
        return tokenstr
    }
    
}
