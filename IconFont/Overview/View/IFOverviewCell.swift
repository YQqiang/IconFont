//
//  IFOverviewCell.swift
//  IconFont
//
//  Created by sungrow on 2019/3/20.
//  Copyright © 2019 yuqiang. All rights reserved.
//

import UIKit

class IFOverviewCell: UICollectionViewCell {
    
    public var item: IFItem? {
        didSet {
            DispatchQueue.global().async {
                let image = self.item?.image(background: UIColor(red:0.91, green:0.92, blue:0.94, alpha:1.00), tint: UIColor.IFItem, size: CGSize(width: 48 + 16, height: 48 + 16), insets: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8), orientation: .up)
                DispatchQueue.main.async(execute: {
                    self.iconBtn.setImage(image, for: .normal)
                })
            }
        }
    }
    
    fileprivate lazy var iconBtn: IFButton = {
        let btn = IFButton(type: .custom)
        btn.isUserInteractionEnabled = false
        btn.adjustsImageWhenHighlighted = false
        btn.layer.cornerRadius = 8
        btn.layer.masksToBounds = true
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createView()
    }
    
    private func createView() {
        contentView.addSubview(iconBtn)
        iconBtn.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(0)
            make.bottom.right.equalToSuperview().offset(0)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        iconBtn.animate(isHighlighted: true)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        iconBtn.animate(isHighlighted: false)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        iconBtn.animate(isHighlighted: false)
    }
}

extension IFOverviewCell {
    public func freezeAnimations() {
        iconBtn.scaleComment.disable = true
    }
    
    public func unfreezeAnimations() {
        iconBtn.scaleComment.disable = false
    }
}
