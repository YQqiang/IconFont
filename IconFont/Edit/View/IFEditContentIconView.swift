//
//  IFEditContentIconView.swift
//  IconFont
//
//  Created by sungrow on 2019/4/2.
//  Copyright © 2019 yuqiang. All rights reserved.
//

import UIKit

class IFEditContentIconView: IFBaseView {
    
    var iconImage: UIImage? {
        didSet {
            iconBtn.setImage(iconImage, for: .normal)
        }
    }
    
    public private(set) lazy var iconBtn: IFButton = {
        let btn = IFButton(type: .custom)
        return btn
    }()

    override func createViews() {
        super.createViews()
        contentView.addSubview(iconBtn)
        iconBtn.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }

}
