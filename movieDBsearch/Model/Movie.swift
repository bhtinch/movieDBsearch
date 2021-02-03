//
//  Movie.swift
//  movieDBsearch
//
//  Created by Benjamin Tincher on 2/2/21.
//

import Foundation

struct Movie: Codable {
    let title: String
    let overview: String
    let vote_average: Double
    let imageURL: URL
}

struct Search: Codable {
    let results: [SearchResult]
    
    struct SearchResult: Codable {
        let title: String
        let overview: String
        let vote_average: Double
        let poster_path: String?
    }
}
