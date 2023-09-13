//
//  DetailVM.swift
//  AccessTokenApi
//
//  Created by Kullanici on 17.08.2023.
//

import Foundation
import Alamofire
import UIKit


class DetailVM {
    
    var placeId:String?
    
    let apiService: ApiServiceProtocol
    
    init(apiService: ApiServiceProtocol = ApiService()){
        self.apiService = apiService
    }
    
    var galleryImagesItem: [ImageItem]?
    
    
    
    func getVisit(callback: @escaping (Place?,Bool,String?)->Void) {
        guard let placeId = placeId else { return }
        apiService.makeRequest(urlConvertible: Router.getVisitInfo(placeId: placeId)) { (result:Result<PlaceData,ErrorResponse>) in
            switch result {
            case .success(let data):
                callback(data.data.place,true,nil)
            case .failure(let failure):
                callback(nil,false,failure.message)
            }
        }
    }
    
    func getGalleryItems(callback: @escaping (Bool,String?) -> Void) {
        guard let placeId = placeId else { return }
        
        self.apiService.makeRequest(urlConvertible: Router.galleryID(placeId: placeId)) { (result:Result<GalleryData,ErrorResponse>) in
            switch result {
            case .success(let success):
                self.galleryImagesItem = success.data.images
                callback(true,nil)
            case .failure(let failure):
                callback(false,failure.message)
            }
        }
        
    }
    
    func deleteVisitItem(callback: @escaping ()->Void) {
        guard let placeId = placeId else { return }
        
        self.apiService.makeRequest(urlConvertible: Router.deletePlace(placeId: placeId)) { (result:Result<DefaultResponse,ErrorResponse>) in
            switch result {
            case .success(_):
                callback()
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    
    func checkVisit(callback: @escaping (Bool)->Void) {
        guard let placeId = placeId else { return }
        print(placeId)
        self.apiService.makeRequest(urlConvertible: Router.checkVisit(placeId: placeId)) { (result:Result<DefaultResponse,ErrorResponse>) in
            switch result {
            case .success(let data):
                if data.status == "success"{
                    callback(true)
                } else if data.status == "error" {
                    callback(false)
                }
            case .failure(_):
                break
            }
        }
    }
    
    
    func postVisit(callback: @escaping (Bool, String?)->Void) {
        guard let placeId = placeId else { return }
        let param = ["place_id": placeId,
                     "visited_at": "2023-08-10T00:00:00Z"]
        apiService.makeRequest(urlConvertible: Router.postVisit(params: param)) { (result:Result<DefaultResponse,ErrorResponse>) in
            switch result {
            case .success(_):
                callback(true,nil)
            case .failure(let failure):
                callback(false,failure.message)
            }
        }
    }
    
    
    
    //MARK: - Datasource Fonksiyonları
    func getNumberOfRowsInSection() -> Int{
        guard let galleryImagesItem = galleryImagesItem else { return 0 }
        return galleryImagesItem.count
    }
    
    func getCellForRowAt(indexpath: IndexPath) -> ImageItem? {
        guard let galleryImagesItem = galleryImagesItem else { return nil }
        let value = galleryImagesItem[indexpath.row]
        return value
    }
    
}
