//
//  UIView+UIViewController.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/9/19.
//

import Foundation

extension FZBuildingBlockWrapper where Base: UIView {

    /// Gets which attempt controller the view belongs to
    ///
    /// - Returns: view belongs to UIViewController
    public func belongToViewController() -> UIViewController? {

        /// UIView 类继承于 UIResponder，通过 UIResponder 的next 方法来获取 UIViewController
        /// 如果 next 返回是空，则继续向上遍历 superview 并再次使用 next 方法获取。这样一直找下去，直到找到或抛出异常
        for view in sequence(first: base, next: { $0.superview }) {
            var responder = view.next

            repeat {
                if responder is UIViewController {
                    return responder as? UIViewController
                } else {
                    responder = responder?.next
                }
            } while responder != nil
        }

        return nil
    }

}
