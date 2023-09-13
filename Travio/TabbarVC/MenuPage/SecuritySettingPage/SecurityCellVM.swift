//
//  SecurityCellVM.swift
//  AccessTokenApi
//
//  Created by Kullanici on 5.09.2023.
//

import Foundation
import AVFoundation
import Photos
import CoreLocation
import UIKit

class SecurityCellVM {
    let locationManager = CLLocationManager()
   
    
    func checkLibraryPermission() {
        let authorizationStatus = PHPhotoLibrary.authorizationStatus()
        var isLibraryPermissionGranted = false
        switch authorizationStatus {
        case .authorized:
            isLibraryPermissionGranted = true
        default:
            break
        }

        UserDefaults.standard.set(isLibraryPermissionGranted, forKey: "LibraryPermission")
       
    }
    
   
    
    func checkLocationPermission() {
        let authorizationStatus = CLLocationManager.authorizationStatus()
        var isLocationPermissionGranted = false
        switch authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            isLocationPermissionGranted = true
        default:
            break
        }
        UserDefaults.standard.set(isLocationPermissionGranted, forKey: "LocationPermission")
    
    }
  

    func checkCameraPermission() {
        let authorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
        var isCameraPermissionGranted = false
        switch authorizationStatus {
        case .authorized:
            isCameraPermissionGranted = true
        default:
            break
        }
        UserDefaults.standard.set(isCameraPermissionGranted, forKey: "CameraPermission")
     
    }
    
    func setPermissionToggle(forKey: String) -> Bool {
        let isPermissionGranted = UserDefaults.standard.bool(forKey: forKey)
        return isPermissionGranted
    }
    
    func openAppSettings() {
        if let appSettingsURL = URL(string: UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(appSettingsURL) {
                UIApplication.shared.open(appSettingsURL, options: [:], completionHandler: nil)
            }
        }
    }
}
