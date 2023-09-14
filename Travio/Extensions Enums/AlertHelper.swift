//
//  AlertHelper.swift
//  AccessTokenApi
//
//  Created by Mert Atakan on 8.09.2023.
//

import Foundation
import UIKit

class AlertHelper {
   
        static func showAlert(
            in viewController: UIViewController,
            title: AlertTitle?,
            message: String?,
            primaryButtonTitle: AlertButton,
            primaryButtonAction: (() -> Void)? = nil,
            secondaryButtonTitle: AlertButton? = nil,
            secondaryButtonAction: (() -> Void)? = nil
        ) {
            let alertController = UIAlertController(title: title?.rawValue, message: message, preferredStyle: .alert)
            
            let primaryAction = UIAlertAction(title: primaryButtonTitle.rawValue, style: .default) { _ in
                primaryButtonAction?()
            }
            
            alertController.addAction(primaryAction)
            
            if let secondaryTitle = secondaryButtonTitle {
                let secondaryAction = UIAlertAction(title: secondaryTitle.rawValue, style: .default) { _ in
                    secondaryButtonAction?()
                }
                alertController.addAction(secondaryAction)
            }
            
            viewController.present(alertController, animated: true, completion: nil)
        }
}

enum AlertTitle: String {
    case congrats = "Congrats!"
    case sorry = "We are sorry."
    case error = "An error occurred."
    case information = "Information"
}

enum AlertButton: String {
    case ok = "Ok"
    case no = "No"
    case yes = "Yes"
    case goToLogin = "Go To Login Page"
}
