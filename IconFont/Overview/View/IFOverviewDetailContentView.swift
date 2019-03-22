//
//  IFOverviewDetailContentView.swift
//  IconFont
//
//  Created by sungrow on 2019/3/22.
//  Copyright © 2019 yuqiang. All rights reserved.
//

import UIKit

class IFOverviewDetailContentView: IFGradientView {
    
    public var item: IFItem? {
        didSet {
            guard let obj = item else {
                return
            }
            var datas: [(title: String, orientation: UIImage.Orientation)] = []
            datas.append(("上", UIImage.Orientation.up))
            datas.append(("下", UIImage.Orientation.down))
            datas.append(("左", UIImage.Orientation.left))
            datas.append(("右", UIImage.Orientation.right))
            datas.append(("上•镜像", UIImage.Orientation.upMirrored))
            datas.append(("下•镜像", UIImage.Orientation.downMirrored))
            datas.append(("左•镜像", UIImage.Orientation.leftMirrored))
            datas.append(("右•镜像", UIImage.Orientation.rightMirrored))
            leftStackView.subviews.forEach { $0.removeFromSuperview() }
            rightStackView.subviews.forEach { $0.removeFromSuperview() }
            for data in datas.enumerated() {
                let itemView = IFOverviewDetailContentItem()
                itemView.nameLbl.text = data.element.title
                let image = obj.image(background: UIColor.clear, tint: UIColor.black, size: CGSize(width: 24, height: 24), insets: UIEdgeInsets.zero, orientation: data.element.orientation)
                itemView.iconImgV.image = image
                if Double(data.offset) >= Double(datas.count) * 0.5 {
                    rightStackView.addArrangedSubview(itemView)
                } else {
                    leftStackView.addArrangedSubview(itemView)                    
                }
            }
        }
    }
    
    fileprivate lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 0
        return stack
    }()
    
    fileprivate lazy var leftStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 0
        return stack
    }()
    
    fileprivate lazy var rightStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 0
        return stack
    }()
    
    override func createViews() {
        super.createViews()
        
        roundCorner = [.bottomLeft, .bottomRight]
        
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        stackView.addArrangedSubview(leftStackView)
        stackView.addArrangedSubview(rightStackView)
    }
}


class IFOverviewDetailContentItem: IFBaseView {
    
    fileprivate lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 8
        return stack
    }()
    
    public private(set) lazy var iconImgV: UIImageView = {
        let imgV = UIImageView()
        imgV.contentMode = .center
        return imgV
    }()
    
    public private(set) lazy var nameLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(red:0.47, green:0.49, blue:0.51, alpha:1.00)
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.textAlignment = .center
        return lbl
    }()
    
    override func createViews() {
        super.createViews()
        contentView.backgroundColor = UIColor.clear
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(16)
            make.bottom.right.equalToSuperview().offset(-16)
        }
        
        stackView.addArrangedSubview(nameLbl)
        stackView.addArrangedSubview(iconImgV)
    }
}
