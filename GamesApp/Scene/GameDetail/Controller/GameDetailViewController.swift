//
//  GameDetailViewController.swift
//  GamesApp
//
//  Created by Fatih on 16.07.2024.
//

import Foundation
import UIKit
import AVKit

class GameDetailViewController: UIViewController {
    
    let gameDetailView = GameDetailView()
    let gameDetailViewModel = GameDetailViewModel()
    
    
    
    
    override func loadView() {
        super.loadView()
        view = gameDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestGameDetail()
        requestGameMovies()
        addTargert()
        ifHaveFavoritesGames()
        gameDetailView.gamedetailViewDelegate = self
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    func requestGameDetail() {
        gameDetailViewModel.detailGamesRequest {
            guard let gameDetailModel = self.gameDetailViewModel.gameDetail else { return }
            self.gameDetailView.configure(model: gameDetailModel)
        }
        
    }
    
    func requestGameMovies() {
        gameDetailViewModel.getGameMoviesRequest {
            
        }
        
        
    }
    
    func addTargert() {
        gameDetailView.bookMarkButton.addTarget(self, action: #selector(tappedBookMarkButton), for: .touchUpInside)
    }
    
    @objc func tappedBookMarkButton() {
        let gameID = Int32(gameDetailViewModel.gameID ?? 0)
        if CoreDataManager.shared.isFavorite(gameID: gameID) {
            CoreDataManager.shared.deleteGame(gameID: gameID)
            gameDetailView.bookMarkButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
            gameDetailView.bookMarkButton.tintColor = .white
        } else {
            CoreDataManager.shared.saveGame(gameID: gameID)
            gameDetailView.bookMarkButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
            gameDetailView.bookMarkButton.tintColor = .red
        }
    }
    
    func ifHaveFavoritesGames() {
        let gameID = Int32(gameDetailViewModel.gameID ?? 0)
        
        if CoreDataManager.shared.isFavorite(gameID: gameID) {
            gameDetailView.bookMarkButton.tintColor = .red
            gameDetailView.bookMarkButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        } else {
            gameDetailView.bookMarkButton.tintColor = .white
            gameDetailView.bookMarkButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        }
        
    }
    
}

//MARK: - AVPlayerViewControllerDelegate
extension GameDetailViewController: AVPlayerViewControllerDelegate {
}

//MARK: - GameDetailViewProtocol
extension GameDetailViewController: GameDetailViewProtocol {
    func didTappedPlayButton() {
        guard let urlString = self.gameDetailViewModel.gameMovie.first,
              let url = URL(string: urlString) else {
            gameDetailView.showError(text: "The Trailer of this game is Unavailable, please try again later.", image: nil, interaction: false, delay: 1.5)
            return
        }
        let player = AVPlayer(url: url)
        self.gameDetailView.playerController.player = player
        self.gameDetailView.playerController.allowsPictureInPicturePlayback = true
        self.gameDetailView.playerController.delegate = self
        self.present(gameDetailView.playerController, animated: true)
    }
    
    
}

