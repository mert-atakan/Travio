//
//  AddTravelVM.swift
//  AccessTokenApi
//
//  Created by Kullanici on 19.08.2023.
//

import Foundation
import UIKit
import Alamofire

class AddTravelVM {
    
    let apiService: ApiServiceProtocol
    
    init(apiService: ApiServiceProtocol = ApiService()){
        self.apiService = apiService
    }
    var body: [String:Any]?
    var urlArrays: [String]?
    
    var dismiss: (()->())?
    func uploadImage(images: [Data], callback: @escaping ((Bool,String?)->Void)) {
        apiService.uploadImage(route: Router.upload(image: images)) { (result:Result<UploadResponse,ErrorResponse>) in
            switch result {
            case .success(let success):
                self.urlArrays = success.urls
                guard let urlArrays = self.urlArrays else { return}
                
                self.body?["cover_image_url"] = urlArrays.first
                self.addTravel(body: self.body ?? ["":""]) { status, message in
                    AlertHelper.showAlert(in: AddTravelVC(), title: .sorry, message: message, primaryButtonTitle: .ok, primaryButtonAction: nil, secondaryButtonTitle: nil, secondaryButtonAction: nil)
                }
                callback(true,nil)
            case .failure(let failure):
                callback(false,failure.message)
            }
        }
    }
    
    
    func addTravel(body: [String:Any], callback: @escaping ((Bool,String?)->Void)) {
        apiService.makeRequest(urlConvertible: Router.postPlace(params: body)) {
            (result:Result<AddTravelResponse,ErrorResponse>) in
            
            switch result {
            case .success(let success):
                let id = success.message
                guard let urlArrays = self.urlArrays else {return}
                
                for url in urlArrays {
                    
                    var body = [String:Any]()
                    body["place_id"] = id
                    body["image_url"] = url
                    self.addGallery(body: body) { status,message in
                        AlertHelper.showAlert(in: AddTravelVC(), title: .sorry, message: message, primaryButtonTitle: .ok)
                    }
                    
                }
                
                guard let dismiss = self.dismiss else {return}
                dismiss()
                
            case .failure(let failure):
                callback(false,failure.message)
            }
        }
    }
    
    func addGallery(body:[String:Any], callback: @escaping ((Bool,String?)->Void)) {
        apiService.makeRequest(urlConvertible: Router.postGallery(params: body)) { (result:Result<GalleryResponse,ErrorResponse>) in
            switch result {
            case .success(_):
                callback(true,nil)
            case .failure(let failure):
                callback(false,failure.message)
            }
        }
    }
    
}
