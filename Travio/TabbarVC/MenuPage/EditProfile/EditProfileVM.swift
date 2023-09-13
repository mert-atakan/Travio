//
//  EditProfileVM.swift
//  AccessTokenApi
//
//  Created by Kullanici on 5.09.2023.
//

import Foundation

class EditProfileVM {
    
    let apiService: ApiServiceProtocol

    init(apiService: ApiServiceProtocol = ApiService()){
        self.apiService = apiService
    }

   
    var body:[String:String]?
    var imageUrl: String?
    var userInfos: [String:String]?
    
    var onDataFetch: ((Bool) -> Void)?
    
    func getUserInfo(handler: @escaping ((User))->()) {
        self.onDataFetch?(true)
        apiService.makeRequest(urlConvertible: Router.me) { (result:Result<User,ErrorResponse>) in
            switch result {
            case .success(let success):
                handler(success)
                self.onDataFetch?(false)
            case .failure(let failure):
                print(failure.localizedDescription)
                self.onDataFetch?(false)
            }
        }
    }
    
    
    func uploadPhoto(images: [Data]) {
        apiService.uploadImage(route: Router.upload(image: images)) { (result:Result<UploadResponse,ErrorResponse>) in
            switch result {
            case .success(let success):
                guard let url = success.urls.first else {return}
                self.imageUrl = url
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func editProfile(body: [String:String], handler: @escaping ((String)->())) {
        apiService.makeRequest(urlConvertible: Router.editProfile(params: body)) { (result:Result<ProfileResponse,ErrorResponse>) in
            switch result {
            case .success(let success):
                handler(success.status)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func getImageUrl() -> String {
        guard let imageUrl = imageUrl else { return "" }

        return imageUrl
    }
}
