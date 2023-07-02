//
//  DogModel.swift
//  TheDogLibraryinSwift
//
//  Created by Tran Hieu on 02/07/2023.
//

import Foundation
import UIKit

struct DogModel: Codable {
    let id: Int
    let name: String
    let bredFor: String?
    let temperament: String?
    let image: Image
    
    
    var dogImageURL: URL {
        guard let imageURL = URL(string: image.url) else { return URL(string: "https://cdn2.thedogapi.com/images/BJa4kxc4X.jpg")!}

        return imageURL

    }
    
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> ()) {
        guard let url = URL(string: image.url) else {
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

struct Image: Codable {
    let id: String
    let width, height: Int
    let url: String
}

//extension DogModel {
//    
//    public static func getMockArray() -> [DogModel] {
//        
//        let allDogs: [DogModel] = [DogModel(id: 1, name: "Affenpinscher", bredFor: "Small rodent hunting, lapdog", temperament: "Stubborn, Curious, Playful, Adventurous, Active, Fun-loving", image: Image(id: "BJa4kxc4X", width: 1600, height: 1199, url: "https://cdn2.thedogapi.com/images/BJa4kxc4X.jpg")), DogModel(id: 2, name: "Affenpinscher", bredFor: "Small rodent hunting, lapdog", temperament: "Stubborn, Curious, Playful, Adventurous, Active, Fun-loving", image: Image(id: "BJa4kxc4X", width: 1600, height: 1199, url: "https://cdn2.thedogapi.com/images/BJa4kxc4X.jpg")), DogModel(id: 3, name: "Affenpinscher", bredFor: "Small rodent hunting, lapdog", temperament: "Stubborn, Curious, Playful, Adventurous, Active, Fun-loving", image: Image(id: "BJa4kxc4X", width: 1600, height: 1199, url: "https://cdn2.thedogapi.com/images/BJa4kxc4X.jpg"))]
//        
//        return allDogs
//        
//    }
//}
