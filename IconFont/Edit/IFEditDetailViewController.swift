//
//  IFEditDetailViewController.swift
//  IconFont
//
//  Created by qiang yu on 2019/3/31.
//  Copyright © 2019 yuqiang. All rights reserved.
//

import UIKit

class IFEditDetailViewController: IFBaseViewController {

    fileprivate var item: IFItem
    
    fileprivate lazy var orientation: UIImage.Orientation = .up
    
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
        bar.rotateClosure = {[weak self] (sender) in
            guard let direction = self?.orientation else {
                return
            }
            switch direction {
            case .up:
                self?.orientation = .right
                break
            case .right:
                self?.orientation = .down
                break
            case .down:
                self?.orientation = .left
                break
            case .left:
                self?.orientation = .up
                break
            case .upMirrored:
                self?.orientation = .rightMirrored
                break
            case .rightMirrored:
                self?.orientation = .downMirrored
                break
            case .downMirrored:
                self?.orientation = .leftMirrored
                break
            case .leftMirrored:
                self?.orientation = .upMirrored
                break
            }
            self?.updateIcon()
        }
        bar.mirrorClosure = {[weak self] (sender) in
            guard let direction = self?.orientation else {
                return
            }
            switch direction {
            case .up:
                self?.orientation = .upMirrored
                break
            case .upMirrored:
                self?.orientation = .up
                break
            case .down:
                self?.orientation = .downMirrored
                break
            case .downMirrored:
                self?.orientation = .down
                break
            case .left:
                self?.orientation = .leftMirrored
                break
            case .leftMirrored:
                self?.orientation = .left
                break
            case .right:
                self?.orientation = .rightMirrored
                break
            case .rightMirrored:
                self?.orientation = .right
                break
            }
            self?.updateIcon()
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
        // 收藏
        if !IFRealm.isCollection(item: item) {
            let action = UIPreviewAction(title: "收藏", style: .default) { (action, viewControlelr) in
                IFRealm.collection(item: self.item)
            }
            return [action]
        }
        // 取消收藏
        else {
            let action = UIPreviewAction(title: "取消收藏", style: .destructive) { (action, viewControlelr) in
                IFRealm.cancelCollection(item: self.item)
            }
            return [action]
        }
    }
}

extension IFEditDetailViewController {
    
    fileprivate func updateIcon() {
        let image = icon(backgrounds: [UIColor.clear], locations: [1.0], start: CGPoint.zero, end: CGPoint.zero, tint: UIColor.IFItem, size: CGSize(width: 140, height: 140), insets: UIEdgeInsets.zero, orientation: orientation)
        self.contentIconView.iconImage = image
    }
    
    fileprivate func icon(backgrounds: [UIColor], locations: [NSNumber], start: CGPoint, end: CGPoint, tint: UIColor, size: CGSize, insets: UIEdgeInsets, orientation: UIImage.Orientation) -> UIImage {
        return item.image(backgrounds: backgrounds, locations: locations, start: start, end: end, tint: tint, size: size, insets: insets, orientation: orientation)
    }
    
    fileprivate func dismissSelf() {
        dismiss(animated: true, completion: nil)
    }
}
