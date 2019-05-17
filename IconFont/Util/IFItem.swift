//
//  IFItem.swift
//  IconFont
//
//  Created by sungrow on 2019/3/20.
//  Copyright © 2019 yuqiang. All rights reserved.
//

import Foundation
import Kanna
import RealmSwift

class IFItem: Object, IconFontAble {
    @objc dynamic public var fontName: String = ""
    
    @objc dynamic public var fontPath: String = ""
    
    public var filePath: URL {
        return URL(string: fontPath)!
    }
    
    public var hexValue: Int {
        get {
            return Int(hexString, radix: 16) ?? 0xffffff
        }
    }
    
    @objc dynamic public var hexString: String = ""
    @objc dynamic public var name: String = ""
    
    convenience init(fontName: String, fontPath: String, hexString: String, name: String) {
        self.init()
        self.fontName = fontName
        self.fontPath = fontPath
        self.hexString = hexString
        self.name = name
    }
}

struct IFGroupItem {
    
    public var title: String
    
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
            let item = IFItem(fontName: fontName, fontPath: fontPath.absoluteString, hexString: hexString.trimmingCharacters(in: CharacterSet(charactersIn: "&#x;")), name: name)
            itemArray.append(item)
        }
        return itemArray
    }()
    
    init(title: String, fontName: String, fontPath: URL, htmlPath: URL) {
        self.title = title
        self.fontName = fontName
        self.fontPath = fontPath
        self.htmlPath = htmlPath
    }
    
    public func register() {
        IconFontType.register(url: fontPath)
    }
}
