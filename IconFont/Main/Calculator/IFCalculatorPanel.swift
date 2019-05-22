//
//  IFCalculatorPanel.swift
//  IconFont
//
//  Created by sungrow on 2019/4/3.
//  Copyright © 2019 yuqiang. All rights reserved.
//

import UIKit

private let spacing: CGFloat = 2.0 / UIScreen.main.scale

final class IFCalculatorPanel: IFBaseView {
    
    public var enterColsure: ((_ value: String) -> Void)?
    
    public enum CalculatorType {
        /// 十六进制
        case hexadecimal
        /// 十进制
        case decimal
    }
    
    public var canConvert: Bool = true {
        didSet {
            fTran.isHidden = !canConvert
        }
    }
    
    public var calculatorType: CalculatorType = .hexadecimal {
        didSet {
            if calculatorType == .hexadecimal {
                da.superview?.isHidden = false
                dd.superview?.isHidden = false
                dp.isHidden = true
                guard let decimal = Int(resultView.resultView.text ?? "") else {
                    resultView.resultView.text = ""
                    return
                }
                resultView.resultView.text = String(format: "%x", decimal).uppercased()
                resultView.selectAllText()
            } else if calculatorType == .decimal {
                da.superview?.isHidden = true
                dd.superview?.isHidden = true
                dp.isHidden = false
                guard let hex = Int(resultView.resultView.text ?? "", radix: 16) else {
                    resultView.resultView.text = ""
                    return
                }
                resultView.resultView.text = String(format: "%d", hex)
                resultView.selectAllText()
            }
        }
    }
    
    fileprivate lazy var resultView: IFCalculatorResult = {
        let v = IFCalculatorResult()
        return v
    }()
    
    fileprivate lazy var operationStack: UIStackView = {
        let stack = UIStackView()
        stack.spacing = spacing
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.alignment = .fill
        return stack
    }()
    
    fileprivate lazy var digitalStack: UIStackView = {
        let stack = UIStackView()
        stack.spacing = spacing
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .fill
        return stack
    }()
    
    fileprivate lazy var functionStack: UIStackView = {
        let stack = UIStackView()
        stack.spacing = spacing
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .fill
        
        stack.addArrangedSubview(self.fTran)
        stack.addArrangedSubview(self.fDele)
        stack.addArrangedSubview(self.fEnt)
        return stack
    }()
    
    fileprivate lazy var allSenders: [IFCalculatorItem] = []
    
    public private(set) lazy var dp = makeItem(title: decimalPoint)
    public private(set) lazy var d0 = makeItem(title: "0")
    public private(set) lazy var d1 = makeItem(title: "1")
    public private(set) lazy var d2 = makeItem(title: "2")
    public private(set) lazy var d3 = makeItem(title: "3")
    public private(set) lazy var d4 = makeItem(title: "4")
    public private(set) lazy var d5 = makeItem(title: "5")
    public private(set) lazy var d6 = makeItem(title: "6")
    public private(set) lazy var d7 = makeItem(title: "7")
    public private(set) lazy var d8 = makeItem(title: "8")
    public private(set) lazy var d9 = makeItem(title: "9")
    public private(set) lazy var da = makeItem(title: "A")
    public private(set) lazy var db = makeItem(title: "B")
    public private(set) lazy var dc = makeItem(title: "C")
    public private(set) lazy var dd = makeItem(title: "D")
    public private(set) lazy var de = makeItem(title: "E")
    public private(set) lazy var df = makeItem(title: "F")
    
    public private(set) lazy var fTran = makeItem(title: "◎")
    public private(set) lazy var fDele = makeItem(title: "←")
    public private(set) lazy var fEnt = makeItem(title: "↩︎")
    
    fileprivate var decimalPoint: String {
        return "."
    }

    init(type: CalculatorType) {
        self.calculatorType = type
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.calculatorType = .hexadecimal
        super.init(coder: aDecoder)
    }
    
    override func createViews() {
        super.createViews()
        
        let cornerRadius: CGFloat = 12
        
        autoAnimate = false
        contentView.backgroundColor = "#575757".hexColor
        contentView.addSubview(UIVisualEffectView(effect: UIBlurEffect(style: .dark)))
        contentView.layer.cornerRadius = cornerRadius
        contentView.layer.masksToBounds = true
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 4
        layer.shadowOpacity = 0.3
        
        d0.roundCorner = .bottomLeft
        d0.roundRadius = cornerRadius
        
        fEnt.roundCorner = .bottomRight
        fEnt.roundRadius = cornerRadius
        
        contentView.addSubview(resultView)
        resultView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
        }
        
