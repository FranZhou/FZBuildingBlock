//
//  UIView+Shadow.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/2/21.
//

import Foundation

extension FZBuildingBlockWrapper where Base: UIView {

    /// 传统方式给view添加阴影
    /// 必须 masksToBounds = fasle 才生效，该设置要在外部控制，masksToBounds默认false
    ///
    /// - Parameters:
    ///   - shadowColor: default = .black,阴影颜色
    ///   - shadowOffset: default = {0, -3}, 阴影偏移量,width向右偏移，height向下偏移
    ///   - shadowRadius: default = 3, 阴影半径
    ///   - shadowOpacity: default = 0, 阴影透明度
    ///   - shadowPath: default = nil, 阴影路径。如果不指定路径，就会使用layer层的alpha通道的混合，而如果指定阴影路径，就会在多个layer层之间共享同一路径，以此来提高性能。
    public func addShadow(shadowColor: UIColor = .black, shadowOffset: CGSize = CGSize(width: 0, height: -3), shadowRadius: CGFloat = 3, shadowOpacity: CGFloat = 0, shadowPath: CGPath? = nil) {
        base.layer.shadowColor = shadowColor.cgColor
        base.layer.shadowOffset = shadowOffset
        base.layer.shadowRadius = shadowRadius
        base.layer.shadowOpacity = Float(shadowOpacity)
        base.layer.shadowPath = shadowPath
    }

    /// 移除阴影
    public func removeShadow() {
        base.layer.shadowOpacity = 0
        base.layer.shadowPath = nil
    }

}
