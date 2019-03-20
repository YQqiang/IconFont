//
//  IFItem.swift
//  IconFont
//
//  Created by sungrow on 2019/3/20.
//  Copyright © 2019 yuqiang. All rights reserved.
//

import Foundation
import Kanna

struct IFItem: IconFontAble {
    public var fontName: String
    
    public var filePath: URL
    
    public var hexValue: Int {
        get {
            return Int(hexString, radix: 16) ?? 0xffffff
        }
    }
    
    public var hexString: String = ""
    public var name: String = ""
    
    init(fontName: String, filePath: URL, hexString: String, name: String) {
        self.fontName = fontName
        self.filePath = filePath
        self.hexString = hexString
        self.name = name
    }
}

struct IFGroupItem {
    public var fontName: String
    
    public var fontPath: URL
    
    public var htmlPath: URL
    
    public lazy var items: [IFItem] = {
        let doc = try? HTML(url: htmlPath, encoding: .utf8)
        guard let ul = doc?.body?.xpath("//div[@class='content unicode']/ul/li") else {
            return []
        }
        var itemArray = [IFItem]()
        for li in ul.enumerated() {
            let name = li.element.at_xpath("div[@class='name']")?.content ?? ""
            let hexString = li.element.at_xpath("div[@class='code-name']")?.content ?? ""
            let item = IFItem(fontName: fontName, filePath: fontPath, hexString: hexString.trimmingCharacters(in: CharacterSet(charactersIn: "&#x;")), name: name)
            itemArray.append(item)
        }
        return itemArray
    }()
    
    init(fontName: String, fontPath: URL, htmlPath: URL) {
        self.fontName = fontName
        self.fontPath = fontPath
        self.htmlPath = htmlPath
    }
    
    public func register() {
        IconFontType.register(url: fontPath)
    }
}
