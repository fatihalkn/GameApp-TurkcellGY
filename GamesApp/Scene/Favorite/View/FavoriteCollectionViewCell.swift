//
//  FavoriteCollectionViewCell.swift
//  GamesApp
//
//  Created by Fatih on 17.07.2024.
//

import UIKit

class FavoriteCollectionViewCell: UICollectionViewCell {
    static let identifier = "FavoriteCollectionViewCell"
    //MARK: - Properties
    
    
    //MARK: - İnit Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gameImageView.layer.cornerRadius = 16
        gameImageView.layer.masksToBounds = true
    }
    
    func configure(model: GameResponseDetailModel) {
        guard let imageURL = URL(string: model.backgroundImage) else {
            print("GEÇERSİZ URL: \(model.backgroundImage)")
            return
        }
        
        gameNameLabel.text = model.name
        rateLabel.text = "\(model.rating)"
        gameImageView.sd_setImage(with: imageURL,placeholderImage: nil)
    }
    
    //MARK: - UI Elements
    let gameImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = .checkmark
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let rateImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "star.fill")
        imageView.clipsToBounds = true
        imageView.tintColor = .rateCL
        return imageView
    }()
    
    let rateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11, weight: .semibold)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let gameNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
  
}

//MARK: -  SetupUI
extension FavoriteCollectionViewCell {
    func setupUI() {
        addSubview(gameImageView)
        addSubview(rateImageView)
        addSubview(rateLabel)
        addSubview(gameNameLabel)
        
        NSLayoutConstraint.activate([
            gameImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            gameImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            gameImageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            gameImageView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.4),
            
            gameNameLabel.centerYAnchor.constraint(equalTo: gameImageView.centerYAnchor,constant: -15),
            gameNameLabel.leadingAnchor.constraint(equalTo: gameImageView.trailingAnchor,constant: 10),
            gameNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.trailingAnchor, constant: -50),
            
            rateImageView.topAnchor.constraint(equalTo: gameNameLabel.bottomAnchor, constant: 15),
            rateImageView.leadingAnchor.constraint(equalTo: gameNameLabel.leadingAnchor),
            rateImageView.widthAnchor.constraint(equalToConstant: 30),
            rateImageView.heightAnchor.constraint(equalToConstant: 30),
            
            
            rateLabel.centerYAnchor.constraint(equalTo: rateImageView.centerYAnchor),
            rateLabel.leadingAnchor.constraint(equalTo: rateImageView.trailingAnchor,constant: 10),
            rateLabel.trailingAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.trailingAnchor, constant: -50),
        ])
    }
}




