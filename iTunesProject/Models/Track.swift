//
//  Track.swift
//  iTunesProject
//
//  Created by Артем on 20/03/2019.
//  Copyright © 2019 Gukov.space. All rights reserved.
//
import Foundation

struct Track: Codable {
    let artistName: String
    let trackName: String
    let artworkUrl100: URL
}

struct Tracks: Codable {
    let results: [Track]
}
