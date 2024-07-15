//
//  HomeViewCollectionViewHeader.swift
//  GamesApp
//
//  Created by Fatih on 15.07.2024.
//

import UIKit

class HomeViewCollectionViewHeader: UICollectionReusableView {
    static let identifier = "HomeViewCollectionViewHeader"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
