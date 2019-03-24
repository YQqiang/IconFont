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
                let image = self.item?.image(background: UIColor(red:0.91, green:0.92, blue:0.94, alpha:1.00), tint: UIColor.IFItem, size: CGSize(width: 24 + 16, height: 24 + 16), insets: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8), orientation: .up)
                DispatchQueue.main.async(execute: {
                    self.iconBtn.setImage(image, for: .normal)
                })
            }
        }
    }
    
    fileprivate lazy var iconBtn: UIButton = {
        let btn = UIButton(type: .custom)
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
            make.top.left.equalToSuperview().offset(8)
            make.bottom.right.equalToSuperview().offset(-8)
        }
    }

}
