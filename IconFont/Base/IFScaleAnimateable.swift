//
//  IFScaleAnimateable.swift
//  IconFont
//
//  Created by sungrow on 2019/3/30.
//  Copyright © 2019 yuqiang. All rights reserved.
//

import UIKit

struct IFScaleComment {
    var factor: CGFloat = 0.8
    var disable: Bool = false
}

protocol HasIFScaleComment {
    var scaleComment: IFScaleComment { get set }
}

protocol IFScaleAnimateable: HasIFScaleComment {
    func animate(isHighlighted: Bool, completion: ((Bool) -> Void)?);
}

extension IFScaleAnimateable where Self: UIView {
    
    func animate(isHighlighted: Bool, completion: ((Bool) -> Void)? = nil) {
        if scaleComment.disable {
            return
        }
        let animationOptions: UIView.AnimationOptions = [.allowUserInteraction]
        if isHighlighted {
            UIView.animate(withDuration: 0.25,
                           delay: 0,
                           usingSpringWithDamping: 1,
                           initialSpringVelocity: 0,
                           options: animationOptions, animations: {
                            self.transform = .init(scaleX: self.scaleComment.factor, y: self.scaleComment.factor)
            }, completion: completion)
        } else {
            UIView.animate(withDuration: 0.25,
                           delay: 0,
                           usingSpringWithDamping: 1,
                           initialSpringVelocity: 0,
                           options: animationOptions, animations: {
                            self.transform = .identity
            }, completion: completion)
        }
    }
}

extension UIView: IFScaleAnimateable {
    
    private struct AssociatedKeys {
        static var scaleCommentKey = "UIView.IFScaleComment"
    }
    
    var scaleComment: IFScaleComment {
        get {
            guard let scaleCom = objc_getAssociatedObject(self, &AssociatedKeys.scaleCommentKey) as? IFScaleComment else {
                let comment = IFScaleComment()
                objc_setAssociatedObject(self, &AssociatedKeys.scaleCommentKey, comment, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return comment
            }
            return scaleCom
        }
        set (comment) {
            objc_setAssociatedObject(self, &AssociatedKeys.scaleCommentKey, comment, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

class IFButton: UIButton {
    
    public var autoAnimate: Bool = true
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        if autoAnimate {
            animate(isHighlighted: true)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        if autoAnimate {
            animate(isHighlighted: false)
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        if autoAnimate {
            animate(isHighlighted: false)
        }
    }
}
