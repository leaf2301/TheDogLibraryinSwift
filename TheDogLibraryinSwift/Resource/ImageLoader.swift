//
//  ImageLoader.swift
//  RickAndMortyLibrary
//
//  Created by Tran Hieu on 24/06/2023.
//

import Foundation

final class ImageLoader {
    static let shared = ImageLoader()
    
    private var imageDataCache = NSCache<NSString, NSData>()
    
    private init() {}
    
    func downloadImage(_ url: URL, completion: @escaping (Result<Data, Error>) -> ()) {
        let key = url.absoluteString as NSString
        if let data = imageDataCache.object(forKey: key) {
            completion(.success(data as Data)) 
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                print(error)
                completion(.failure(URLError(.badURL)))
            } else if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                completion(.failure(URLError(.badServerResponse)))
            } else if let data = data {
                let key = url.absoluteString as NSString
                let value = data as NSData
                self?.imageDataCache.setObject(value, forKey: key)
                completion(.success(data))
            }
        }.resume()

    }
}
