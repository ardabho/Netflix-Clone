//
//  APICaller.swift
//  netflix
//
//  Created by ARDA BUYUKHATIPOGLU on 24.10.2023.
//

import Foundation

struct Constants {
    static let API_KEY = "1140c7fa704f458e35437eb5d4c42375"
    static let baseURL = "https://api.themoviedb.org"
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
        let url = URL(string: "\(Constants.baseURL)/3/movie/upcoming?api_key=\(Constants.API_KEY)&region=US")!
        
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

}
