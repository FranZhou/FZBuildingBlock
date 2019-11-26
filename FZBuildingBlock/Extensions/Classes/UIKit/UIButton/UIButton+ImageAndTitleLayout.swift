//
//  UIButton+TitleAndImageLayout.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/3/15.
//

import Foundation

/// button图片和文字位置
///
/// - imageLeftAndTitleRight: default，左图片，右文字
/// - imageTopAndTitleBottom: 上图片，下文字
/// - imageRightAndTitleLeft: 右图片，左文字
/// - imageBottomAndTitleTop: 下图片，上文字
public enum FZButtonImageAndTitleLayoutStyle: Int {
    case imageLeftAndTitleRight = 0
    case imageTopAndTitleBottom
    case imageRightAndTitleLeft
    case imageBottomAndTitleTop
}

extension FZBuildingBlockWrapper where Base: UIButton {

    /// 修改按钮图片和文字布局方式，要先设置好图片和文字后再调用此方法
    ///
    /// - Parameters:
    ///   - layoutStyle: default = .imageLeftAndTitleRight；布局方式
    ///   - spacing: default = 0；文字和图片的间距
    public func setImageAndTitleLayout(layoutStyle: FZButtonImageAndTitleLayoutStyle = .imageLeftAndTitleRight, spacing: CGFloat = 0) {

        base.layoutIfNeeded()

        let imageWidth = base.imageView?.frame.size.width ?? 0
        let imageHeight = base.imageView?.frame.size.height ?? 0

        let titleWidth = base.titleLabel?.frame.size.width ?? 0
        let titleHeight = base.titleLabel?.frame.size.height ?? 0

        let titleIntrinsicWidth = base.titleLabel?.intrinsicContentSize.width ?? 0

        var imageEdgeInsets: UIEdgeInsets = UIEdgeInsets()
        var labelEdgeInsets: UIEdgeInsets = UIEdgeInsets()

        switch layoutStyle {
        case .imageLeftAndTitleRight:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: -spacing/2.0, bottom: 0, right: spacing/2.0)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: spacing/2.0, bottom: 0, right: -spacing/2.0)
        case .imageTopAndTitleBottom:
            imageEdgeInsets = UIEdgeInsets(top: -titleHeight-spacing/2.0, left: 0, bottom: 0, right: -titleIntrinsicWidth)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth, bottom: -imageHeight-spacing/2.0, right: 0)
        case .imageRightAndTitleLeft:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: titleWidth+spacing/2.0, bottom: 0, right: -titleWidth-spacing/2.0)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth-spacing/2.0, bottom: 0, right: imageWidth+spacing/2.0)
        case .imageBottomAndTitleTop:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -titleHeight-spacing/2.0, right: -titleIntrinsicWidth)
            labelEdgeInsets = UIEdgeInsets(top: -imageHeight-spacing/2.0, left: -imageWidth, bottom: 0, right: 0)
        }

        base.titleEdgeInsets = labelEdgeInsets
        base.imageEdgeInsets = imageEdgeInsets

    }
}
