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
    
    public private(set) lazy var hexInput: UITextField = {
        let tf = UITextField()
        tf.textColor = UIColor.black
        tf.textAlignment = .center
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.borderStyle = .roundedRect
        let panel = IFCalculatorPanel(type: .hexadecimal)
        panel.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 260)
        panel.canConvert = false
        panel.isShowResultView = false
        panel.enterColsure = { [weak tf, weak panel, weak self] (value) -> Void in
            panel?.resultView.resultView.resignFirstResponder()
            tf?.resignFirstResponder()
            self?.dismiss(animated: true, completion: nil)
        }
        panel.deleteColsure = { [weak tf, weak self] in
            tf?.deleteBackward()
            guard let color = "#\(tf?.text ?? "")".hexColor else {
                return
            }
            self?.colorPanel.setColor(color, animated: true, sendEvent: false)
            if let colsure = self?.colorDidChanged {
                colsure(color)
            }
        }
        panel.touchesEndedColsure = { [weak tf, weak panel, weak self] (value) in
            tf?.text = "\(tf?.text ?? "")\(value)"
            guard let color = "#\(tf?.text ?? "")".hexColor else {
                return
            }
            self?.colorPanel.setColor(color, animated: true, sendEvent: false)
            if let colsure = self?.colorDidChanged {
                colsure(color)
            }
        }
        tf.inputView = panel
        tf.placeholder = "RGB/RGBA"
        return tf
    }()
    
    init(sourceView: UIView) {
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .popover
        preferredContentSize = CGSize(width: 180, height: 232)
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
            make.right.equalToSuperview().offset(-16)
        }
        
        view.addSubview(hexInput)
        hexInput.snp.makeConstraints { (make) in
            make.left.right.equalTo(colorPanel)
            make.top.equalTo(colorPanel.snp.bottom).offset(8)
            make.bottom.equalToSuperview().offset(-16)
        }
    }
}

extension IFColorController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    @objc fileprivate func changeColor() {
        hexInput.text = String(colorPanel.color.hexString?.dropFirst() ?? "")
        if let colsure = colorDidChanged {
            colsure(colorPanel.color)
        }
    }
}
