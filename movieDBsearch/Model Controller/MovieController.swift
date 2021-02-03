//
//  MovieController.swift
//  movieDBsearch
//
//  Created by Benjamin Tincher on 2/2/21.
//

import Foundation

class MovieController {
    static let baseURL = URL(string: "https://api.themoviedb.org/3/")
    static let searchComponent = "search"
    static let movieEndpoint = "movie"
    static let apiKey = "1cd31424dc9b6fc275cd0357ff090588"
    static let imageBaseURL = URL(string: "https://image.tmdb.org/t/p/w500/")
    
    static func fetchMoviesWith(queryString: String, completion: @escaping (Result<[Movie], NetworkError>) -> Void) {
        guard let baseURL = baseURL,
              let imageBaseURL = imageBaseURL else { return completion(.failure(.invalidURL)) }
        
        let searchURL = baseURL.appendingPathComponent(searchComponent)
        let searchMoviesURL = searchURL.appendingPathComponent(movieEndpoint)
        var components = URLComponents(url: searchMoviesURL, resolvingAgainstBaseURL: true)
        
        let apiKeyQuery = URLQueryItem(name: "api_key", value: "1cd31424dc9b6fc275cd0357ff090588")
        let queryQuery = URLQueryItem(name: "query", value: queryString)
        let pageQuery = URLQueryItem(name: "page", value: "1")
        let includeAdultQuery = URLQueryItem(name: "include_adult", value: "false")
        components?.queryItems = [apiKeyQuery, queryQuery, pageQuery, includeAdultQuery]
        
        guard let finalURL = components?.url else { return completion(.failure(.invalidURL)) }
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print("======== ERROR ========")
                print("Function: \(#function)")
                print("Error: \(error)")
                print("Description: \(error.localizedDescription)")
                print("======== ERROR ========")
                return completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else { return completion(.failure(.noData)) }
            
            do {
                let search = try JSONDecoder().decode(Search.self, from: data)
                let results = search.results
                
                var movies: [Movie] = []
                for result in results {
                    let title = result.title
                    let overview = result.overview
                    let vote_average = result.vote_average
                    
                    let posterPath = result.poster_path ?? ""
                    let imageURL = imageBaseURL.appendingPathComponent(posterPath)
                    
                    let movie = Movie(title: title, overview: overview, vote_average: vote_average, imageURL: imageURL)
                    movies.append(movie)
                }
                completion(.success(movies))
            } catch {
                print("======== ERROR ========")
                print("Function: \(#function)")
                print("Error: \(error)")
                print("Description: \(error.localizedDescription)")
                print("======== ERROR ========")
                return completion(.failure(.thrownError(error)))
            }
        }.resume()
    }
}
