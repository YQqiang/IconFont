//
//  IFEditToolBar.swift
//  IconFont
//
//  Created by sungrow on 2019/4/3.
//  Copyright © 2019 yuqiang. All rights reserved.
//

import UIKit

class IFEditToolBar: IFBaseView {
    
    public var sizeClosure: ((_ sender: IFButton) -> Void)?
    
    fileprivate lazy var sizeBtn: IFButton = {
        let btn = IFButton(type: .custom)
        let image = IconFontType.toolSize.image(background: UIColor.clear, tint: UIColor.IFTabEnable, size: CGSize(width: 24, height: 24), insets: UIEdgeInsets.zero, orientation: .up)
        btn.setImage(image, for: .normal)
        btn.addTarget(self, action: #selector(sizeBtnAction(_:)), for: .touchUpInside)
        return btn
    }()
    
    fileprivate lazy var bgColorBtn: IFButton = {
        let btn = IFButton(type: .custom)
        let image = IconFontType.toolBgColor.image(background: UIColor.clear, tint: UIColor.IFTabEnable, size: CGSize(width: 24, height: 24), insets: UIEdgeInsets.zero, orientation: .up)
        btn.setImage(image, for: .normal)
        return btn
    }()
    
    fileprivate lazy var colorBtn: IFButton = {
        let btn = IFButton(type: .custom)
        let image = IconFontType.toolColor.image(background: UIColor.clear, tint: UIColor.IFTabEnable, size: CGSize(width: 24, height: 24), insets: UIEdgeInsets.zero, orientation: .up)
        btn.setImage(image, for: .normal)
        return btn
    }()
    
    fileprivate lazy var insetsBtn: IFButton = {
        let btn = IFButton(type: .custom)
        let image = IconFontType.toolInsets.image(background: UIColor.clear, tint: UIColor.IFTabEnable, size: CGSize(width: 24, height: 24), insets: UIEdgeInsets.zero, orientation: .up)
        btn.setImage(image, for: .normal)
        return btn
    }()
    
    fileprivate lazy var rotateBtn: IFButton = {
        let btn = IFButton(type: .custom)
        let image = IconFontType.toolRotate.image(background: UIColor.clear, tint: UIColor.IFTabEnable, size: CGSize(width: 24, height: 24), insets: UIEdgeInsets.zero, orientation: .up)
        btn.setImage(image, for: .normal)
        return btn
    }()
    
    fileprivate lazy var mirrorBtn: IFButton = {
        let btn = IFButton(type: .custom)
        let image = IconFontType.toolMirror.image(background: UIColor.clear, tint: UIColor.IFTabEnable, size: CGSize(width: 24, height: 24), insets: UIEdgeInsets.zero, orientation: .up)
        btn.setImage(image, for: .normal)
        return btn
    }()

    fileprivate lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .fill
        
        stack.addArrangedSubview(sizeBtn)
        stack.addArrangedSubview(bgColorBtn)
        stack.addArrangedSubview(colorBtn)
        stack.addArrangedSubview(insetsBtn)
        stack.addArrangedSubview(rotateBtn)
        stack.addArrangedSubview(mirrorBtn)
        return stack
    }()

    override func createViews() {
        super.createViews()
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-16)
            make.height.equalTo(44)
        }
    }
}

extension IFEditToolBar {
    @objc fileprivate func sizeBtnAction(_ sender: IFButton) {
        if let closure = sizeClosure {
            closure(sender)
        }
    }
}
