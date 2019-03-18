//
//  IconFont.swift
//  IconFont
//
//  Created by sungrow on 2019/3/18.
//  Copyright © 2019 yuqiang. All rights reserved.
//

import UIKit
import IconFontRegister

enum IconFontType: Int {
    /// 六边形的编辑
    case editHexagon = 0xeb61
    /// 节点管理
    case nodeManage = 0xeb62
    /// 应用管理
    case appManage = 0xeb63
    /// 方块的列表
    case listChunk = 0xeb64
    
}

extension IconFontType {
    static fileprivate var fontName: String {
        return "YQIconFont"
    }
    
    static fileprivate var fileName: String {
        return "iconfont_app"
    }
    
    static func register() {
        RegisterFontWithOnlyName(fileName)
    }
}

extension IconFontType {
    public var unicode: String {
        guard let scalar = UnicodeScalar(self.rawValue) else {
            return ""
        }
        return String(scalar)
    }
    
    public func image(background: UIColor, tint: UIColor, size: CGSize, insets: UIEdgeInsets, orientation: UIImage.Orientation) -> UIImage  {
        let image = UIImage.ifr_image(withUnicode: self.unicode, fontName: IconFontType.fontName, backgroundColor: background, iconColor: tint, size: size, imageInsets: insets, imageOrientation: orientation)
        return image
    }
}
