//
//  GameDetailView.swift
//  GamesApp
//
//  Created by Fatih on 16.07.2024.
//

import Foundation
import UIKit
import SDWebImage
import AVKit

protocol GameDetailViewProtocol {
    func didTappedPlayButton()
}

class GameDetailView: UIView {
    
    //MARK: - Properties
    var gamedetailViewDelegate: GameDetailViewProtocol?
    
    //MARK: -  İnit Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        buttonTargets()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        applyGradient(colors: [.gradiantCL1,.gradiantCL1,.gradiantCL2], startPoint: CGPoint(x: 0.5, y: 0), endPoint: CGPoint(x: 0.5, y: 1.0))
        
        playFragmanButton.applyGradient(colors: [.tabCL1, .tabCL2], startPoint: CGPoint(x: 0.5, y: 0), endPoint: CGPoint(x: 1.0, y: 1.0))
        
        playFragmanButton.layer.cornerRadius = 18
        playFragmanButton.layer.masksToBounds = true
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func configure(model: GameResponseDetailModel) {
        guard let imageURL = URL(string: model.backgroundImage) else { return }
        gameImageView.sd_setImage(with: imageURL,placeholderImage: nil)
        gameDescriptionLabel.text = model.descriptionRaw
        gameNameLabel.text = model.name
        rateLabel.text = "\(model.rating)"
    }
    
    func buttonTargets() {
        playFragmanButton.addTarget(self, action: #selector(playFragmanButtonTapped), for: .touchUpInside)
    }
    
    @objc func playFragmanButtonTapped() {
        gamedetailViewDelegate?.didTappedPlayButton()
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
        imageView.tintColor = .rateCL
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let bookMarkButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "bookmark"), for: .normal)
        button.tintColor = .white
        return button
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
        label.font = .systemFont(ofSize: 18, weight: .black)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let gameDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    let playerController: AVPlayerViewController = {
        let avPlayer = AVPlayerViewController()
        return avPlayer
    }()
    
    let playFragmanButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "play.fill"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    
    
    
}

//MARK: - SetupUI
extension GameDetailView {
    // MARK: - SetupUI
    
    func setupUI() {
        backgroundColor = .backgroundCL
        
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(gameImageView)
        contentView.addSubview(rateLabel)
        contentView.addSubview(rateImageView)
        contentView.addSubview(gameNameLabel)
        contentView.addSubview(gameDescriptionLabel)
        contentView.addSubview(bookMarkButton)
        contentView.addSubview(playFragmanButton)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            gameImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            gameImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            gameImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            gameImageView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.5),
            
            gameNameLabel.topAnchor.constraint(equalTo: gameImageView.bottomAnchor, constant: 16),
            gameNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            gameNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            rateImageView.topAnchor.constraint(equalTo: gameNameLabel.bottomAnchor, constant: 8),
            rateImageView.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 16),
            
            bookMarkButton.topAnchor.constraint(equalTo: gameNameLabel.bottomAnchor, constant: 8),
            bookMarkButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            bookMarkButton.bottomAnchor.constraint(equalTo: gameDescriptionLabel.topAnchor, constant: -16),
            
            
            rateLabel.topAnchor.constraint(equalTo: gameNameLabel.bottomAnchor, constant: 8),
            rateLabel.leadingAnchor.constraint(equalTo: rateImageView.trailingAnchor,constant: 10),
            rateLabel.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 16),
            rateLabel.bottomAnchor.constraint(equalTo: gameDescriptionLabel.topAnchor, constant: -16),
            
            
            gameDescriptionLabel.topAnchor.constraint(equalTo: rateImageView.bottomAnchor, constant: 16),
            gameDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            gameDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            gameDescriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            playFragmanButton.topAnchor.constraint(equalTo: gameImageView.topAnchor, constant: 20),
            playFragmanButton.trailingAnchor.constraint(equalTo: gameImageView.trailingAnchor,constant: -20),
            playFragmanButton.heightAnchor.constraint(equalToConstant: 50),
            playFragmanButton.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
}

