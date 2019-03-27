//
//  ColorUtil.swift
//  IconFont
//
//  Created by sungrow on 2019/3/26.
//  Copyright © 2019 yuqiang. All rights reserved.
//

import UIKit

private let colorComponentValueRange = (CGFloat(0.0) ... CGFloat(1.0))

struct RGB {
    var red: CGFloat
    var green: CGFloat
    var blue: CGFloat
    var alpha: CGFloat
    
    init(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat) {
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
    }
    
    init(_ color: UIColor) {
        self.red = 1
        self.green = 1
        self.blue = 1
        self.alpha = 1
        guard let colorSpaceModel: CGColorSpaceModel = color.cgColor.colorSpace?.model else {
            return
        }
        
        if (CGColorSpaceModel.rgb != colorSpaceModel && CGColorSpaceModel.monochrome != colorSpaceModel) {
            return
        }
        
        guard let components = color.cgColor.components else {
            return
        }
        
        if CGColorSpaceModel.monochrome == colorSpaceModel {
            self.red = components[0].clamped(to: colorComponentValueRange)
            self.green = components[0].clamped(to: colorComponentValueRange)
            self.blue = components[0].clamped(to: colorComponentValueRange)
            self.alpha = components[1].clamped(to: colorComponentValueRange)
        } else {
            self.red = components[0].clamped(to: colorComponentValueRange)
            self.green = components[1].clamped(to: colorComponentValueRange)
            self.blue = components[2].clamped(to: colorComponentValueRange)
            self.alpha = components[3].clamped(to: colorComponentValueRange)
        }
    }
    
    var hsb: HSB {
        let rd = Double(red)
        let gd = Double(green)
        let bd = Double(blue)
        let max = fmax (rd, fmax(gd, bd))
        let min = fmin(rd, fmin(gd, bd))
        var h = 0.0, b = max
        
        let d = max - min
        
        let s = max == 0 ? 0 : d / max
        
        if max == min {
            h = 0 // achromatic
        } else {
            if max == rd {
                h = (gd - bd) / d + (gd < bd ? 6 : 0)
            } else if max == gd {
                h = (bd - rd) / d + 2
            } else if max == bd {
                h = (rd - gd) / d + 4
            }
            
            h /= 6
        }
        
        return HSB(CGFloat(h), CGFloat(s), CGFloat(b), CGFloat(alpha))
    }
}

struct HSB {
    var hue: CGFloat
    var saturation: CGFloat
    var brightness: CGFloat
    var alpha: CGFloat
    
    init(_ hue: CGFloat, _ saturation: CGFloat, _ brightness: CGFloat, _ alpha: CGFloat) {
        self.hue = hue
        self.saturation = saturation
        self.brightness = brightness
        self.alpha = alpha
    }
    
    var rgb: RGB {
        var r: CGFloat = 0.0, g: CGFloat = 0.0, b: CGFloat = 0.0
        
        let i: Int = Int(hue * 6)
        let f = hue * 6 - CGFloat(i)
        let p = brightness * (1 - saturation)
        let q = brightness * (1 - f * saturation)
        let t = brightness * (1 - (1 - f) * saturation)
        
        switch i % 6 {
        case 0:
            r = brightness
            g = t
            b = p
            break
        case 1:
            r = q
            g = brightness
            b = p
            break
        case 2:
            r = p
            g = brightness
            b = t
            break
        case 3:
            r = p
            g = q
            b = brightness
            break
        case 4:
            r = t
            g = p
            b = brightness
            break
        case 5:
            r = brightness
            g = p
            b = q
            break
        default:
            break
        }
        return RGB(r, g, b, alpha)
    }
}

extension Comparable {
    func clamped(to limits: ClosedRange<Self>) -> Self {
        return min(max(self, limits.lowerBound), limits.upperBound)
    }
}

extension UIColor {
    var hexString: String? {
        guard let colorSpaceModel: CGColorSpaceModel = cgColor.colorSpace?.model else {
            return nil
        }
        
        if (CGColorSpaceModel.rgb != colorSpaceModel && CGColorSpaceModel.monochrome != colorSpaceModel) {
            return nil
        }
        
        guard let components = cgColor.components else {
            return nil
        }
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        
        if CGColorSpaceModel.monochrome == colorSpaceModel {
            red = components[0].clamped(to: colorComponentValueRange)
            green = components[0].clamped(to: colorComponentValueRange)
            blue = components[0].clamped(to: colorComponentValueRange)
            alpha = components[1].clamped(to: colorComponentValueRange)
        } else {
            red = components[0].clamped(to: colorComponentValueRange)
            green = components[1].clamped(to: colorComponentValueRange)
            blue = components[2].clamped(to: colorComponentValueRange)
            alpha = components[3].clamped(to: colorComponentValueRange)
        }
        
        return String(
            format: "#%02lX%02lX%02lX%02lX",
            UInt64(red * 0xff),
            UInt64(green * 0xff),
            UInt64(blue * 0xff),
            UInt64(alpha * 0xff)
        )
    }
}

extension String {
    var hexColor: UIColor? {
        if !hasPrefix("#") {
            return nil
        }
        
        let scanner = Scanner(string: self)
        scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
        
        var hexNum: UInt32 = 0
        if !scanner.scanHexInt32(&hexNum) {
            return nil
        }
        
        let r: CGFloat = CGFloat((hexNum >> 24) & 0xff)
        let g: CGFloat = CGFloat((hexNum >> 16) & 0xff)
        let b: CGFloat = CGFloat((hexNum >> 8) & 0xff)
        let a: CGFloat = CGFloat((hexNum) & 0xFF)
        
        return UIColor(
            red: r / 0xff,
            green: g / 0xff,
            blue: b / 0xff,
            alpha: a / 0xff
        )
    }
}
