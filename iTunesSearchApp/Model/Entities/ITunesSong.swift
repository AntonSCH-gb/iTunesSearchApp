//
//  ITunesSong.swift
//  iTunesSearchApp
//
//  Created by Anton Scherbaev on 30.04.2021.
//

import Foundation

struct ITunesSong: Codable {
    
    public var trackName: String
    public var artistName: String?
    public var collectionName: String?
    public var artwork: String?
    
    private enum CodingKeys: String, CodingKey {
        case trackName = "trackName"
        case artistName = "artistName"
        case collectionName = "collectionName"
        case artwork = "artworkUrl100"
    }

    init(trackName: String,
                  artistName: String?,
                  collectionName: String?,
                  artwork: String?) {
        self.trackName = trackName
        self.artistName = artistName
        self.collectionName = collectionName
        self.artwork = artwork
    }
}
