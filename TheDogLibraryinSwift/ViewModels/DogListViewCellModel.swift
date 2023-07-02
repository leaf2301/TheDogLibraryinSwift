//
//  DogListViewCellModel.swift
//  TheDogLibraryinSwift
//
//  Created by Tran Hieu on 02/07/2023.
//

import Foundation
import UIKit

final class DogListViewCellModel {
    private let name: String
    private let temperament: String
    private let imageUrl: String

    init(name: String, temperament: String, imageUrl: String) {
        self.name = name
        self.temperament = temperament
        self.imageUrl = imageUrl
    }
    
    var dogName: String {
        return "Name: \(name)"
    }
    
    var dogTemperament: String {
        return "Characteristics: \(temperament)"
    }
    
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> ()) {
        guard let url = URL(string: imageUrl) else {
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
