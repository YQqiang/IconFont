//
//  IFEditDetailViewController.swift
//  IconFont
//
//  Created by qiang yu on 2019/3/31.
//  Copyright © 2019 yuqiang. All rights reserved.
//

import UIKit
import RealmSwift

class IFEditDetailViewController: IFBaseViewController {

    fileprivate var item: IFItem
    
    fileprivate lazy var navBar: IFEditNavBar = {
        let bar = IFEditNavBar()
        bar.closeClosure = {[weak self] (sender) in
            self?.dismissSelf()
        }
        bar.saveClosure = {[weak self] (sender) in
            
        }
        return bar
    }()
    
    fileprivate lazy var toolBar: IFEditToolBar = {
        let bar = IFEditToolBar()
        bar.sizeClosure = {[weak self] (sender) in
            let toolVC: IFCalculatorController = IFCalculatorController(sourceView: sender)
            self?.present(toolVC, animated: true, completion: nil)
        }
        return bar
    }()
    
    fileprivate lazy var contentIconView: IFEditContentIconView = {
        let v = IFEditContentIconView()
        v.contentView.backgroundColor = UIColor.clear
        return v
    }()
    
    init(item: IFItem) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(navBar)
        navBar.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
        }
        
        view.addSubview(toolBar)
        toolBar.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
        }
        
        let bgSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.65)
        view.addSubview(contentIconView)
        contentIconView.snp.makeConstraints { (make) in
            make.top.equalTo(navBar.snp.bottom)
            make.left.right.equalToSuperview()
            make.size.equalTo(bgSize)
        }
        
        let image = item.image(background: UIColor.clear, tint: UIColor.IFItem, size: CGSize(width: 140, height: 140), insets: UIEdgeInsets.zero, orientation: .up)
        contentIconView.iconBtn.setImage(image, for: .normal)
    }
    
    override var previewActionItems: [UIPreviewActionItem] {
        let realm = try! Realm()
        let filter = "fontName = '\(self.item.fontName)' AND hexString BEGINSWITH '\(self.item.hexString)'"
        let collection = realm.objects(IFItem.self).filter(filter)
        // 收藏
        if collection.count == 1 {
            let action = UIPreviewAction(title: "收藏", style: .default) { (action, viewControlelr) in
                try! realm.write {
                    realm.add(self.item)
                }
            }
            return [action]
        }
        // 取消收藏
        else {
            let action = UIPreviewAction(title: "取消收藏", style: .default) { (action, viewControlelr) in
                try! realm.write {
                    realm.delete(collection.first!)
                }
            }
            return [action]
        }
    }
}

extension IFEditDetailViewController {
    
    fileprivate func icon(backgrounds: [UIColor], locations: [NSNumber], start: CGPoint, end: CGPoint, tint: UIColor, size: CGSize, insets: UIEdgeInsets, orientation: UIImage.Orientation) -> UIImage {
        return item.image(backgrounds: backgrounds, locations: locations, start: start, end: end, tint: tint, size: size, insets: insets, orientation: orientation)
    }
    
    fileprivate func dismissSelf() {
        dismiss(animated: true, completion: nil)
    }
}
