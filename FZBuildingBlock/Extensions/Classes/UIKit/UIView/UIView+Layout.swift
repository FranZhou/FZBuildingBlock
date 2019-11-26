//
//  UIView+Layout.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/8/27.
//

import Foundation

extension FZBuildingBlockWrapper where Base: UIView {

    /// 使用固有尺寸进行布局，不会被拉伸或者压缩
    public func useIntrinsicContentSize() {

        base.setContentCompressionResistancePriority(.required, for: .horizontal)
        base.setContentCompressionResistancePriority(.required, for: .vertical)

        base.setContentHuggingPriority(UILayoutPriority.required, for: .horizontal)
        base.setContentHuggingPriority(UILayoutPriority.required, for: .vertical)
    }

}
