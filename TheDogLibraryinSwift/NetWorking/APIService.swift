//
//  APIService.swift
//  TheDogLibraryinSwift
//
//  Created by Tran Hieu on 02/07/2023.
//

import Foundation

enum APIError: Error, CustomStringConvertible {
    case badURL
    case badResponse(statusCode: Int)
    case url(URLError?)
    
    case parsing(DecodingError?)
    case unknown
    
    var localizedDescription: String {
        switch self {
        case .badURL, .parsing, .unknown:
            return "Sorry, something went wrong."
        case .badResponse(_):
            return "Sorry, the connection to our server failed"
        case .url(let error):
            return error?.localizedDescription ?? "Something went wrong"

        }
    }
    
    var description: String {
        switch self {
        case .badURL: return "Invalid URL"
        case .parsing(let error):
            return "parsing error \(error?.localizedDescription ?? "")"
        case .unknown: return "unknown error"
            
        case .badResponse(statusCode: let statusCode):
            return "bad response with status code \(statusCode)"
        case .url(let error):
            return error?.localizedDescription ?? "URL session error"

        }

    }
}

final class APIService {
    static let shared = APIService()
    private init(){}
    
    func fetchAllBreeds(completion: @escaping(Result<[DogModel], APIError>) -> ()) {
        guard let url = URL(string: "https://api.thedogapi.com/v1/breeds") else {
            let error = APIError.badURL
            completion(Result.failure(error))
            return
        }
        
        
        URLSession.shared.dataTask(with: url) {data, response, error in
            if let error = error as? URLError {
                completion(Result.failure(APIError.url(error)))
            } else if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                completion(Result.failure(APIError.badResponse(statusCode: response.statusCode)))
            } else if let data = data {
                let decoder = JSONDecoder()
                do {
                    let breeds = try decoder.decode([DogModel].self, from: data)
                    completion(Result.success(breeds))
                } catch {
                    completion(Result.failure(APIError.parsing(error as? DecodingError)))
                    
                }
                
            }
        }.resume()
    }
    
    func fetchImage(url: URL?, completion: @escaping (Result<Data, Error>) -> ()) {
        guard let url = url else {
            completion(.failure(URLError(.badURL)))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            completion(.success(data))
        }
        
        task.resume()

        
    }

}
