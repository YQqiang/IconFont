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
                let image = self.item?.image(background: UIColor.clear, tint: UIColor.IFTabEnable, size: CGSize(width: 24, height: 24), insets: UIEdgeInsets.zero, orientation: .up)
                DispatchQueue.main.async(execute: {
                    self.iconBtn.setImage(image, for: .normal)
                })
            }
        }
    }
    
    fileprivate lazy var iconBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.adjustsImageWhenHighlighted = false
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
