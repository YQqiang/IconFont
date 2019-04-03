//
//  IFEditToolViewController.swift
//  IconFont
//
//  Created by sungrow on 2019/4/3.
//  Copyright © 2019 yuqiang. All rights reserved.
//

import UIKit

class IFEditToolViewController: IFBaseViewController {

    init(sourceView: UIView) {
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .popover
        let popover = popoverPresentationController
        popover?.delegate = self
        popover?.sourceView = sourceView
        popover?.sourceRect = CGRect(x: sourceView.bounds.width * 0.5, y: 0, width: 0, height: 0)
        popover?.backgroundColor = UIColor.IFAlertBg
        popover?.permittedArrowDirections = .down
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.IFAlertBg
    }
}

extension IFEditToolViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
