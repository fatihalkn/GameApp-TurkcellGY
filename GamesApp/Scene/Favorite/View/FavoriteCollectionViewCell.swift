//
//  FavoriteCollectionViewCell.swift
//  GamesApp
//
//  Created by Fatih on 17.07.2024.
//

import UIKit
protocol FavoriteCollectionViewCellProtocol {
    func didTappedİnfoButton(indexPath: IndexPath)
    func didTappedDeleteButton(indexPath: IndexPath)
}
class FavoriteCollectionViewCell: UICollectionViewCell {
    static let identifier = "FavoriteCollectionViewCell"
    //MARK: - Properties
    var favoriteCollectionViewCellDelegate: FavoriteCollectionViewCellProtocol?
    var indexPath : IndexPath?
    
    //MARK: - İnit Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        configureTargets()
        
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
    
    func configureTargets() {
        infoGameButton.addTarget(self, action: #selector(infoButtonTapped), for: .touchUpInside)
        deleteGameButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }
    
    @objc func deleteButtonTapped() {
        guard let indexPath = self.indexPath else { return }
        favoriteCollectionViewCellDelegate?.didTappedDeleteButton(indexPath: indexPath)
    }
    
    @objc func infoButtonTapped() {
        guard let indexPath = self.indexPath else { return }
        favoriteCollectionViewCellDelegate?.didTappedİnfoButton(indexPath: indexPath)
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
    
    let infoGameButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(.infoButton, for: .normal)
        button.tintColor = .white
        return button
    }()
    
    let deleteGameButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(.deleteButton, for: .normal)
        button.tintColor = .white
        return button
    }()
    
    let deleteAndİnfoButtonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .clear
        return stackView
    }()
  
}

//MARK: -  SetupUI
extension FavoriteCollectionViewCell {
    func setupUI() {
        addSubview(gameImageView)
        addSubview(rateImageView)
        addSubview(rateLabel)
        addSubview(gameNameLabel)
        addSubview(deleteAndİnfoButtonStackView)
        deleteAndİnfoButtonStackView.addArrangedSubview(infoGameButton)
        deleteAndİnfoButtonStackView.addArrangedSubview(deleteGameButton)
        
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
            
            deleteAndİnfoButtonStackView.topAnchor.constraint(equalTo: rateLabel.topAnchor),
            deleteAndİnfoButtonStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,constant: -20),
            deleteAndİnfoButtonStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            deleteAndİnfoButtonStackView.leadingAnchor.constraint(greaterThanOrEqualTo: rateLabel.trailingAnchor, constant: 50),
            
            deleteGameButton.widthAnchor.constraint(equalToConstant: 30),
            deleteGameButton.heightAnchor.constraint(equalToConstant: 30),
            
            infoGameButton.widthAnchor.constraint(equalToConstant: 30),
            infoGameButton.heightAnchor.constraint(equalToConstant: 30),
            
            
            
            
            
        ])
    }
}




