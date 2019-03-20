//
//  IFOverviewHeaderView.swift
//  IconFont
//
//  Created by sungrow on 2019/3/20.
//  Copyright © 2019 yuqiang. All rights reserved.
//

import UIKit

class IFOverviewHeaderView: UICollectionReusableView {
    
    public private(set) lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.font = UIFont.boldSystemFont(ofSize: 30)
        lbl.textAlignment = .center
        lbl.textColor = UIColor.black
        return lbl
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
        addSubview(titleLabel)
        backgroundColor = UIColor.IFBg
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(8)
            make.left.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-8)
            make.right.equalToSuperview().offset(-16)
        }
    }
}
