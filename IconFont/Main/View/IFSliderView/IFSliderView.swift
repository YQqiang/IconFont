//
//  IFSliderView.swift
//  IconFont
//
//  Created by sungrow on 2019/4/8.
//  Copyright © 2019 yuqiang. All rights reserved.
//

import UIKit

class IFSliderView: IFBaseView {
    
    public var minimumValue: CGFloat = 0
    public var maximumValue: CGFloat = 1
    public var value: CGFloat = 0 {
        didSet {
            if (value < minimumValue) {
                value = minimumValue
            } else if (value > maximumValue) {
                value = maximumValue
            }
            
        }
    }
    
    fileprivate lazy var trackLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        
        return layer
    }()
    
    override func createViews() {
        super.createViews()
        layer.addSublayer(trackLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    private func valueWidth(_ value: CGFloat) -> CGFloat {
        let radio = (value - minimumValue) / (maximumValue - minimumValue)
        let width = bounds.width
        let valueWidth = width * radio
        return valueWidth
    }

}
