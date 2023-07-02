//
//  DogCollectionCellVM.swift
//  TheDogLibraryinSwift
//
//  Created by Tran Hieu on 02/07/2023.
//

import Foundation
import UIKit

protocol DogListViewModelDelegate: AnyObject {
    func didSelectItem(_ dogModel: DogModel)
}

final class DogListViewModel: NSObject {
    
    private var allDogs: [DogModel] = [] {
        didSet {
            self.reloadData?()
        }
    }
    public weak var delegate: DogListViewModelDelegate?
    
    var reloadData: (()->())?

    public func fetchDogs() {
        APIService.shared.fetchAllBreeds { [weak self] result in
            switch result {
            case .success(let items):
                DispatchQueue.main.async {
                    self?.allDogs = items
                    self?.reloadData?()
                    print(self?.allDogs.count ?? 2301)
                }

            case .failure(let error):
                print(error)
            }
        }
    }
}

extension DogListViewModel: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(allDogs.count)
        return allDogs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DogListCollectionViewCell.id, for: indexPath) as? DogListCollectionViewCell else { fatalError() }
        let vm = allDogs[indexPath.item]
        cell.configure(with: vm)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let dog = allDogs[indexPath.item]
        delegate?.didSelectItem(dog)

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width-20)/2
        return CGSize(width: width, height: width*1.5)

    }
}

