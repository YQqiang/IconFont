//
//  IFHorizontalItem.swift
//  IconFont
//
//  Created by sungrow on 2019/4/25.
//  Copyright © 2019 yuqiang. All rights reserved.
//

import UIKit

class IFHorizontalItem: IFGradientView {
    
    public private(set) lazy var titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 25)
        return lbl
    }()
    
    public private(set) lazy var subTitleLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 13)
        return lbl
    }()
    
    public private(set) lazy var iconBtn: UIButton = {
        let btn = UIButton()
        btn.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
        return btn;
    }()
    
    override func createViews() {
        super.createViews()
        
        roundRadius = 8
        roundCorner = .allCorners
        
        let lblView = UIView()
        lblView.addSubview(titleLbl)
        titleLbl.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
        }
        lblView.addSubview(subTitleLbl)
        subTitleLbl.snp.makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview()
            make.top.equalTo(titleLbl.snp.bottom).offset(4)
        }
        
        contentView.addSubview(lblView)
        lblView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(24)
        }
        
        contentView.addSubview(iconBtn)
        iconBtn.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(24)
            make.bottom.equalToSuperview().offset(-24)
            make.right.equalToSuperview().offset(-24)
            make.left.equalTo(lblView.snp.right).offset(8)
        }
    }
}
