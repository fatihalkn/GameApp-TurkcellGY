//
//  HomeHeaderCollectionViewCell.swift
//  GamesApp
//
//  Created by Fatih on 16.07.2024.
//

import UIKit
import SDWebImage

class HomeHeaderCollectionViewCell: UICollectionViewCell {
    static let identifier = "HomeHeaderCollectionViewCell"
    
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
        gameImageView.layer.cornerRadius = 20
        gameImageView.layer.masksToBounds = true
        
    }
    
    func configure(model: GameResult) {
        guard let imageUrl = URL(string: model.backgroundImage ) else { return }
        gameImageView.sd_setImage(with: imageUrl,placeholderImage: nil)
        
    }
    
    //MARK: - UI Elements
    let gameImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
}

//MARK: -  SetupUI
extension HomeHeaderCollectionViewCell {
    func setupUI() {
        addSubview(gameImageView)
        NSLayoutConstraint.activate([
            gameImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            gameImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,constant: 20),
            gameImageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,constant: -20),
            gameImageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor,constant: -40)
        ])
    }
}
