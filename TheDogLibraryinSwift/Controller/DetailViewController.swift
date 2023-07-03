//
//  DetailViewController.swift
//  TheDogLibraryinSwift
//
//  Created by Tran Hieu on 02/07/2023.
//

import UIKit

class DetailViewController: UIViewController {
    
    let viewModel: DogDetailViewModel
    
    private let myImageView: UIImageView = {
       let image = UIImageView()
        
        return image
    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var temperLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var descriptLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
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
        setupUI()
        fetchData()
                
    }
    
    private func fetchData() {
        viewModel.dogModel.fetchImage {   [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self?.myImageView.image = UIImage(data: data)
                }
            case .failure(let error):
                print(error)
            }

        }
        
        nameLabel.text = viewModel.dogName
        temperLabel.text = viewModel.dogTemper
        descriptLabel.text = viewModel.dogBredFor

    }
    
    private func setupUI() {
        view.addSubviews(myImageView, nameLabel, temperLabel, descriptLabel)
        myImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            myImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            myImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            myImageView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            myImageView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 2),
            nameLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -2),
            nameLabel.topAnchor.constraint(equalTo: myImageView.bottomAnchor, constant: 10),
            

            temperLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            temperLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 2),
            temperLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -2),
            temperLabel.heightAnchor.constraint(equalToConstant: 20),

            descriptLabel.topAnchor.constraint(equalTo: temperLabel.bottomAnchor, constant: 10),
            descriptLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 2),
            descriptLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -2),
//            descriptLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            descriptLabel.heightAnchor.constraint(equalToConstant: 20),

            
        ])
    }
    

}

