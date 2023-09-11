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
            title: String?,
            message: String?,
            primaryButtonTitle: String,
            primaryButtonAction: (() -> Void)? = nil,
            secondaryButtonTitle: String? = nil,
            secondaryButtonAction: (() -> Void)? = nil
        ) {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            let primaryAction = UIAlertAction(title: primaryButtonTitle, style: .default) { _ in
                primaryButtonAction?()
            }
            
            alertController.addAction(primaryAction)
            
            if let secondaryTitle = secondaryButtonTitle {
                let secondaryAction = UIAlertAction(title: secondaryTitle, style: .default) { _ in
                    secondaryButtonAction?()
                }
                alertController.addAction(secondaryAction)
            }
            
            viewController.present(alertController, animated: true, completion: nil)
        }
}
