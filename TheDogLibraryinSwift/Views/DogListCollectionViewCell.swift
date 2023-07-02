//
//  DogListCollectionViewCell.swift
//  TheDogLibraryinSwift
//
//  Created by Tran Hieu on 02/07/2023.
//

import UIKit

class DogListCollectionViewCell: UICollectionViewCell {
    static let id = "DogListCollectionViewCell"
    
//    private(set) var viewModel: DogModel
    
    private var imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
//        iv.frame = .init(x: 0, y: 0, width: 200, height: 200)
        return iv
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
    
//    init(frame: CGRect, viewModel: DogModel) {
//        self.viewModel = viewModel
//        super.init(frame: frame)
//        setupUI()
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        setupUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        temperLabel.text = nil
        nameLabel.text = nil
        imageView.image = nil
    }
    
    private func setupUI() {
        contentView.addSubviews(imageView, nameLabel, temperLabel)
        
        NSLayoutConstraint.activate([
            
            imageView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            
            nameLabel.heightAnchor.constraint(equalToConstant: 80),
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 2),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -2),
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -15),
            
            
            temperLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: -30),
            temperLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 2),
            temperLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -2),
            temperLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
        ])
        
    }
    
    public func configure(with viewModel: DogModel) {
        self.nameLabel.text = viewModel.name
        self.temperLabel.text = viewModel.temperament
        viewModel.fetchImage { [weak self]result in
            switch result {
            case .success(let data):
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    self?.imageView.image = image
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
}
