//
//  IFEditNavBar.swift
//  IconFont
//
//  Created by sungrow on 2019/4/2.
//  Copyright © 2019 yuqiang. All rights reserved.
//

import UIKit

class IFEditNavBar: IFBaseView {
    
    var closeClosure: ((_ btn: IFButton) -> Void)?
    var saveClosure: ((_ btn: IFButton) -> Void)?
    
    fileprivate lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.alignment = .fill
        return stack
    }()
    
    fileprivate lazy var closeBtn: IFButton = {
        let btn = IFButton(type: .custom)
        let image = IconFontType.navClose.image(background: UIColor.clear, tint: UIColor.IFTabEnable, size: CGSize(width: 24, height: 24), insets: UIEdgeInsets.zero, orientation: .up)
        btn.setImage(image, for: .normal)
        btn.addTarget(self, action: #selector(closeAction(_:)), for: .touchUpInside)
        return btn
    }()
    
    public private(set) lazy var iconBtn: IFButton = {
        let btn = IFButton(type: .custom)
        return btn
    }()
    
    fileprivate lazy var saveBtn: IFButton = {
        let btn = IFButton(type: .custom)
        let image = IconFontType.navSave.image(background: UIColor.clear, tint: UIColor.IFTabEnable, size: CGSize(width: 24, height: 24), insets: UIEdgeInsets.zero, orientation: .up)
        btn.setImage(image, for: .normal)
        btn.addTarget(self, action: #selector(saveAction(_:)), for: .touchUpInside)
        return btn
    }()

    override func createViews() {
        super.createViews()
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.top.bottom.equalToSuperview()
            make.height.equalTo(44)
        }
        
        stackView.addArrangedSubview(closeBtn)
        stackView.addArrangedSubview(iconBtn)
        stackView.addArrangedSubview(saveBtn)
    }
}

extension IFEditNavBar {
    @objc fileprivate func closeAction(_ sender: IFButton) {
        if let cloure = closeClosure {
            cloure(sender)
        }
    }
    
    @objc fileprivate func saveAction(_ sender: IFButton) {
        if let cloure = saveClosure {
            cloure(sender)
        }
    }
}
