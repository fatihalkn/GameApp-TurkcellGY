//
//  HomeViewCollectionViewHeader.swift
//  GamesApp
//
//  Created by Fatih on 15.07.2024.
//

import UIKit

class HomeViewCollectionViewHeader: UICollectionReusableView {
    static let identifier = "HomeViewCollectionViewHeader"
    
    let homeViewModel = HomeViewModel()
    
    //MARK: - İnit Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupDelegate()
        setupRegister()
        setupUI()
        requestGameİmages()
        pageControlAddTarget()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setupRegister() {
        headerCollectionView.register(HomeHeaderCollectionViewCell.self, forCellWithReuseIdentifier: HomeHeaderCollectionViewCell.identifier)
    }
    
    func setupDelegate() {
        headerCollectionView.dataSource = self
        headerCollectionView.delegate = self
        
    }
    
    func requestGameİmages() {
        homeViewModel.allGamesRequest {
            self.headerCollectionView.reloadData()
            self.headerPageController.numberOfPages = self.homeViewModel.allGames.count
        }
    }
    
    func pageControlAddTarget() {
        headerPageController.addTarget(self, action: #selector(pageControlDidChange), for: .valueChanged)
    }
    
    @objc func pageControlDidChange() {
        let currentPage = headerPageController.currentPage
        let indexPath = IndexPath(item: currentPage, section: 0)
        headerCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    //MARK: - UI Elements
    let headerCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero,collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = true
        collectionView.decelerationRate = .fast
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    let headerPageController: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = .link
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    
    
    
}

//MARK: - Configure CollectionView
extension HomeViewCollectionViewHeader: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeViewModel.allGames.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeHeaderCollectionViewCell.identifier, for: indexPath) as! HomeHeaderCollectionViewCell
        let model = homeViewModel.allGames[indexPath.item]
        cell.configure(model: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth: CGFloat = collectionView.frame.width
        let cellHight: CGFloat = collectionView.frame.height
        return(.init(width: cellWidth, height: cellHight))
    }
    
    
}


//MARK: - PageController Configure
extension HomeViewCollectionViewHeader {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.width
        let currentPage = Int((scrollView.contentOffset.x + pageWidth / 2) / pageWidth)
        headerPageController.currentPage = currentPage
    }
}

//MARK: - SetupUI
extension HomeViewCollectionViewHeader {
    func setupUI() {
        addSubview(headerCollectionView)
        addSubview(headerPageController)
        
        NSLayoutConstraint.activate([
            headerCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            headerCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            headerCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            headerCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            headerPageController.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            headerPageController.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor)
        ])
    }
}



