//
//  GameDetailViewController.swift
//  GamesApp
//
//  Created by Fatih on 16.07.2024.
//

import Foundation
import UIKit

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
    }
    
    func requestGameDetail() {
        gameDetailViewModel.detailGamesRequest {
            guard let gameDetailModel = self.gameDetailViewModel.gameDetail else { return }
            self.gameDetailView.configure(model: gameDetailModel)
        }
    }
    
    
}

