//
//  IFEditToolBar.swift
//  IconFont
//
//  Created by sungrow on 2019/4/3.
//  Copyright © 2019 yuqiang. All rights reserved.
//

import UIKit

class IFEditToolBar: IFBaseView {
    
    fileprivate lazy var sizeBtn: IFButton = {
        let btn = IFButton(type: .custom)
        let image = IconFontType.toolSize.image(background: UIColor.clear, tint: UIColor.IFTabEnable, size: CGSize(width: 24, height: 24), insets: UIEdgeInsets.zero, orientation: .up)
        btn.setImage(image, for: .normal)
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
            make.left.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(0)
            make.top.bottom.equalToSuperview()
            make.height.equalTo(44)
        }
    }
}
