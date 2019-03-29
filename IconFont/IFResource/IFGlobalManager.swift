//
//  IFGlobalManager.swift
//  IconFont
//
//  Created by sungrow on 2019/3/29.
//  Copyright © 2019 yuqiang. All rights reserved.
//

import Foundation

class IFGlobalManager {
    private init() {}
    static let shared: IFGlobalManager = IFGlobalManager()
    
    /// 所有的icon信息
    public private(set) lazy var items: [IFGroupItem] = {
        var datas: [(html: String, file: String, icon: String, title: String)] = []
        //        datas.append(("weather_index.html",
        //                      "weather_iconfont.ttf",
        //                      "weather_iconfont",
        //                      "天气"))
        datas.append(("creativeLetters_index.html",
                      "creativeLetters_iconfont.ttf",
                      "creative_letters_iconfont",
                      "创意字母"))
        datas.append(("beautyMakeup_index.html",
                      "beautyMakeup_iconfont.ttf",
                      "beauty_makeup_iconfont",
                      "美妆"))
        datas.append(("sportMovement_index.html",
                      "sportMovement_iconfont.ttf",
                      "sports_movement_iconfont",
                      "体育运动"))
        datas.append(("sportProject_index.html",
                      "sportProject_iconfont.ttf",
                      "sport_project_iconfont",
                      "体育项目"))
        datas.append(("dingding_index.html",
                      "dingding_iconfont.ttf",
                      "dingding_iconfont",
                      "钉钉"))
        var groups: [IFGroupItem] = []
        for data in datas {
            let htmlPath = Bundle.main.path(forResource: data.html, ofType: nil) ?? ""
            let htmlPathUrl = URL(fileURLWithPath: htmlPath)
            
            let fontPath = Bundle.main.path(forResource: data.file, ofType: nil) ?? ""
            let fontPathUrl = URL(fileURLWithPath: fontPath)
            
            let group = IFGroupItem(title: data.title, fontName: data.icon, fontPath: fontPathUrl, htmlPath: htmlPathUrl)
            group.register()
            groups.append(group)
        }
        return groups
    }()
}
