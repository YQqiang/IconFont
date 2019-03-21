//
//  IFOverviewDetailController.swift
//  IconFont
//
//  Created by sungrow on 2019/3/21.
//  Copyright © 2019 yuqiang. All rights reserved.
//

import UIKit

class IFOverviewDetailController: IFBaseViewController {
    
    private let radius: CGFloat = 22
    
    public var item: IFItem? {
        didSet {
            guard let obj = item else {
                return
            }
            let image = self.item?.image(background: UIColor.clear, tint: UIColor.white, size: CGSize(width: 24, height: 24), insets: UIEdgeInsets.zero, orientation: .up)
            titleView.iconImgV.image = image
            titleView.nameLbl.text = obj.name + String(unicodeScalarLiteral: obj.unicode)
            let s = obj.unicode.unicodeScalars
            for c in obj.unicode.characters {
                print(c)
            }
            print("---\(s)")
        }
    }
    
    override var modalPresentationStyle: UIModalPresentationStyle {
        get { return .custom }
        set {}
    }
    
    override var transitioningDelegate: UIViewControllerTransitioningDelegate? {
        get { return IFSlowlyShowTransition() }
        set {}
    }
    
    fileprivate lazy var contentView: IFRoundShadowView = {
        let v = IFRoundShadowView()
        v.contentView.backgroundColor = UIColor.clear
        v.cornerRadius = radius
        v.fillColor = UIColor.IFAlertBg
        return v
    }()
    
    fileprivate lazy var titleView: IFOverviewDetailTitleView = {
        let v = IFOverviewDetailTitleView()
        v.roundRadius = radius
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.clear
        view.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.height.equalTo(200)
        }
        
        contentView.contentView.addSubview(titleView)
        titleView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
//            make.height.equalTo(64)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismissSelf()
    }
    
    fileprivate func dismissSelf() {
        dismiss(animated: true, completion: nil)
    }

}
