//
//  IFRoundShadowView.swift
//  IconFont
//
//  Created by sungrow on 2019/3/18.
//  Copyright © 2019 yuqiang. All rights reserved.
//

import UIKit

class IFRoundShadowView: IFBaseView {

    private var shadowLayer: CAShapeLayer!
    public var cornerRadius: CGFloat = 0 {
        didSet {
            if shadowLayer != nil {
                shadowLayer = nil
                layoutIfNeeded()
            }
        }
    }
    public var fillColor: UIColor = UIColor.clear {
        didSet {
            if shadowLayer != nil {
                shadowLayer = nil
                layoutIfNeeded()
            }
        }
    }
    public var shadowColor: UIColor = UIColor.black {
        didSet {
            if shadowLayer != nil {
                shadowLayer = nil
                layoutIfNeeded()
            }
        }
    }
    public var shadowOffset: CGSize = CGSize.zero {
        didSet {
            if shadowLayer != nil {
                shadowLayer = nil
                layoutIfNeeded()
            }
        }
    }
    public var shadowOpacity: Float = 0.1 {
        didSet {
            if shadowLayer != nil {
                shadowLayer = nil
                layoutIfNeeded()
            }
        }
    }
    public var shadowRadius: CGFloat = 2 {
        didSet {
            if shadowLayer != nil {
                shadowLayer = nil
                layoutIfNeeded()
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
            shadowLayer.fillColor = fillColor.cgColor
            
            shadowLayer.shadowColor = shadowColor.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = shadowOffset
            shadowLayer.shadowOpacity = shadowOpacity
            shadowLayer.shadowRadius = shadowRadius
            
            contentView.layer.insertSublayer(shadowLayer, at: 0)
        }
    }
}
