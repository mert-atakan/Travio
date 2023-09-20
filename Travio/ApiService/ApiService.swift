//
//  ApiService.swift
//  AccessTokenApi
//
//  Created by Kullanici on 17.08.2023.
//

import Foundation
import Alamofire

protocol ApiServiceProtocol {
    
    func objectRequest<T:Codable>(urlConvertible: Router,handler: @escaping (Result<T,ErrorResponse>) -> Void)
    func makeRequest<T:Codable>(urlConvertible:Router,handler: @escaping (Result<T,ErrorResponse>) -> Void)
    func uploadImage<T:Codable>(route:Router, callback: @escaping (Result<T,ErrorResponse>) -> Void)
}

class ApiService:ApiServiceProtocol {
    func uploadImage<T>(route: Router, callback: @escaping (Result<T, ErrorResponse>) -> Void) where T : Decodable, T : Encodable {
        let request: URLRequestConvertible = route
        AF.upload(multipartFormData: route.multipartFormData, with: request).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    callback(.success(decodedData))
                } catch {
                    callback(.failure(error as! ErrorResponse))
                }
            case .failure(_):
                if let data = response.data {
                    do {
                        let decodedData = try JSONDecoder().decode(ErrorResponse.self, from: data)
                        callback(.failure(decodedData))
                    } catch {
                        callback(.failure(error as! ErrorResponse))
                    }
                }
            }
        }
    }
    
    func makeRequest<T:Codable>(urlConvertible: Router, handler: @escaping (Result<T, ErrorResponse>) -> Void) {
        DispatchQueue.global(qos: .utility).async {
            AF.request(urlConvertible).responseDecodable(of:T.self) { response  in
                switch response.result {
                case .success:
                    if let data = response.data {
                        do {
                            let decodedData = try JSONDecoder().decode(T.self, from: data)
                            DispatchQueue.main.async {
                                handler(.success(decodedData))
                            }
                        } catch {
                            handler(.failure(error as! ErrorResponse))
                        }
                    }
                case .failure( _):
                    if let data = response.data {
                        do {
                            let decodedData = try JSONDecoder().decode(ErrorResponse.self, from: data)
                            handler(.failure(decodedData))
                        } catch {
                            handler(.failure(error as! ErrorResponse))
                        }
                    }
                }
            }
        }
    }
    
    
    func objectRequest<T:Codable>(urlConvertible: Router, handler: @escaping (Result<T, ErrorResponse>) -> Void) {
        AF.request(urlConvertible).responseDecodable(of:T.self) { response  in
            
            switch response.result {
                
            case .success:
                
                if let data = response.data {
                    do {
                        let decodedData = try JSONDecoder().decode(T.self, from: data)
                        handler(.success(decodedData))
                    } catch {
                        handler(.failure(error as! ErrorResponse))
                    }
                }
            case .failure(_):
                if let data = response.data {
                    do {
                        let decodedData = try JSONDecoder().decode(ErrorResponse.self, from: data)
                        handler(.failure(decodedData))
                    } catch {
                        handler(.failure(error as! ErrorResponse))
                    }
                }
            }
        }
    }
}



