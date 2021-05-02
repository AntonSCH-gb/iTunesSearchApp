//
//  iTunesSearchResult.swift
//  iTunesSearchApp
//
//  Created by Anton Scherbaev on 30.04.2021.
//

import Foundation

import Foundation

struct ITunesSearchResult<Element: Codable>: Codable {
    let resultCount: Int
    let results: [Element]
}