        contentView.addSubview(operationStack)
        operationStack.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(resultView.snp.bottom)
        }
        
        operationStack.addArrangedSubview(digitalStack)
        operationStack.addArrangedSubview(functionStack)
        digitalStack.widthAnchor.constraint(equalTo: functionStack.widthAnchor, multiplier: 3, constant: 0).isActive = true
        
        var rowStack = UIStackView()
        rowStack.spacing = spacing
        rowStack.axis = .horizontal
        rowStack.distribution = .fillEqually
        rowStack.alignment = .fill
        rowStack.addArrangedSubview(dd)
        rowStack.addArrangedSubview(de)
        rowStack.addArrangedSubview(df)
        digitalStack.addArrangedSubview(rowStack)
        
        rowStack = UIStackView()
        rowStack.spacing = spacing
        rowStack.axis = .horizontal
        rowStack.distribution = .fillEqually
        rowStack.alignment = .fill
        rowStack.addArrangedSubview(da)
        rowStack.addArrangedSubview(db)
        rowStack.addArrangedSubview(dc)
        digitalStack.addArrangedSubview(rowStack)
        
        rowStack = UIStackView()
        rowStack.spacing = spacing
        rowStack.axis = .horizontal
        rowStack.distribution = .fillEqually
        rowStack.alignment = .fill
        rowStack.addArrangedSubview(d7)
        rowStack.addArrangedSubview(d8)
        rowStack.addArrangedSubview(d9)
        digitalStack.addArrangedSubview(rowStack)
        
        rowStack = UIStackView()
        rowStack.spacing = spacing
        rowStack.axis = .horizontal
        rowStack.distribution = .fillEqually
        rowStack.alignment = .fill
        rowStack.addArrangedSubview(d4)
        rowStack.addArrangedSubview(d5)
        rowStack.addArrangedSubview(d6)
        digitalStack.addArrangedSubview(rowStack)
        
        rowStack = UIStackView()
        rowStack.spacing = spacing
        rowStack.axis = .horizontal
        rowStack.distribution = .fillEqually
        rowStack.alignment = .fill
        rowStack.addArrangedSubview(d1)
        rowStack.addArrangedSubview(d2)
        rowStack.addArrangedSubview(d3)
        digitalStack.addArrangedSubview(rowStack)
        
        rowStack = UIStackView()
        rowStack.spacing = spacing
        rowStack.axis = .horizontal
        rowStack.distribution = .fillProportionally
        rowStack.alignment = .fill
        rowStack.addArrangedSubview(d0)
        rowStack.addArrangedSubview(dp)
        d0.widthAnchor.constraint(equalTo: dp.widthAnchor, multiplier: 2, constant: rowStack.spacing).isActive = true
        digitalStack.addArrangedSubview(rowStack)
        
        calculatorType = { calculatorType }()
        canConvert = { canConvert }()
        resultView.resultView.becomeFirstResponder()
    }
    
    fileprivate func makeItem(title: String) -> IFCalculatorItem {
        let item = IFCalculatorItem()
        item.backgroundColor = "#6E6E6E".hexColor
        item.textColor = UIColor.white
        item.textAlignment = .center
        item.font = UIFont.boldSystemFont(ofSize: 18)
        item.text = title
        allSenders.append(item)
        return item
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if let touch = touches.first {
            let point = touch.location(in: self)
            allSenders.forEach { (sender) in
                let resultFrame = sender.superview!.convert(sender.frame, to: self)
                sender.animate(isHighlighted: resultFrame.contains(point))
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        if let touch = touches.first {
            let point = touch.location(in: self)
            allSenders.forEach { (sender) in
                let resultFrame = sender.superview!.convert(sender.frame, to: self)
                sender.animate(isHighlighted: resultFrame.contains(point))
            }
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        if let touch = touches.first {
            let point = touch.location(in: self)
            allSenders.forEach { (sender) in
                sender.animate(isHighlighted: false)
                if sender.isHidden {
                    return
                }
                let resultFrame = sender.superview!.convert(sender.frame, to: self)
                if resultFrame.contains(point) {
                    if sender == fTran {
                        convertAction()
                    } else if sender == fDele {
                        deleteAction()
                    } else if sender == fEnt {
                        enterAction()
                    } else if sender == dp {
                        pointAction()
                    } else {
                        resultView.resultView.text = String(format: "%@%@", resultView.resultView.text ?? "", sender.text ?? "")
                    }
                }
            }
        }
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        allSenders.forEach { (sender) in
            sender.animate(isHighlighted: false)
        }
    }
    
    fileprivate func deleteAction() {
        resultView.deleteBackward()
    }
    
    fileprivate func enterAction() {
        resultView.selectAllText()
        if let closure = enterColsure {
            closure(resultView.resultView.text ?? "")
        }
    }
    
    fileprivate func convertAction() {
        if calculatorType == .hexadecimal {
            calculatorType = .decimal
        } else if calculatorType == .decimal {
            calculatorType = .hexadecimal
        }
    }
    
    fileprivate func pointAction() {
        guard let text = resultView.resultView.text else {
            return
        }
        if text.count <= 0 {
            return
        }
        if text.contains(decimalPoint) {
            return
        }
        resultView.resultView.text = String(format: "%@%@", resultView.resultView.text ?? "", dp.text ?? "")
    }
}

class IFCalculatorItem: UILabel {
    
    private lazy var maskLayer: CAShapeLayer = {
        let ly = CAShapeLayer()
        return ly
    }()
    
    public var roundCorner: UIRectCorner = .allCorners {
        didSet {
            layoutIfNeeded()
        }
    }
    
    public var roundRadius: CGFloat = 0 {
        didSet {
            layoutIfNeeded()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        maskLayer.path = UIBezierPath(roundedRect: bounds, byRoundingCorners: roundCorner, cornerRadii: CGSize(width: roundRadius, height: roundRadius)).cgPath
        layer.mask = maskLayer
    }
}

class IFCalculatorResult: IFRoundShadowView {
    
    public private(set) lazy var resultView: UITextField = {
        let tf = UITextField()
        tf.textColor = UIColor.white
        tf.textAlignment = .right
        tf.inputView = UIView()
        tf.font = UIFont.boldSystemFont(ofSize: 18)
        tf.heightAnchor.constraint(equalToConstant: 32).isActive = true
        return tf
    }()
    
    override func createViews() {
        super.createViews()
        autoAnimate = false
        contentView.backgroundColor = "#646B71".hexColor
        contentView.addSubview(resultView)
        resultView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
            make.right.equalToSuperview().offset(-16)
        }
    }
    
    fileprivate func selectAllText() {
        resultView.selectAll(nil)
    }
    
    fileprivate func deleteBackward() {
        resultView.deleteBackward()
    }
}
