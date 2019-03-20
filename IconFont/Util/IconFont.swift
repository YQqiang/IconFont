//
//  IconFont.swift
//  IconFont
//
//  Created by sungrow on 2019/3/18.
//  Copyright © 2019 yuqiang. All rights reserved.
//

import UIKit
import IconFontRegister

protocol IconFontAble {
    var fontName: String { get }
    var filePath: URL { get }
    var hexValue: Int { get }
}

extension IconFontAble {
    public static func register(url: URL) {
        RegisterFontURL(url)
    }
}

extension IconFontAble {
    public var unicode: String {
        guard let scalar = UnicodeScalar(hexValue) else {
            return ""
        }
        return String(scalar)
    }
    
    public func image(background: UIColor, tint: UIColor, size: CGSize, insets: UIEdgeInsets, orientation: UIImage.Orientation) -> UIImage  {
        let image = UIImage.ifr_image(withUnicode: unicode, fontName: fontName, backgroundColor: background, iconColor: tint, size: size, imageInsets: insets, imageOrientation: orientation)
        return image
    }
}

enum IconFontType: Int {
    /// 六边形的编辑
    case editHexagon = 0xeb61
    /// 节点管理
    case nodeManage = 0xeb62
    /// 应用管理
    case appManage = 0xeb63
    /// 方块的列表
    case listChunk = 0xeb64
    
    static var name: String {
        return "YQIconFont"
    }
    
    static var path: URL {
        return URL(fileURLWithPath: Bundle.main.path(forResource: "iconfont_app", ofType: "ttf") ?? "")
    }
}

extension IconFontType: IconFontAble {
    var fontName: String {
        get {
            return IconFontType.name
        }
    }
    
    var filePath: URL {
        get {
            return IconFontType.path
        }
    }
    
    var hexValue: Int {
        get {
            return self.rawValue
        }
    }
}
