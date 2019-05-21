//
//  IFColorController.swift
//  IconFont
//
//  Created by sungrow on 2019/5/21.
//  Copyright © 2019 yuqiang. All rights reserved.
//

import UIKit

class IFColorController: IFBaseViewController {
    
    public var colorDidChanged: ((_ color: UIColor) -> Void)?
    
    public private(set) lazy var colorPanel: ColorCircle = {
        let panel = ColorCircle(frame: CGRect.zero)
        panel.addTarget(self, action: #selector(changeColor), for: .valueChanged)
        return panel
    }()
    
    init(sourceView: UIView) {
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .popover
        preferredContentSize = CGSize(width: 200, height: 200)
        let popover = popoverPresentationController
        popover?.delegate = self
        popover?.sourceView = sourceView
        popover?.sourceRect = CGRect(x: sourceView.bounds.width * 0.5, y: 0, width: 0, height: 0)
        popover?.backgroundColor = "#6E6E6E".hexColor
        popover?.permittedArrowDirections = .down
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = "#6E6E6E".hexColor
        view.addSubview(colorPanel)
        colorPanel.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(16)
            make.right.bottom.equalToSuperview().offset(-16)
        }
    }
}

extension IFColorController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    @objc fileprivate func changeColor() {
        if let colsure = colorDidChanged {
            colsure(colorPanel.color)
        }
    }
}
