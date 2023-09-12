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

class SecurityCellVM {
    let locationManager = CLLocationManager()
    
    func checkAllPermissions() {
        checkCameraPermission()
        checkLocationPermission()
        checkLibraryPermission()
    }
    
    func checkLibraryPermission() {
        let authorizationStatus = PHPhotoLibrary.authorizationStatus()
        
        var isLibraryPermissionGranted = false

        switch authorizationStatus {
        case .authorized:
            print("Kullanıcı fotoğraf kitaplığı izni verdi.")
            isLibraryPermissionGranted = true
        case .denied:
            print("Kullanıcı fotoğraf kitaplığı izni vermedi.")
        case .restricted:
            print("Fotoğraf kitaplığı izni kısıtlandı.")
        case .notDetermined:
            print("Fotoğraf kitaplığı izni henüz seçilmedi.")
        @unknown default:
            print("Bilinmeyen izin durumu.")
        }

        UserDefaults.standard.set(isLibraryPermissionGranted, forKey: "LibraryPermission")
       
    }
    
   
    
    func checkLocationPermission() {
        let authorizationStatus = CLLocationManager.authorizationStatus()
        var isLocationPermissionGranted = false
        switch authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            print("Kullanıcı konum izni verdi.")
            isLocationPermissionGranted = true
        case .denied:
            print("Kullanıcı konum izni vermedi.")
            isLocationPermissionGranted = false
        case .restricted:
            print("Konum izni kısıtlandı.")
            isLocationPermissionGranted = false
        case .notDetermined:
            print("Konum izni henüz seçilmedi.")
            isLocationPermissionGranted = false
        @unknown default:
            print("Bilinmeyen izin durumu.")
            isLocationPermissionGranted = false
        }
        UserDefaults.standard.set(isLocationPermissionGranted, forKey: "LocationPermission")
    
    }
  

    func checkCameraPermission() {
        let authorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
        var isCameraPermissionGranted = false
        switch authorizationStatus {
        case .authorized:
            print("Kullanıcı kamera izni verdi.")
            isCameraPermissionGranted = true
        case .denied:
            print("Kullanıcı kamera izni vermedi.")
            isCameraPermissionGranted = false
        case .restricted:
            print("Kamera izni kısıtlandı.")
            isCameraPermissionGranted = false
        case .notDetermined:
            print("Kamera izni henüz seçilmedi.")
            isCameraPermissionGranted = false
        @unknown default:
            print("Bilinmeyen izin durumu.")
            isCameraPermissionGranted = false
        }
        UserDefaults.standard.set(isCameraPermissionGranted, forKey: "CameraPermission")
     
    }
    
    func setPermissionToggle(forKey: String) -> Bool {
        let isPermissionGranted = UserDefaults.standard.bool(forKey: forKey)
        return isPermissionGranted
    }
}
