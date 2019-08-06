//
//  UIButton+Indicator.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/8/6.
//

import Foundation

extension UIButton{
    
    fileprivate struct FZUIButtonIndicatorAssociatedKey{
        static var indicatorViewKeys: UnsafeRawPointer = UnsafeRawPointer(bitPattern: "FZUIButtonIndicatorAssociatedKey_indicatorViewKeys".hashValue)!
        static var buttonTextObject: UnsafeRawPointer = UnsafeRawPointer(bitPattern: "FZUIButtonIndicatorAssociatedKey_buttonTextObject".hashValue)!
    }
    
}

extension UIButton{
    
    
    /// 展示indicator
    ///
    /// - Parameter style: indicator style
    public func fz_showIndicator(style: UIActivityIndicatorView.Style = .white){
        var indicator: UIActivityIndicatorView? = nil
        // indicator 复用
        if let _indicator = objc_getAssociatedObject(self, FZUIButtonIndicatorAssociatedKey.indicatorViewKeys) as? UIActivityIndicatorView{
            indicator = _indicator
        }else{
            indicator = UIActivityIndicatorView()
        }
        indicator?.style = style
        indicator?.fz_outerCenter = self.fz_innerCenter
        
        // 避免多次调用fz_showIndicator导致title丢失
        let buttonText = objc_getAssociatedObject(self, FZUIButtonIndicatorAssociatedKey.buttonTextObject) as? String
        
        if let indicator = indicator{
            let text = buttonText ?? (self.currentTitle ?? "")
            setTitle("", for: .normal)
            
            objc_setAssociatedObject(self, FZUIButtonIndicatorAssociatedKey.indicatorViewKeys, indicator, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            objc_setAssociatedObject(self, FZUIButtonIndicatorAssociatedKey.buttonTextObject, text, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
            
            addSubview(indicator)
            bringSubviewToFront(indicator)
            indicator.startAnimating()
        }
    }
    
    
    /// 隐藏indicator
    public func fz_hideIndicator(){
        if let indicator = objc_getAssociatedObject(self, FZUIButtonIndicatorAssociatedKey.indicatorViewKeys) as? UIActivityIndicatorView{
            indicator.stopAnimating()
            indicator.removeFromSuperview()
            
            let text = objc_getAssociatedObject(self, FZUIButtonIndicatorAssociatedKey.buttonTextObject) as? String ?? ""
            setTitle(text, for: .normal)
        }
    }
}
