//
//  IconFont.swift
//  IconFont
//
//  Created by sungrow on 2019/3/18.
//  Copyright © 2019 yuqiang. All rights reserved.
//

import UIKit
import IconFontRegister

public struct IconFontStroke {
    var color: UIColor
    var width: CGFloat
}

public struct IconFontGradient {
    var backgrounds: [UIColor]
    var locations: [NSNumber]
    var start: CGPoint
    var end: CGPoint
}

public struct IconFontStyle {
    var gradient: IconFontGradient
    var stroke: IconFontStroke
    var tint: UIColor
    var size: CGSize
    var insets: UIEdgeInsets
    var orientation: UIImage.Orientation
}

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
    
    public func image(style: IconFontStyle) -> UIImage {
        let image = UIImage.ifr_image(withUnicode: unicode, fontName: fontName, gradientColors: style.gradient.backgrounds, gradientLocations: style.gradient.locations, gradientStart: style.gradient.start, gradientEnd:  style.gradient.end, iconColor: style.tint, size: style.size, imageInsets: style.insets, imageOrientation: style.orientation, stroke: style.stroke.color, strokeWidth: style.stroke.width)
        return image
    }
    
    public func image(backgrounds: [UIColor], locations: [NSNumber], start: CGPoint, end: CGPoint, tint: UIColor, size: CGSize, insets: UIEdgeInsets, orientation: UIImage.Orientation) -> UIImage  {
        let style = IconFontStyle(gradient: IconFontGradient(backgrounds: backgrounds, locations: locations, start: start, end: end), stroke: IconFontStroke(color: UIColor.clear, width: 0), tint: tint, size: size, insets: insets, orientation: orientation)
        return image(style: style)
    }
    
    public func image(background: UIColor, tint: UIColor, size: CGSize, insets: UIEdgeInsets, orientation: UIImage.Orientation) -> UIImage  {
        let image = self.image(backgrounds: [background], locations: [], start: CGPoint.zero, end: CGPoint.zero, tint: tint, size: size, insets: insets, orientation: orientation)
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
    /// 导航栏-关闭
    case navClose = 0xe633
    /// 导航栏-保存
    case navSave = 0xe629
    /// 工具栏-旋转
    case toolRotate = 0xe604
    /// 工具栏-尺寸
    case toolSize = 0xe672
    /// 工具栏-更多
    case toolMore = 0xe616
    /// 工具栏-内边距
    case toolInsets = 0xe620
    /// 工具栏-背景色
    case toolBgColor = 0xe600
    /// 工具栏-颜色
    case toolColor = 0xe652
    /// 工具栏-镜像
    case toolMirror = 0xe62f
    
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
