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
            "#CC4D33".hexColor!.cgColor,
            "#AA2C1D".hexColor!.cgColor]
        item.titleLbl.text = "字体库"
        item.titleLbl.textColor = "#E9D9A3".hexColor
        item.subTitleLbl.text = "生么是字体库"
        item.subTitleLbl.textColor = "#D59D74".hexColor
        let image = IconFontType.nodeManage.image(background: UIColor.clear, tint: "#7F2920".hexColor!, size: CGSize(width: 64, height: 64), insets: UIEdgeInsets.zero, orientation: .up)
        item.iconBtn.setImage(image, for: .normal)
        return item;
    }()
    
    public private(set) lazy var bItem: IFVerticalItem = {
        let item = IFVerticalItem()
        item.gradientColors = [
            "#F1E8DD".hexColor!.cgColor,
            "#E4D5C3".hexColor!.cgColor]
        item.titleLbl.text = "字体库"
        item.titleLbl.textColor = "#1D1C1A".hexColor
        item.subTitleLbl.text = "生么是字体库"
        item.subTitleLbl.textColor = "#8B8378".hexColor
        let image = IconFontType.nodeManage.image(background: UIColor.clear, tint: "#F9B22A".hexColor!, size: CGSize(width: 64, height: 64), insets: UIEdgeInsets.zero, orientation: .up)
        item.iconBtn.setImage(image, for: .normal)
        return item;
    }()
    
    public private(set) lazy var cItem: IFVerticalItem = {
        let item = IFVerticalItem()
        item.gradientColors = [
            "#84DDEB".hexColor!.cgColor,
            "#49C2DC".hexColor!.cgColor]
        item.titleLbl.text = "字体库"
        item.titleLbl.textColor = "#FFFFFF".hexColor
        item.subTitleLbl.text = "生么是字体库"
        item.subTitleLbl.textColor = "#C1EBF3".hexColor
        let image = IconFontType.nodeManage.image(background: UIColor.clear, tint: "#1B8398".hexColor!, size: CGSize(width: 64, height: 64), insets: UIEdgeInsets.zero, orientation: .up)
        item.iconBtn.setImage(image, for: .normal)
        return item;
    }()
    
    fileprivate lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsHorizontalScrollIndicator = false
        return scroll
    }()
    
    fileprivate lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 16
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
            make.width.equalTo(self)
        }
        
        stackView.addArrangedSubview(aItem)
        stackView.addArrangedSubview(bItem)
        stackView.addArrangedSubview(cItem)
    }
}
