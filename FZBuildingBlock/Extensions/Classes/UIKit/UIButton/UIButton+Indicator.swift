//
//  UIButton+Indicator.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/8/6.
//

import Foundation

private struct FZUIButtonIndicatorAssociatedKey {
    static var indicatorViewKeys: UnsafeRawPointer = UnsafeRawPointer(bitPattern: "FZUIButtonIndicatorAssociatedKey_indicatorViewKeys".hashValue)!
    static var buttonTextObject: UnsafeRawPointer = UnsafeRawPointer(bitPattern: "FZUIButtonIndicatorAssociatedKey_buttonTextObject".hashValue)!
}

extension FZBuildingBlockWrapper where Base: UIButton {

    /// 展示indicator
    ///
    /// - Parameter style: indicator style
    public func showIndicator(style: UIActivityIndicatorView.Style = .white) {
        var indicator: UIActivityIndicatorView?
        // indicator 复用
        if let _indicator = objc_getAssociatedObject(base, FZUIButtonIndicatorAssociatedKey.indicatorViewKeys) as? UIActivityIndicatorView {
            indicator = _indicator
        } else {
            indicator = UIActivityIndicatorView()
        }
        indicator?.style = style
        indicator?.fz.outerCenter = innerCenter

        // 避免多次调用showIndicator导致title丢失
        let buttonText = objc_getAssociatedObject(base, FZUIButtonIndicatorAssociatedKey.buttonTextObject) as? String

        if let indicator = indicator {
            let text = buttonText ?? (base.currentTitle ?? "")
            base.setTitle("", for: .normal)

            objc_setAssociatedObject(base, FZUIButtonIndicatorAssociatedKey.indicatorViewKeys, indicator, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            objc_setAssociatedObject(base, FZUIButtonIndicatorAssociatedKey.buttonTextObject, text, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)

            base.addSubview(indicator)
            base.bringSubviewToFront(indicator)
            indicator.startAnimating()
        }
    }

    /// 隐藏indicator
    public func hideIndicator() {
        if let indicator = objc_getAssociatedObject(base, FZUIButtonIndicatorAssociatedKey.indicatorViewKeys) as? UIActivityIndicatorView {
            indicator.stopAnimating()
            indicator.removeFromSuperview()

            let text = objc_getAssociatedObject(base, FZUIButtonIndicatorAssociatedKey.buttonTextObject) as? String ?? ""
            base.setTitle(text, for: .normal)
        }
    }
}
