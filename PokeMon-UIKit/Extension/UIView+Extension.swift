//
//  UIView+Extension.swift
//  PokeMon-UIKit
//
//  Created by Hyungjun KIM on 2/17/25.
//

import UIKit

extension UIView {
    func addShadow(offset: CGSize, color: UIColor, shadowRadius: CGFloat, opacity: Float, cornerRadius: CGFloat) {
        layer.cornerRadius = cornerRadius
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = opacity
        layer.masksToBounds = false
    }
    
    func addCornerRadius(radius: CGFloat) {
        layer.masksToBounds = false
        layer.cornerRadius = radius
    }
    
    func addRoundedCorners(corners: CACornerMask, radius: CGFloat) {
        layer.cornerRadius = radius
        layer.maskedCorners = [corners]
    }
    
    func addGradientLayer(colors: [CGColor]) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = bounds
        gradientLayer.locations = [0.0, 1.15]
        gradientLayer.colors = colors
        
        self.layer.insertSublayer(gradientLayer, at: 0)
        
        return gradientLayer
    }
    
    func setCornerRadius(gradientLayer: CAGradientLayer, radius: CGFloat, corners: CACornerMask) {
        gradientLayer.cornerRadius = radius
        gradientLayer.maskedCorners = corners
    }
}
