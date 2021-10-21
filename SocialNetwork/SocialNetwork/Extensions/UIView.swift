//
//  UIView.swift
//  SocialNetwork
//
//  Created by Евгений on 12.10.21.
//

import Foundation
import UIKit


extension UIView {
    
    static func setGradietnBackgroundView(view: UIView) -> CAGradientLayer {
        let layer = CAGradientLayer()
        layer.frame = view.bounds
        layer.colors = [UIColor.yellow.cgColor, UIColor.white.cgColor]
        layer.startPoint = CGPoint(x: 1, y: 0)
        layer.endPoint = CGPoint(x: 0, y: 1)
        return layer
    }
    
}
