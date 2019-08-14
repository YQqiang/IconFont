//
//  IFSlider.swift
//  IconFont
//
//  Created by sungrow on 2019/7/31.
//  Copyright © 2019 yuqiang. All rights reserved.
//

import UIKit

public enum SliderDirection {
    case topToBottom
    case bottomToTop
    case leftToRight
    case rightToLeft
}

class IFSlider: UIControl {
    
    public var sliderDirection: SliderDirection = .bottomToTop {
        didSet {
            updateFrame()
        }
    }
    
    public var showMinimumValue = true {
        didSet {
            updateMinimumValue()
        }
    }
    public var showMaximumValue = true {
        didSet {
            updateMaximumValue()
        }
    }
    
    public private(set) var minimumValue: CGFloat = 0.0 {
        didSet {
            updateMinimumValue()
        }
    }
    
    public private(set) var maximumValue: CGFloat = 1.0 {
        didSet {
            updateMaximumValue()
        }
    }
    
    public private(set) var value: CGFloat = 0.5
    
    public private(set) var minimumButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitleColor("#D2D3D4".hexColor!, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.isUserInteractionEnabled = false
        return btn
    }()
    
    public private(set) var maximumButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitleColor("#D2D3D4".hexColor!, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.isUserInteractionEnabled = false
        return btn
    }()
    
    fileprivate var startPoint = CGPoint.zero
    
    fileprivate var startValueFrame = CGRect.zero
    
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
        
        effect.contentView.addSubview(minimumButton)
        effect.contentView.addSubview(maximumButton)
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
        
        let space: CGFloat = 16
        minimumButton.sizeToFit()
        maximumButton.sizeToFit()
        switch sliderDirection {
        case .topToBottom:
            let valueHeight = valueLayer.bounds.height
            valueLayer.frame = CGRect(x: 0, y: 0, width: bounds.width, height: valueHeight)
            minimumButton.center = CGPoint(x: bounds.width * 0.5, y: space + minimumButton.bounds.height * 0.5)
            maximumButton.center = CGPoint(x: bounds.width * 0.5, y: bounds.height - space - maximumButton.bounds.height * 0.5)
            break
            
        case .bottomToTop:
            let valueHeight = valueLayer.bounds.height
            let valueY = bounds.height - valueHeight
            valueLayer.frame = CGRect(x: 0, y: valueY, width: bounds.width, height: valueHeight)
            minimumButton.center = CGPoint(x: bounds.width * 0.5, y: bounds.height - space - minimumButton.bounds.height * 0.5)
            maximumButton.center = CGPoint(x: bounds.width * 0.5, y: space + maximumButton.bounds.height * 0.5)
            break
            
        case .leftToRight:
            let valueWidth = valueLayer.bounds.width
            valueLayer.frame = CGRect(x: 0, y: 0, width: valueWidth, height: bounds.height)
            minimumButton.center = CGPoint(x: space + minimumButton.bounds.width * 0.5, y: bounds.height * 0.5)
            maximumButton.center = CGPoint(x: bounds.width - space - maximumButton.bounds.width * 0.5, y: bounds.height * 0.5)
            break
            
        case .rightToLeft:
            let valueWidth = valueLayer.bounds.width
            let valueX: CGFloat = bounds.width - valueWidth
            valueLayer.frame = CGRect(x: valueX, y: 0, width: valueWidth, height: bounds.height)
            minimumButton.center = CGPoint(x: bounds.width - space - minimumButton.bounds.width * 0.5, y: bounds.height * 0.5)
            maximumButton.center = CGPoint(x: space + maximumButton.bounds.width * 0.5, y: bounds.height * 0.5)
            break
        }
    }
    
    fileprivate func updateMinimumValue() {
        minimumButton.setTitle(showMinimumValue ? "\(minimumValue)" : "", for: .normal)
    }
    
    fileprivate func updateMaximumValue() {
        maximumButton.setTitle(showMaximumValue ? "\(maximumValue)" : "", for: .normal)
    }
}

extension IFSlider {
    func configValue(minimum: CGFloat, maximum: CGFloat, value: CGFloat) {
        guard minimum <= maximum else {
            return
        }
        guard value <= maximum else {
            return
        }
        guard value >= minimum else {
            return
        }
        maximumValue = maximum
        minimumValue = minimum
        self.value = value
        updateFrame()
    }
}
