//
//  Router.swift
//  AccessTokenApi
//
//  Created by Kullanici on 29.08.2023.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    //Auth
    case register(params:Parameters)
    case login(params:Parameters)
    case changePassword(params:Parameters)
    case editProfile(params:Parameters)
    case me
    //Travel
    case upload(image: [Data])
    case myAllVisits(limit:Int?)
    case getVisitInfo(placeId:String)
    case postPlace(params:Parameters)
    case postVisit(params:Parameters)
    case deletePlace(placeId:String)
    case checkVisit(placeId:String)
    // gallery Map
    case galleryID(placeId:String)
    case places
    case postGallery(params:Parameters)
    // seeAllPlaces
    case getPopularPlaces(limit:Int?)
    case getLastPlaces(limit:Int?)
    
    
    var baseURL: URL {
           return URL(string: "https://api.iosclass.live/")!
       }
    
    var path: String {
        switch self {
        case .register:
            return  "v1/auth/register"
        case .login:
            return  "v1/auth/login"
        case .me:
            return  "v1/me"
        case .upload:
            return  "upload"
        case .myAllVisits:
            return  "v1/visits"
        case .checkVisit(let placeId):
            return "v1/visits/user/\(placeId)"
        case .getVisitInfo(let placeId):
            return  "v1/places/" + "\(placeId)"
        case .galleryID(let id):
            return "v1/galleries/" + "\(id)"
        case .places:
            return  "v1/places"
        case .postVisit:
            return "v1/visits"
        case .deletePlace(let placeId):
            return "v1/visits" + "/\(placeId)"
        case .postPlace:
            return  "v1/places"
        case .postGallery:
            return "v1/galleries"
        case .changePassword:
            return "v1/change-password"
        case .editProfile:
            return "v1/edit-profile"
        case .getPopularPlaces:
            return "v1/places/popular"
        case .getLastPlaces:
            return "v1/places/last"
        }
    }
   
    var method: HTTPMethod {
          switch self {
          case .login, .register, .upload,.postPlace, .postGallery, .postVisit :
              return .post
          case .me,.myAllVisits,.places , .galleryID,.getVisitInfo, .getPopularPlaces , .getLastPlaces, .checkVisit :
              return .get
          case .deletePlace:
              return .delete
          case .changePassword, .editProfile:
              return .put
          }
      }
    
    var parameters: Parameters {
            switch self {
            case .login(let params), .register(let params), .postPlace(let params), .postGallery(let params),.postVisit(let params), .editProfile(let params), .changePassword(let params):
                return params
            case .getPopularPlaces(let limit), .getLastPlaces(let limit), .myAllVisits(let limit):
                if let limit = limit {
                    return ["limit": limit]
                }
                return [:]
            default:
                return [:]
            }
        }
    
    var headers: HTTPHeaders {
        switch self {
        case .login, .register, .getPopularPlaces, .getLastPlaces :
            return [:]
        case .upload:
            return ["Content-Type": "multipart/form-data"]
        default:
            return ["Authorization": "Basic \(getTokenFromChain())",
            "Accept": "application/json"]
        }
    }
    
    var multipartFormData: MultipartFormData {
        let formData = MultipartFormData()
        switch self {
        
        case .upload(let imagedata):
            imagedata.forEach { image in
                formData.append(image, withName: "file", fileName: "image.jpg",
                                mimeType: "image/jpeg")
            }
            return formData
        default:
            break
        }
        return formData
    }
    
    func getTokenFromChain()->String {
        guard let token = KeychainHelper.shared.read(service: "access-token", account: "api.Iosclass") else {return""}
        guard let tokenstr = String(data: token, encoding: .utf8) else {return""}
        return tokenstr
    }
    
    
    
    func asURLRequest() throws -> URLRequest {
       
        
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.method = method
        request.headers = headers
        
        let encoding: ParameterEncoding = {
            switch method {
            case .get:
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }()
        
        return try encoding.encode(request, with: parameters)
    }
    
    
}
