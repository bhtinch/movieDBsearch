//
//  NetworkError.swift
//  movieDBsearch
//
//  Created by Benjamin Tincher on 2/2/21.
//

import Foundation

enum NetworkError: LocalizedError {
    case invalidURL
    case thrownError(Error)
    case noData
    case unableToDecode
}
