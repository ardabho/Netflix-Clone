//
//  APICaller.swift
//  netflix
//
//  Created by ARDA BUYUKHATIPOGLU on 24.10.2023.
//

import Foundation

struct Constants {
    static let API_KEY = "Your Movie Db Api Key"
    static let baseURL = "https://api.themoviedb.org"
    static let YoutubeAPI_KEY = "Your youtube api key"
    static let YoutubeBaseUrl = "https://youtube.googleapis.com/youtube/v3/search?"
}

enum APIError: Error {
    case failedToGetData
}

class APICaller {
    static let shared = APICaller()
    
    func getTrendingMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        let url = URL(string: "\(Constants.baseURL)/3/trending/movie/day?api_key=\(Constants.API_KEY)")!
        
        let task = URLSession.shared.dataTask(with: url) { data, _ , error in
            guard let data, error == nil else { print("error while calling api")
                return }
            
            do {
                let results = try JSONDecoder().decode(TitleResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func getTrendingTV(completion: @escaping (Result<[Title], Error>) -> Void) {
        let url = URL(string: "\(Constants.baseURL)/3/trending/tv/day?api_key=\(Constants.API_KEY)")!
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data, error == nil else { print(error!.localizedDescription)
                return }
            
            do {
                let results = try JSONDecoder().decode(TitleResponse.self, from: data)
                completion(.success(results.results))
                
                
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func getUpcomingMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        let url = URL(string: "\(Constants.baseURL)/3/movie/upcoming?api_key=\(Constants.API_KEY)")!
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data, error == nil else { print("Error while calling upcomingmovies api"); return}
            
            do {
                let results = try JSONDecoder().decode(TitleResponse.self, from: data)
                completion(.success(results.results))
                
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }

    func getPopularMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        let url = URL(string: "\(Constants.baseURL)/3/movie/popular?api_key=\(Constants.API_KEY)&language=en-US&page=1")!
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data, error == nil else { print("Error while calling Popular Movies api"); return}
            
            do {
                let results = try JSONDecoder().decode(TitleResponse.self, from: data)
                completion(.success(results.results))
                
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }

    func getTopRatedMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        let url = URL(string: "\(Constants.baseURL)/3/movie/top_rated?api_key=\(Constants.API_KEY)&language=en-US&page=1")!
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data, error == nil else { print("Error while calling Top Rated Movies api"); return}
            
            do {
                let results = try JSONDecoder().decode(TitleResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    

    func getDiscoverMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        let url = URL(string: "\(Constants.baseURL)/3/discover/movie?api_key=\(Constants.API_KEY)&include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc")!
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data, error == nil else { print("Error while calling discover Movies api"); return}
            
            do {
                let results = try JSONDecoder().decode(TitleResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func search(with query: String, completion: @escaping (Result<[Title], Error>) -> Void) {
        
        guard let url = URL(string: "\(Constants.baseURL)/3/search/movie?api_key=\(Constants.API_KEY)&query=\(query)") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data, error == nil else { print("Error while calling discover Movies api"); return}
            
            do {
                let results = try JSONDecoder().decode(TitleResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func getMovie(with query: String, completion: @escaping (Result<Item, Error>) -> Void) {
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        
        let url = URL(string: "\(Constants.YoutubeBaseUrl)q=\(query)&key=\(Constants.YoutubeAPI_KEY)")!
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data, error == nil else { print("Error while calling discover Movies api"); return}
            
            do {
                let results = try JSONDecoder().decode(YoutubeSearchResponse.self, from: data)
                completion(.success(results.items[0]))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
}
