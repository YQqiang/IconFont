//
//  IFSlider.swift
//  IconFont
//
//  Created by sungrow on 2019/7/31.
//  Copyright © 2019 yuqiang. All rights reserved.
//

import UIKit

enum SliderDirection {
    case topToBottom
    case bottomToTop
    case leftToRight
    case rightToLeft
}

class IFSlider: UIControl {
    
    fileprivate var startPoint = CGPoint.zero
    fileprivate var startValueFrame = CGRect.zero
    
    public lazy var sliderDirection: SliderDirection = .bottomToTop
    
    @IBInspectable public var minimumValue: CGFloat = 0.0 {
        willSet(newValue) {
            assert(newValue < maximumValue, "IFSlider: minimumValue should be lower than maximumValue")
        }
        didSet {
            
        }
    }
    
    @IBInspectable public var maximumValue: CGFloat = 1.0 {
        willSet(newValue) {
            assert(newValue > minimumValue, "IFSlider: maximumValue should be greater than minimumValue")
        }
        didSet {
            
        }
    }
    
    @IBInspectable public var value: CGFloat = 0.5 {
        didSet {
//            if sliderDirection == .topToBottom
//                || sliderDirection == .bottomToTop {
//                let valueFrame = valueLayer.frame
//                valueLayer.frame = CGRect(origin: valueFrame.origin, size: CGSize(width: valueFrame.width, height: value / proportion))
//            } else if sliderDirection == .leftToRight
//                || sliderDirection == .rightToLeft {
//                let valueFrame = valueLayer.frame
//                valueLayer.frame = CGRect(origin: valueFrame.origin, size: CGSize(width: value / proportion, height: valueFrame.width))
//            }
        }
        
//        get {
//            if sliderDirection == .topToBottom
//                || sliderDirection == .bottomToTop {
//                return valueLayer.bounds.height * proportion
//            } else if sliderDirection == .leftToRight
//                || sliderDirection == .rightToLeft {
//                return valueLayer.bounds.width * proportion
//            }
//            return CGFloat.zero
//        }
    }
    
    fileprivate lazy var valueLayer: CALayer = {
        let ly = CALayer()
        ly.backgroundColor = "#FEFFFF".hexColor!.cgColor
        return ly
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createViews()
    }

    private func createViews() {
        
        layer.cornerRadius = 8
        layer.masksToBounds = true
        
        let effect = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        effect.isUserInteractionEnabled = false
        addSubview(effect)
        effect.translatesAutoresizingMaskIntoConstraints = false
        effect.topAnchor.constraint(equalTo: topAnchor).isActive = true
        effect.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        effect.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        effect.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        effect.contentView.layer.addSublayer(valueLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateFrame()
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        super.beginTracking(touch, with: event)
        let point = touch.location(in: self)
        startPoint = point
        startValueFrame = valueLayer.frame
        return true
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        super.continueTracking(touch, with: event)
        let point = touch.location(in: self)
        let valueW = startValueFrame.width
        let valueH = startValueFrame.height
        let maxH = bounds.height
        let maxW = bounds.width
        
        var x: CGFloat = 0
        var y: CGFloat = 0
        var width: CGFloat = 0
        var height: CGFloat = 0
        var difference: CGFloat = 0
        
        switch sliderDirection {
        case .topToBottom:
            difference = point.y - startPoint.y
            x = 0
            y = 0
            width = maxW
            height = max(min(valueH + difference, maxH), 0)
            break
        case .bottomToTop:
            difference = startPoint.y - point.y
            x = 0
            width = maxW
            height = max(min(valueH + difference, maxH), 0)
            y = maxH - height
            break
        case .leftToRight:
            difference = point.x - startPoint.x
            x = 0
            y = 0
            width = max(min(valueW + difference, maxW), 0)
            height = maxH
            break
        case .rightToLeft:
            difference = startPoint.x - point.x
            y = 0
            width = max(min(valueW + difference, maxW), 0)
            height = maxH
            x = maxW - width
            break
        }
        valueLayer.frame = CGRect(x: x, y: y, width: width, height: height)
        if sliderDirection == .topToBottom
            || sliderDirection == .bottomToTop {
            value = valueLayer.bounds.height * proportion + minimumValue
        } else if sliderDirection == .leftToRight
            || sliderDirection == .rightToLeft {
            value = valueLayer.bounds.width * proportion + minimumValue
        }
        sendActions(for: .valueChanged)
        return true
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        super.endTracking(touch, with: event)
        startPoint = CGPoint.zero
    }
    
    override func cancelTracking(with event: UIEvent?) {
        super.cancelTracking(with: event)
        startPoint = CGPoint.zero
    }
}

extension IFSlider {
    fileprivate var proportion: CGFloat {
        let valueDifference = CGFloat(maximumValue - minimumValue)
        var frameDifference: CGFloat = 0
        if sliderDirection == .topToBottom
            || sliderDirection == .bottomToTop {
            frameDifference = bounds.height
        } else if sliderDirection == .leftToRight
            || sliderDirection == .rightToLeft {
            frameDifference = bounds.width
        }
        return frameDifference == 0 ? 1 : valueDifference / frameDifference
    }
    
    fileprivate func updateFrame() {
        
        if sliderDirection == .topToBottom
            || sliderDirection == .bottomToTop {
            let valueFrame = valueLayer.frame
            valueLayer.frame = CGRect(origin: valueFrame.origin, size: CGSize(width: valueFrame.width, height: (value - minimumValue) / proportion))
        } else if sliderDirection == .leftToRight
            || sliderDirection == .rightToLeft {
            let valueFrame = valueLayer.frame
            valueLayer.frame = CGRect(origin: valueFrame.origin, size: CGSize(width: (value - minimumValue) / proportion, height: valueFrame.width))
        }
        
        switch sliderDirection {
        case .topToBottom:
            let valueHeight = valueLayer.bounds.height
            valueLayer.frame = CGRect(x: 0, y: 0, width: bounds.width, height: valueHeight)
            break
            
        case .bottomToTop:
            let valueHeight = valueLayer.bounds.height
            let valueY = bounds.height - valueHeight
            valueLayer.frame = CGRect(x: 0, y: valueY, width: bounds.width, height: valueHeight)
            break
            
        case .leftToRight:
            let valueWidth = valueLayer.bounds.width
            valueLayer.frame = CGRect(x: 0, y: 0, width: valueWidth, height: bounds.height)
            break
            
        case .rightToLeft:
            let valueWidth = valueLayer.bounds.width
            let valueX: CGFloat = bounds.width - valueWidth
            valueLayer.frame = CGRect(x: valueX, y: 0, width: valueWidth, height: bounds.height)
            break
        }
    }
}
