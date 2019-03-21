//
//  IFGradientView.swift
//  IconFont
//
//  Created by sungrow on 2019/3/21.
//  Copyright © 2019 yuqiang. All rights reserved.
//

import UIKit

class IFGradientView: IFBaseView {

    private var maskLayer: CAShapeLayer!
    public var roundCorner: UIRectCorner = .allCorners {
        didSet {
            if maskLayer != nil {
                maskLayer = nil
                layoutIfNeeded()
            }
        }
    }
    
    public var roundRadius: CGFloat = 0 {
        didSet {
            if maskLayer != nil {
                maskLayer = nil
                layoutIfNeeded()
            }
        }
    }
    
    public var gradientColors: [CGColor]? {
        didSet {
            guard let gradientLayer = self.layer as? CAGradientLayer else { return }
            gradientLayer.colors = gradientColors
        }
    }
    
    override public class var layerClass: Swift.AnyClass {
        return CAGradientLayer.self
    }
    
    override func createViews() {
        super.createViews()
        contentView.backgroundColor = UIColor.clear
        guard let gradientLayer = self.layer as? CAGradientLayer else { return }
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if maskLayer == nil {
            maskLayer = CAShapeLayer()
            maskLayer.path = UIBezierPath(roundedRect: bounds, byRoundingCorners: roundCorner, cornerRadii: CGSize(width: roundRadius, height: roundRadius)).cgPath
            layer.mask = maskLayer
        }
    }
}
