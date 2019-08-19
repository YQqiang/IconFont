//
//  IFEditToolBar.swift
//  IconFont
//
//  Created by sungrow on 2019/4/3.
//  Copyright © 2019 yuqiang. All rights reserved.
//

import UIKit

enum IFEditToolType {
    case size
    case bgColor
    case color
    case insets
    case rotate
    case mirror
    case corners
}

class IFEditToolBar: IFBaseView {
    
    public var closure: ((_ type: IFEditToolType, _ sender: IFButton) -> Void)?
    
    fileprivate lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .fill
        let types: [IconFontType] = [.toolSize,
                                     .toolBgColor,
                                     .toolColor,
                                     .toolInsets,
                                     .toolRotate,
                                     .toolMirror,
                                     .toolCorners]
        for type in types {
            let btn = IFButton(type: .custom)
            btn.tag = type.rawValue
            let image = type.image(background: UIColor.clear, tint: UIColor.IFTabEnable, size: CGSize(width: 24, height: 24), insets: UIEdgeInsets.zero, orientation: .up)
            btn.setImage(image, for: .normal)
            btn.addTarget(self, action: #selector(btnAction(_:)), for: .touchUpInside)
            stack.addArrangedSubview(btn)
        }
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
    @objc fileprivate func btnAction(_ sender: IFButton) {
        guard let closure = closure else {
            return
        }
        guard let iconType = IconFontType(rawValue: sender.tag) else {
            return
        }
        var type: IFEditToolType = .size
        if iconType == IconFontType.toolSize {
            type = .size
        }
        if iconType == IconFontType.toolBgColor {
            type = .bgColor
        }
        if iconType == IconFontType.toolColor {
            type = .color
        }
        if iconType == IconFontType.toolInsets {
            type = .insets
        }
        if iconType == IconFontType.toolRotate {
            type = .rotate
        }
        if iconType == IconFontType.toolMirror {
            type = .mirror
        }
        if iconType == IconFontType.toolCorners {
            type = .corners
        }
        closure(type, sender)
    }
}
