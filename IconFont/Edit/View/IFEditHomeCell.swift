//
//  IFEditHomeCell.swift
//  IconFont
//
//  Created by sungrow on 2019/3/29.
//  Copyright © 2019 yuqiang. All rights reserved.
//

import UIKit

class IFEditHomeCell: UITableViewCell {

    public var item: IFItem? {
        didSet {
            DispatchQueue.global().async {
                let image = self.item?.image(background: UIColor(red:0.91, green:0.92, blue:0.94, alpha:1.00), tint: UIColor.IFItem, size: CGSize(width: 120, height: 120), insets: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16), orientation: .up)
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
        btn.imageView?.layer.cornerRadius = 16
        btn.imageView?.layer.masksToBounds = true
        return btn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createView()
    }
    
    private func createView() {
        selectionStyle = .none
        contentView.addSubview(iconBtn)
        iconBtn.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(8)
            make.bottom.right.equalToSuperview().offset(-8)
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

extension IFEditHomeCell {
    public func freezeAnimations() {
        iconBtn.scaleComment.disable = true
    }
    
    public func unfreezeAnimations() {
        iconBtn.scaleComment.disable = false
    }
}
