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
            titleView.nameLbl.text = obj.name
            contentItems.item = obj
        }
    }
    
    override var modalPresentationStyle: UIModalPresentationStyle {
        get { return .custom }
        set {}
    }
    
    override var transitioningDelegate: UIViewControllerTransitioningDelegate? {
        get { return isPeek ? super.transitioningDelegate : IFSlowlyShowTransition() }
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
    
    fileprivate lazy var contentItems: IFOverviewDetailContentView = {
        let v = IFOverviewDetailContentView()
        v.roundRadius = radius
        return v
    }()
    
    private var isPeek: Bool = false
    
    init(isPeek: Bool) {
        super.init(nibName: nil, bundle: nil)
        self.isPeek = isPeek
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.clear
        view.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        contentView.contentView.addSubview(titleView)
        titleView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
        }
        
        contentView.contentView.addSubview(contentItems)
        contentItems.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(titleView.snp.bottom)
        }
    }
    
    override var previewActionItems: [UIPreviewActionItem] {
        guard let obj = item else {
            return []
        }
        let action1 = UIPreviewAction(title: "0x" + obj.hexString, style: .default) { (action, viewControlelr) in
            UIPasteboard.general.string = action.title
        }
        let action2 = UIPreviewAction(title: obj.name, style: .default) { (action, viewControlelr) in
            UIPasteboard.general.string = action.title
        }
        let action3 = UIPreviewAction(title: obj.fontName, style: .default) { (action, viewControlelr) in
            UIPasteboard.general.string = action.title
        }
        return [action1, action2, action3]
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismissSelf()
    }
    
    fileprivate func dismissSelf() {
        dismiss(animated: true, completion: nil)
    }

}
