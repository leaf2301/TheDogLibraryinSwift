//
//  DetailViewController.swift
//  TheDogLibraryinSwift
//
//  Created by Tran Hieu on 02/07/2023.
//

import UIKit

class DetailViewController: UIViewController {
    
    let viewModel: DogDetailViewModel
    
    init(viewModel: DogDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = viewModel.dogModel.name
    }
    

}
