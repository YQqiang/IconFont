//
//  IFIntroductionViewController.swift
//  IconFont
//
//  Created by qiang yu on 2019/3/22.
//  Copyright © 2019 yuqiang. All rights reserved.
//

import UIKit

class IFIntroductionViewController: IFBaseViewController {
    
    fileprivate lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 20 + 44, right: 16)
        return scroll
    }()
    
    fileprivate lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 24
        return stack
    }()
    
    fileprivate lazy var defineItem: IFHorizontalItem = {
        let item = IFHorizontalItem()
        item.gradientColors = [
            "#6AB27A".hexColor!.cgColor,
            "#3E9553".hexColor!.cgColor]
        item.titleLbl.text = "已收藏"
        item.titleLbl.textColor = "#F0E8AF".hexColor
        item.subTitleLbl.text = "我喜欢的图标"
        item.subTitleLbl.textColor = "#C5D59C".hexColor
        let image = IconFontType.nodeManage.image(background: UIColor.clear, tint: item.titleLbl.textColor!, size: CGSize(width: 64, height: 64), insets: UIEdgeInsets.zero, orientation: .up)
        item.iconBtn.setImage(image, for: .normal)
        item.tapClosure = { (_) in
            print("tap")
        }
        return item;
    }()
    
    fileprivate lazy var scopeItem: IFHorizontalItem = {
        let item = IFHorizontalItem()
        item.gradientColors = [
            "#E2E6E9".hexColor!.cgColor,
            "#CBD3D8".hexColor!.cgColor]
        item.titleLbl.text = "功能介绍"
        item.titleLbl.textColor = "#0D0E0E".hexColor
        item.subTitleLbl.text = "实现了什么功能"
        item.subTitleLbl.textColor = "#8D9194".hexColor
        let image = IconFontType.editHexagon.image(background: UIColor.clear, tint: item.titleLbl.textColor!, size: CGSize(width: 64, height: 64), insets: UIEdgeInsets.zero, orientation: .up)
        item.iconBtn.setImage(image, for: .normal)
        return item;
    }()
    
    fileprivate lazy var codeItem: IFHorizontalItem = {
        let item = IFHorizontalItem()
        item.gradientColors = [
            "#E2E6E9".hexColor!.cgColor,
            "#CBD3D8".hexColor!.cgColor]
        item.titleLbl.text = "功能介绍"
        item.titleLbl.textColor = "#0D0E0E".hexColor
        item.subTitleLbl.text = "实现了什么功能"
        item.subTitleLbl.textColor = "#8D9194".hexColor
        let image = IconFontType.editHexagon.image(background: UIColor.clear, tint: item.titleLbl.textColor!, size: CGSize(width: 64, height: 64), insets: UIEdgeInsets.zero, orientation: .up)
        item.iconBtn.setImage(image, for: .normal)
        return item;
    }()
    
    fileprivate lazy var horizontalView: IFHorizontalView = {
        let view = IFHorizontalView()
        return view
    }()
    
    fileprivate lazy var sourceItem: IFVerticalItem = {
        let item = IFVerticalItem()
        item.gradientColors = [
            "#6AB27A".hexColor!.cgColor,
            "#3E9553".hexColor!.cgColor]
        item.titleLbl.text = "字体库"
        item.titleLbl.textColor = "#F0E8AF".hexColor
        item.subTitleLbl.text = "生么是字体库"
        item.subTitleLbl.textColor = "#C5D59C".hexColor
        let image = IconFontType.nodeManage.image(background: UIColor.clear, tint: item.titleLbl.textColor!, size: CGSize(width: 64, height: 64), insets: UIEdgeInsets.zero, orientation: .up)
        item.iconBtn.setImage(image, for: .normal)
        return item;
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "简介"
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.edges.width.equalToSuperview()
        }
        
        scrollView.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.width.equalToSuperview().offset(-32)
            make.edges.equalToSuperview()
        }
        
        stackView.addArrangedSubview(defineItem)
        stackView.addArrangedSubview(scopeItem)
        stackView.addArrangedSubview(horizontalView)
        stackView.addArrangedSubview(codeItem)
        stackView.addArrangedSubview(sourceItem)
        
        let bgV = UIView()
        view.addSubview(bgV)
        bgV.backgroundColor = UIColor.white
        bgV.frame = view.bounds
        
        let slider = IFSlider()
        bgV.addSubview(slider)
        slider.backgroundColor = UIColor.red
        slider.frame = CGRect(x: 32, y: 32, width: 64, height: 300)
    }
}
