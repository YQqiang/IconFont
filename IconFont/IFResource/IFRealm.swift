//
//  IFRealm.swift
//  IconFont
//
//  Created by sungrow on 2019/5/14.
//  Copyright © 2019 yuqiang. All rights reserved.
//

import Foundation
import RealmSwift

struct IFRealm {
    
    private static let realm = try! Realm()
    
    /// 所有收藏的图标
    ///
    /// - Returns: 收藏图标
    static func collections() -> Results<IFItem> {
        return realm.objects(IFItem.self)
    }
    
    /// 收藏
    ///
    /// - Parameter item: 字体
    static func collection(item: IFItem) {
        if !IFRealm.isCollection(item: item) {
            try! realm.write {
                realm.add(item)
            }
        }
    }
    
    /// 取消收藏
    ///
    /// - Parameter item: 字体
    static func cancelCollection(item: IFItem) {
        if IFRealm.isCollection(item: item) {
            try! realm.write {
                realm.delete(IFRealm.filter(fontName: item.fontName, hex: item.hexString))
            }
        }
    }
    
    /// 是否收藏
    ///
    /// - Parameter item: 字体
    /// - Returns: true 已收藏
    static func isCollection(item: IFItem) -> Bool {
        let collection = IFRealm.filter(fontName: item.fontName, hex: item.hexString)
        return collection.count > 0
    }
    
    /// 过滤指定收藏的字体图标
    ///
    /// - Parameters:
    ///   - fontName: 字体名称
    ///   - hex: 字体的十六进制字符串
    /// - Returns: 结果集
    static func filter(fontName: String, hex: String) -> Results<IFItem> {
        let filter = "fontName = '\(fontName)' AND hexString BEGINSWITH '\(hex)'"
        let collection = IFRealm.collections().filter(filter)
        return collection
    }
}
