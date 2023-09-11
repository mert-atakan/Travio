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
    
    var statusAlert: ((String)->())?
    var configureUserInfo: ((User)->())?
    var onDataFetch: ((Bool) -> Void)?
    
    func getUserInfo() {
        self.onDataFetch?(true)
        apiService.makeRequest(urlConvertible: Router.me) { (result:Result<User,Error>) in
            switch result {
            case .success(let success):
                guard let configureUserInfo = self.configureUserInfo else { return }
                configureUserInfo(success)
                print(success)
                self.onDataFetch?(false)
            case .failure(let failure):
                print(failure.localizedDescription)
                self.onDataFetch?(false)
            }
        }
    }
    
    
    func uploadPhoto(images: [Data]) {
        apiService.uploadImage(route: Router.upload(image: images)) { (result:Result<UploadResponse,Error>) in
            switch result {
            case .success(let success):
                guard let url = success.urls.first else {return}
                self.imageUrl = url
                print(url)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func editProfile(body: [String:String]) {
        print(body)
        apiService.makeRequest(urlConvertible: Router.editProfile(params: body)) { (result:Result<ProfileResponse,Error>) in
            switch result {
            case .success(let success):
                print(success)
                guard let statusAlert = self.statusAlert else {return}
                statusAlert(success.status)
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
