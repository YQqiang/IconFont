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
    
    public var items: [UITabBarItem]? {
        didSet {
            tabBar.items = items
        }
    }
    
    public var selectItem: UITabBarItem? {
        didSet {
            tabBar.selectedItem = selectItem
        }
    }
    
    public var didSelectItem: ((_ tabBar: UITabBar, _ item: UITabBarItem) -> Void)?
    
    public private(set) lazy var tabBar: UITabBar = {
        let tab = UITabBar()
        tab.tintColor = UIColor.IFTabEnable
        tab.barTintColor = UIColor.IFTabBg
        tab.clipsToBounds = true
        tab.delegate = self
        return tab
    }()
    
    override func createViews() {
        super.createViews()
        
        backgroundColor = UIColor.clear
        
        let superView = IFRoundShadowView()
        superView.contentView.backgroundColor = UIColor.clear
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
    }

}

extension IFMainTabBar: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if let closure = didSelectItem {
            closure(tabBar, item)
        }
    }
}
