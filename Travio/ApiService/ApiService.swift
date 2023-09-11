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
    func makeRequest<T:Codable>(urlConvertible:Router,handler: @escaping (Result<T,Error>) -> Void)
    func uploadImage<T:Codable>(route:Router, callback: @escaping (Result<T,Error>) -> Void)
}

class ApiService:ApiServiceProtocol {
    func uploadImage<T>(route: Router, callback: @escaping (Result<T, Error>) -> Void) where T : Decodable, T : Encodable {
        let request: URLRequestConvertible = route
        AF.upload(multipartFormData: route.multipartFormData, with: request).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    callback(.success(decodedData))
                } catch {
                    callback(.failure(error))
                }
            case .failure(let error):
                callback(.failure(error))
            }
        }
    }
    
    func makeRequest<T:Codable>(urlConvertible: Router, handler: @escaping (Result<T, Error>) -> Void) {
        DispatchQueue.global(qos: .utility).async {
            AF.request(urlConvertible).responseDecodable(of:T.self) { response  in
                switch response.result {
                case .success:
                    if let data = response.data {
                        do {
                            let decodedData = try JSONDecoder().decode(T.self, from: data)
                            DispatchQueue.main.async {
                                handler(.success(decodedData as! T))
                            }
                        } catch {
                            print("Error: \(error)")
                        }
                    }
                case .failure(let error):
                    print(error)
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
                        handler(.success(decodedData as! T))
                    } catch {
                        print("Error: \(error)")
                    }
                }
            case .failure(let error):
                if let data = response.data {
                    do {
                        let decodedData = try JSONDecoder().decode(ErrorResponse.self, from: data)
                        handler(.failure(decodedData as! ErrorResponse))
                    } catch {
                        print("Error: \(error)")
                    }
                }
            }
        }
    }
}



