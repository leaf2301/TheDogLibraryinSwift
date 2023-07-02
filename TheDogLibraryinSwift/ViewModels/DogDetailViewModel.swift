//
//  DogDetailViewModel.swift
//  TheDogLibraryinSwift
//
//  Created by Tran Hieu on 02/07/2023.
//

import Foundation
import UIKit

final class DogDetailViewModel {
    
    let dogModel: DogModel
    
    var onImageLoaded: ((UIImage?)->())?
    
    init(dogModel: DogModel) {
        self.dogModel = dogModel
        self.loadImage()
    }
    
    private func loadImage() {
        dogModel.fetchImage { [weak self] result in
            switch result {
            case .success(let data):
                let image = UIImage(data: data)
                self?.onImageLoaded?(image)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    var dogName: String {
        return "Name: \(dogModel.name)"
    }
    
    var dogTemper: String {
        return "Nature: \(dogModel.temperament ?? "None")"
    }
    
    var dogBredFor: String {
        return "Skilled For: \(dogModel.bredFor ?? "Pet")"
    }
    
    
    
    
}
