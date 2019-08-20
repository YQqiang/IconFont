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
    
    fileprivate lazy var imageSize: CGSize = CGSize(width: 140, height: 140)
    fileprivate lazy var orientation: UIImage.Orientation = .up
    fileprivate lazy var bgColor: UIColor = UIColor.clear
    fileprivate lazy var insets: UIEdgeInsets = UIEdgeInsets.zero
    
    fileprivate lazy var tintColor: UIColor = UIColor.IFItem
    
    fileprivate lazy var navBar: IFEditNavBar = {
        let bar = IFEditNavBar()
        bar.closeClosure = {[weak self] (sender) in
            self?.dismissSelf()
        }
        bar.saveClosure = {[weak self] (sender) in
            guard let image = self?.contentIconView.iconImage else {
                return
            }
            let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
            self?.present(activityViewController, animated: true, completion: nil)
        }
        return bar
    }()
    
    fileprivate lazy var toolBar: IFEditToolBar = {
        let bar = IFEditToolBar()
        bar.closure = { [weak self] (type, sender) in
            switch type {
            case .size:
                let toolVC: IFCalculatorController = IFCalculatorController(sourceView: sender)
                toolVC.valueDidChanged = {[weak self] (value, vc) in
                    let wh = Int(value) ?? 0
                    self?.imageSize = CGSize(width: wh, height: wh)
                    self?.updateIcon()
                    vc.dismiss(animated: true, completion: nil)
                }
                self?.present(toolVC, animated: true, completion: nil)
                break
            case .bgColor:
                let toolVC: IFColorController = IFColorController(sourceView: sender)
                toolVC.colorDidChanged = { (color) in
                    self?.bgColor = color
                    self?.updateIcon()
                }
                self?.present(toolVC, animated: true, completion: nil)
                break
            case .color:
                let toolVC: IFColorController = IFColorController(sourceView: sender)
                toolVC.colorDidChanged = { (color) in
                    self?.tintColor = color
                    self?.updateIcon()
                }
                self?.present(toolVC, animated: true, completion: nil)
                break
            case .insets:
                break
            case .rotate:
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
                break
            case .mirror:
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
                break
            case .corners: break
            }
        }
        return bar
    }()
    
    fileprivate lazy var contentIconView: IFEditContentIconView = {
        let v = IFEditContentIconView()
        v.contentView.backgroundColor = UIColor.clear
        v.isUserInteractionEnabled = false
        v.iconBtn.layer.cornerRadius = 8;
        v.iconBtn.layer.masksToBounds = true
        return v
    }()
    
    fileprivate lazy var sliderStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        
        let screenWidth = UIScreen.main.bounds.width
        let sizeSlider = IFSlider()
        sizeSlider.sliderDirection = .leftToRight
        sizeSlider.showMinimumValue = false
        sizeSlider.showMaximumValue = false
        sizeSlider.minimumButton.setImage(IconFontType.toolSize.image(background: UIColor.clear, tint: "#D2D3D4".hexColor!, size: CGSize(width: 12, height: 12), insets: UIEdgeInsets.zero, orientation: .up), for: .normal)
        sizeSlider.maximumButton.setImage(IconFontType.toolSize.image(background: UIColor.clear, tint: "#D2D3D4".hexColor!, size: CGSize(width: 16, height: 16), insets: UIEdgeInsets.zero, orientation: .up), for: .normal)
        sizeSlider.configValue(minimum: 16, maximum: screenWidth, value: 200)
        sizeSlider.addTarget(self, action: #selector(sizeSliderValueChanged(_:)), for: .valueChanged)
        sizeSlider.heightAnchor.constraint(equalToConstant: 32).isActive = true
        stack.addArrangedSubview(sizeSlider)
        
        let edgeSlider = IFSlider()
        edgeSlider.sliderDirection = .leftToRight
        edgeSlider.showMinimumValue = false
        edgeSlider.showMaximumValue = false
        edgeSlider.minimumButton.setImage(IconFontType.toolInsets.image(background: UIColor.clear, tint: "#D2D3D4".hexColor!, size: CGSize(width: 12, height: 12), insets: UIEdgeInsets.zero, orientation: .up), for: .normal)
        edgeSlider.maximumButton.setImage(IconFontType.toolInsets.image(background: UIColor.clear, tint: "#D2D3D4".hexColor!, size: CGSize(width: 16, height: 16), insets: UIEdgeInsets.zero, orientation: .up), for: .normal)
        edgeSlider.configValue(minimum: 0, maximum: screenWidth * 0.5, value: 0)
        edgeSlider.addTarget(self, action: #selector(edgeSliderValueChanged(_:)), for: .valueChanged)
        edgeSlider.heightAnchor.constraint(equalToConstant: 32).isActive = true
        stack.addArrangedSubview(edgeSlider)
        
        return stack
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
        updateIcon()
        
        view.addSubview(sliderStack)
        sliderStack.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
            make.bottom.equalTo(toolBar.snp.top).offset(-8)
        }
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
        DispatchQueue.global().async {
            let image = self.icon(backgrounds: [self.bgColor], locations: [1.0], start: CGPoint.zero, end: CGPoint.zero, tint: self.tintColor, size: self.imageSize, insets: self.insets, orientation: self.orientation)
            DispatchQueue.main.async {
                self.contentIconView.iconImage = image
            }
        }
    }
    
    fileprivate func icon(backgrounds: [UIColor], locations: [NSNumber], start: CGPoint, end: CGPoint, tint: UIColor, size: CGSize, insets: UIEdgeInsets, orientation: UIImage.Orientation) -> UIImage {
        return item.image(backgrounds: backgrounds, locations: locations, start: start, end: end, tint: tint, size: size, insets: insets, orientation: orientation)
    }
    
    fileprivate func dismissSelf() {
        dismiss(animated: true, completion: nil)
    }
}

extension IFEditDetailViewController {
    @objc func sizeSliderValueChanged(_ sender: IFSlider) {
        imageSize = CGSize(width: sender.value, height: sender.value)
        updateIcon()
    }
    
    @objc func edgeSliderValueChanged(_ sender: IFSlider) {
        let offset = sender.value
        insets = UIEdgeInsets(top: offset, left: offset, bottom: offset, right: offset)
        updateIcon()
    }
}
