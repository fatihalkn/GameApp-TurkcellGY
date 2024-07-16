//
//  GradiantLayer.swift
//  GamesApp
//
//  Created by Fatih on 16.07.2024.
//

import Foundation

import UIKit

extension UIView {
    func applyGradient(colors: [UIColor], startPoint: CGPoint, endPoint: CGPoint) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        
        if let existingGradient = layer.sublayers?.first(where: { $0 is CAGradientLayer }) {
            existingGradient.removeFromSuperlayer()
        }
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
