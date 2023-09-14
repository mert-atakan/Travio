//
//  NavigationHelper.swift
//  AccessTokenApi
//
//  Created by Kullanici on 23.08.2023.
//

import UIKit
import JWTDecode
class NavigationHelper: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let token = getTokenFromChain()
        let status = isTokenExpired(jwtToken: token)
        
        if status {
            navigationController?.pushViewController(LoginVC(), animated: true)
        } else {
            navigationController?.pushViewController(MainTabBarController(), animated: true)
        }
        
        
    }
    
    func isTokenExpired(jwtToken: String) -> Bool {
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
