//
//  WebRequest.swift
//  iTunesSearchApp
//
//  Created by Anton Scherbaev on 29.04.2021.
//

import Foundation
import Alamofire

struct WebRequest {
    var method: HTTPMethod
    var url: String
    var parameters: Parameters
}

extension WebRequest: CustomStringConvertible {
    var description: String {
        return "Web request method: \(method.rawValue), URL: \(url), paramrters: \(parameters)"
    }
}
