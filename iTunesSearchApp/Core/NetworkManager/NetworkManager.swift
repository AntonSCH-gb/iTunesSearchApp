//
//  NetworkManager.swift
//  iTunesSearchApp
//
//  Created by Anton Scherbaev on 29.04.2021.
//

import Foundation
import Alamofire

final class NetworkManager {
    
    typealias DataCompletion = (Result<Data, AFError>) -> Void
    typealias JSONCompletion = (Result<[String: Any]?, AFError>) -> Void
    
    func dataRequest (_ request: WebRequest, then completion: DataCompletion?) {
            AF.request(request.url, method: request.method, parameters: request.parameters).validate().responseData { [weak self] response in
                
            switch response.result {
            
            case let .success(data):
                completion?(.success(data))
                
            case let .failure(error):
                self?.logError(error, request: request)
                
            }
        }
    }
    
    func jsonRequest (_ request: WebRequest, then completion: JSONCompletion?) {
        AF.request(request.url, method: request.method, parameters: request.parameters).validate().responseJSON { [weak self] response in
            switch response.result {
            
            case let .success(json):
                completion?(.success(json as? [String: Any]))
                
            case let .failure(error):
                self?.logError(error, request: request)
                
            }
        }
    }
    

    private func logError(_ error: Error, request: WebRequest) {
        print("Error while executing request \(request.url), error: \(error.localizedDescription)")
    }
    
}

