//
//  IFBaseView.swift
//  IconFont
//
//  Created by sungrow on 2019/3/18.
//  Copyright © 2019 yuqiang. All rights reserved.
//

import UIKit

class IFBaseView: UIView {
    
    public var autoAnimate: Bool = true
    
    public private(set) lazy var contentView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.white
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createViews()
    }
    
    public func createViews() {
        addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            if #available(iOS 11.0, *) {
                make.top.equalTo(safeAreaLayoutGuide.snp.top)
            } else {
                make.top.equalToSuperview()
            }
            
            if #available(iOS 11.0, *) {
                make.leading.equalTo(safeAreaLayoutGuide.snp.leading)
            } else {
                make.leading.equalToSuperview()
            }
            
            if #available(iOS 11.0, *) {
                make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
            } else {
                make.bottom.equalToSuperview()
            }
            
            if #available(iOS 11.0, *) {
                make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing)
            } else {
                make.trailing.equalToSuperview()
            }
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        if autoAnimate {
            animate(isHighlighted: true)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        if autoAnimate {
            animate(isHighlighted: false)
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        if autoAnimate {
            animate(isHighlighted: false)
        }
    }
}
