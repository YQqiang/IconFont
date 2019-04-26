//
//  IFHorizontalIView.swift
//  IconFont
//
//  Created by sungrow on 2019/4/26.
//  Copyright © 2019 yuqiang. All rights reserved.
//

import UIKit

class IFHorizontalView: IFBaseView {
    
    public private(set) lazy var aItem: IFVerticalItem = {
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
    
    public private(set) lazy var bItem: IFVerticalItem = {
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
    
    public private(set) lazy var cItem: IFVerticalItem = {
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
    
    public private(set) lazy var dItem: IFVerticalItem = {
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
    
    fileprivate lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        return scroll
    }()
    
    fileprivate lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 8
        return stack
    }()
    
    override func createViews() {
        super.createViews()
        
        addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.edges.width.equalToSuperview()
        }
        
        scrollView.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.height.equalToSuperview()
            make.edges.equalToSuperview()
        }
        
        stackView.addArrangedSubview(aItem)
        stackView.addArrangedSubview(bItem)
        stackView.addArrangedSubview(cItem)
        stackView.addArrangedSubview(dItem)
    }
}
