//
//  ViewController.swift
//  TheDogLibraryinSwift
//
//  Created by Tran Hieu on 02/07/2023.
//

import UIKit

class ViewController: UIViewController {
    
    private let dogListView = DogListView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "Dog Library"
        navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.prefersLargeTitles = true
        setupUI()
        dogListView.viewModel.delegate = self
    }
    
    private func setupUI() {
        view.addSubview(dogListView)
        
        NSLayoutConstraint.activate([
            dogListView.topAnchor.constraint(equalTo: view.topAnchor),
            dogListView.leftAnchor.constraint(equalTo: view.leftAnchor),
            dogListView.rightAnchor.constraint(equalTo: view.rightAnchor),
            dogListView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension ViewController: DogListViewModelDelegate {
    func didSelectItem(_ dogModel: DogModel) {
        let viewModel = DogDetailViewModel(dogModel: dogModel)
        let detailVC = DetailViewController(viewModel: viewModel)
        detailVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
}


