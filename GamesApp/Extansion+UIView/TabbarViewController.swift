//
//  TabbarViewController.swift
//  GamesApp
//
//  Created by Fatih on 17.07.2024.
//

import Foundation
import UIKit

class TabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.unselectedItemTintColor = .lightGray
        self.tabBar.tintColor = .white
        setupTabs()

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tabBar.applyGradient(colors: [.tabCL1, .tabCL2], startPoint: CGPoint(x: 0.5, y: 0), endPoint: CGPoint(x: 1.0, y: 1.0))
    }
    
    private func setupTabs() {
        let home = creatTabs(title: "Home", image: .tabbarHomeIcon, vc: HomeViewController())
        let tickets = creatTabs(title: "Favorite", image: .tabbarFavoriteIcon, vc: FavoriteController())
        self.setViewControllers([home,tickets], animated: true)
    }
    
    private func creatTabs(title:String, image: UIImage, vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        return nav
    }

   

}
