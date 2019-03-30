//
//  IFEditHomeHeaderView.swift
//  IconFont
//
//  Created by sungrow on 2019/3/29.
//  Copyright © 2019 yuqiang. All rights reserved.
//

import UIKit

class IFEditHomeHeaderView: UITableViewHeaderFooterView {

    public private(set) lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.font = UIFont.boldSystemFont(ofSize: 24)
        lbl.textAlignment = .center
        lbl.textColor = UIColor.black
        return lbl
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        createView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createView()
    }
    
    private func createView() {
        addSubview(titleLabel)
        contentView.backgroundColor = UIColor.IFBg
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(8)
            make.left.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-8)
            make.right.equalToSuperview().offset(-16)
        }
    }
}
