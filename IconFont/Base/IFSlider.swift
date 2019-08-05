//
//  IFSlider.swift
//  IconFont
//
//  Created by sungrow on 2019/7/31.
//  Copyright © 2019 yuqiang. All rights reserved.
//

import UIKit
import QuartzCore

class IFSlider: IFGradientView {
    
    fileprivate var startPoint = CGPoint.zero
    fileprivate var startValueFrame = CGRect.zero
    
    fileprivate lazy var valueLayer: CALayer = {
        let ly = CALayer()
        ly.backgroundColor = "#FEFFFF".hexColor!.cgColor
        return ly
    }()

    override func createViews() {
        super .createViews()
        autoAnimate = true
        roundRadius = 8
        scaleComment.factor = 1.05
        
        let effect = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        addSubview(effect)
        effect.snp.makeConstraints { (make) in
            make.edges.equalToSuperview();
        }
        layer.addSublayer(valueLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let valueHeight = valueLayer.bounds.height
        let valueY = bounds.height - valueHeight
        valueLayer.frame = CGRect(x: 0, y: valueY, width: bounds.width, height: valueHeight)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if let touch = touches.first {
            let point = touch.location(in: self)
            startPoint = point
            startValueFrame = valueLayer.frame
            print("\(#function) - \(point)")
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        if let touch = touches.first {
            let point = touch.location(in: self)
            let difference = startPoint.y - point.y
            var finalHeight = startValueFrame.height + difference
            let height = bounds.height
            if finalHeight > height {
                finalHeight = height
            }
            if finalHeight < 0 {
                finalHeight = 0
            }
            let y = height - finalHeight
            
            valueLayer.frame = CGRect(x: 0, y: y, width: bounds.size.width, height: finalHeight)
            print("\(#function) - \(point) - \(difference)")
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        startPoint = CGPoint.zero
        if let touch = touches.first {
            let point = touch.location(in: self)
            print("\(#function) - \(point)")
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        startPoint = CGPoint.zero
        if let touch = touches.first {
            let point = touch.location(in: self)
            print("\(#function) - \(point)")
        }
    }
}
