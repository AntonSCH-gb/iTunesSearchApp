//
//  ITunesApp.swift
//  iTunesSearchApp
//
//  Created by Anton Scherbaev on 29.04.2021.
//

import Foundation

struct ITunesApp: Codable {
    
    typealias Bytes = Int
    
    let appName: String
    let appUrl: String?
    let company: String?
    let companyUrl: String?
    let appDescription: String?
    let averageRating: Double?
    let averageRatingForCurrentVersion: Double?
    let size: Bytes?
    let iconUrl: String?
    let screenshotUrls: [String]
    
    private enum CodingKeys: String, CodingKey {
        case appName = "trackName"
        case appUrl = "artistViewUrl"
        case company = "sellerName"
        case companyUrl = "sellerUrl"
        case appDescription = "description"
        case averageRating = "averageUserRating"
        case averageRatingForCurrentVersion = "averageUserRatingForCurrentVersion"
        case size = "fileSizeBytes"
        case iconUrl = "artworkUrl512"
        case screenshotUrls = "screenshotUrls"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.appName = try container.decode(String.self, forKey: .appName)
        self.appUrl = try? container.decode(String.self, forKey: .appUrl)
        self.company = try? container.decode(String.self, forKey: .company)
        self.companyUrl = try? container.decode(String.self, forKey: .companyUrl)
        self.appDescription = try? container.decode(String.self, forKey: .appDescription)
        self.averageRating = try? container.decode(Double.self, forKey: .averageRating)
        self.averageRatingForCurrentVersion = try? container.decode(Double.self, forKey: .averageRatingForCurrentVersion)
        self.size = Bytes((try? container.decode(String.self, forKey: .size)) ?? "0")
        self.iconUrl = try? container.decode(String.self, forKey: .iconUrl)
        self.screenshotUrls = (try? container.decode([String].self, forKey: .screenshotUrls)) ?? []
    }
    
    init(appName: String,
                  appUrl: String?,
                  company: String?,
                  companyUrl: String?,
                  appDescription: String?,
                  averageRating: Double?,
                  averageRatingForCurrentVersion: Double?,
                  size: Bytes?,
                  iconUrl: String?,
                  screenshotUrls: [String]) {
        self.appName = appName
        self.appUrl = appUrl
        self.company = company
        self.companyUrl = companyUrl
        self.appDescription = appDescription
        self.averageRating = averageRating
        self.averageRatingForCurrentVersion = averageRatingForCurrentVersion
        self.size = size
        self.iconUrl = iconUrl
        self.screenshotUrls = screenshotUrls
    }
}
    


