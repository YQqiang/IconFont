//
//  IFOverviewDetailTitleView.swift
//  IconFont
//
//  Created by sungrow on 2019/3/21.
//  Copyright © 2019 yuqiang. All rights reserved.
//

import UIKit

class IFOverviewDetailTitleView: IFGradientView {

    fileprivate lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 8
        return stack
    }()
    
    public private(set) lazy var iconImgV: UIImageView = {
        let imgV = UIImageView()
        imgV.contentMode = .center
        return imgV
    }()
    
    public private(set) lazy var nameLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(red:0.65, green:0.80, blue:0.68, alpha:1.00)
        lbl.font = UIFont.systemFont(ofSize: 12)
        lbl.textAlignment = .center
        return lbl
    }()
    
    override func createViews() {
        super.createViews()
        gradientColors = [
            UIColor(red:0.42, green:0.69, blue:0.47, alpha:1.00).cgColor,
            UIColor(red:0.30, green:0.60, blue:0.36, alpha:1.00).cgColor
        ]
        roundCorner = [.topLeft, .topRight]
        
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(16)
            make.bottom.right.equalToSuperview().offset(-16)
        }
        
        stackView.addArrangedSubview(iconImgV)
        stackView.addArrangedSubview(nameLbl)
    }

}
