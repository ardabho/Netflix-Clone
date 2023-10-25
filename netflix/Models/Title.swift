// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let trendingMovieResponse = try? JSONDecoder().decode(TrendingMovieResponse.self, from: jsonData)

import Foundation

// MARK: - TrendingMovieResponse
struct TitleResponse: Codable {
    let results: [Title]
}

// MARK: - Movie
struct Title: Codable {
    let id: Int
    let media_type: String?
    let original_name: String?
    let original_title: String?
    let poster_path: String?
    let overeview: String?
    let vote_count: Int
    let release_date: String?
    let vote_average: Double
}
