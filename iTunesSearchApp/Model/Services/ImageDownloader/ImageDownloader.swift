//
//  ImageDownloader.swift
//  iTunesSearchApp
//
//  Created by Anton Scherbaev on 30.04.2021.
//

import Foundation
import Alamofire

typealias DownloadImageCompletion = (_ image: UIImage?, _ error: Error?) -> Void

final class ImageDownloader {
    
    func getImage(fromUrl url: URLConvertible, completion: @escaping DownloadImageCompletion) {
        
        AF.request(url).response(completionHandler: { (dataResponse) in
            if let error = dataResponse.error {
                completion(nil, error)
                return
            }
            
            guard let imageData = dataResponse.data else {
                let errorUserInfo = [NSLocalizedDescriptionKey: "Ошибка: нет данных"]
                let error = NSError(domain:"Image", code:401, userInfo:errorUserInfo)
                completion(nil, error)
                
                return
            }
            
            guard let image = UIImage(data: imageData, scale: 1.0) else {
                let errorUserInfo = [NSLocalizedDescriptionKey: "Ошибка конвертирования данных в изображение"]
                let error = NSError(domain:"Image", code:401, userInfo:errorUserInfo)
                completion(nil, error)
                
                return
            }
            
            completion(image, nil)
        })
    }
}
