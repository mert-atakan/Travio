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
    func uploadImage(images: [Data]) {
        apiService.uploadImage(route: Router.upload(image: images)) { (result:Result<UploadResponse,Error>) in
            switch result {
            case .success(let success):
                self.urlArrays = success.urls
                //url geldi. ilk görseli post place olarak atayacagız.
                guard let urlArrays = self.urlArrays else { return}

                self.body?["cover_image_url"] = urlArrays.first
                self.addTravel(body: self.body ?? ["":""])
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    
    func addTravel(body: [String:Any]) {
        apiService.makeRequest(urlConvertible: Router.postPlace(params: body)) {
            (result:Result<AddTravelResponse,Error>) in
          
            switch result {
            case .success(let success):
                let id = success.message
                //message ile id geldi. çünkü id message içine kaydedilmiş. url arrayinin geri kalan değerlerini for döngüsüyle gallery'e atayacagız.
                guard let urlArrays = self.urlArrays else {return}
                
                for url in urlArrays {
                    var body = [String:Any]()
                    body["place_id"] = id
                    body["image_url"] = url
                    self.addGallery(body: body)
                }
                
                guard let dismiss = self.dismiss else {return}
                dismiss()
                
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func addGallery(body:[String:Any]) {
        print(body)
        apiService.makeRequest(urlConvertible: Router.postGallery(params: body)) { (result:Result<GalleryResponse,Error>) in
            switch result {
            case .success(let success):
                print(success.message)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
   
}
