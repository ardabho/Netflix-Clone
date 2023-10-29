//
//  YoutubeSearchResponse.swift
//  netflix
//
//  Created by ARDA BUYUKHATIPOGLU on 29.10.2023.
//

import Foundation

// MARK: - Welcome
struct YoutubeSearchResponse: Codable {
    let items: [Item]
}

// MARK: - Item
struct Item: Codable {
    let id: ID
}

// MARK: - ID
struct ID: Codable {
    let kind, videoId: String
}

