//
//  IFMainTabBar.swift
//  IconFont
//
//  Created by sungrow on 2019/3/18.
//  Copyright © 2019 yuqiang. All rights reserved.
//

import UIKit
import SnapKit

class IFMainTabBar: IFBaseView {
    
    public private(set) lazy var tabBar: UITabBar = {
        let tab = UITabBar()
        tab.tintColor = UIColor.IFTabEnable
        tab.barTintColor = UIColor.IFTabBg
        tab.clipsToBounds = true
        return tab
    }()
    
    override func createViews() {
        super.createViews()
        
        backgroundColor = UIColor.clear
        
        let superView = IFRoundShadowView()
        superView.backgroundColor = UIColor.IFTabBg
        let radius: CGFloat = 22
        superView.cornerRadius = radius
        superView.fillColor = UIColor.IFTabBg
        
        contentView.addSubview(superView)
        contentView.backgroundColor = UIColor.clear
        superView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-32)
            make.centerX.equalToSuperview()
        }
        
        superView.addSubview(tabBar)
        tabBar.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(radius)
            make.right.equalToSuperview().offset(-radius)
            make.height.equalTo(radius * 2)
        }
        
        let image1 = IconFontType.nodeManage.image(background: UIColor.clear, tint: UIColor.red, size: CGSize(width: 24, height: 24), insets: UIEdgeInsets.zero, orientation: .up)
        let item1 = UITabBarItem(title: "预览", image: image1, selectedImage: nil)
        
        let image2 = IconFontType.appManage.image(background: UIColor.clear, tint: UIColor.red, size: CGSize(width: 24, height: 24), insets: UIEdgeInsets.zero, orientation: .up)
        let item2 = UITabBarItem(title: "列表", image: image2, selectedImage: nil)
        
        let image3 = IconFontType.editHexagon.image(background: UIColor.clear, tint: UIColor.red, size: CGSize(width: 24, height: 24), insets: UIEdgeInsets.zero, orientation: .up)
        let item3 = UITabBarItem(title: "编辑", image: image3, selectedImage: nil)
        
        tabBar.items = [item1, item2, item3]
        
    }

}
