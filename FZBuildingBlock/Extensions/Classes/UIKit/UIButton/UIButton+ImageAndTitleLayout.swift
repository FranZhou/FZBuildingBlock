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

    /// 计算button图文布局Size
    ///
    /// - Parameters:
    ///   - size: fitSize
    ///   - layoutStyle: default = .imageLeftAndTitleRight；布局方式
    ///   - spacing: default = 0；文字和图片的间距
    /// - Returns: sizeThatFits
    public func sizeThatFits(size: CGSize, layoutStyle: FZButtonImageAndTitleLayoutStyle = .imageLeftAndTitleRight, spacing: CGFloat = 0) -> CGSize {
        var fitSize = size

        let imageWidth = base.imageView?.frame.size.width ?? 0
        let imageHeight = base.imageView?.frame.size.height ?? 0

        switch layoutStyle {
        case .imageLeftAndTitleRight, .imageRightAndTitleLeft:
            if let labelSize = base.titleLabel?.sizeThatFits(CGSize(width: size.width - imageWidth - spacing, height: size.height)) {
                fitSize.width = imageWidth + spacing + labelSize.width
                fitSize.height = max(imageHeight, labelSize.height)
            } else {
                fitSize.width = imageWidth
                fitSize.height = imageHeight
            }
        case .imageTopAndTitleBottom, .imageBottomAndTitleTop:
            if let labelSize = base.titleLabel?.sizeThatFits(size) {
                fitSize.width = max(imageWidth, labelSize.width)
                fitSize.height = imageHeight + spacing + labelSize.height
            } else {
                fitSize.width = imageWidth
                fitSize.height = imageHeight
            }
        }

        fitSize.width += base.contentEdgeInsets.left + base.contentEdgeInsets.right
        fitSize.height += base.contentEdgeInsets.top + base.contentEdgeInsets.bottom

        return fitSize
    }

    /// 修改按钮图片和文字布局方式。
    /// 使用注意：先设置好图片和文字，然后计算sizeThatFits，最后设置相应布局
    ///
    /// - Parameters:
    ///   - layoutStyle: default = .imageLeftAndTitleRight；布局方式
    ///   - spacing: default = 0；文字和图片的间距
    public func setImageAndTitleLayout(layoutStyle: FZButtonImageAndTitleLayoutStyle = .imageLeftAndTitleRight, spacing: CGFloat = 0) {

        let imageWidth = base.imageView?.frame.size.width ?? 0
        let imageHeight = base.imageView?.frame.size.height ?? 0

        let titleWidth = base.titleLabel?.frame.size.width ?? 0
        let titleHeight = base.titleLabel?.frame.size.height ?? 0

        var imageEdgeInsets: UIEdgeInsets = UIEdgeInsets()
        var titleEdgeInsets: UIEdgeInsets = UIEdgeInsets()

        switch layoutStyle {
        case .imageLeftAndTitleRight:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: spacing/2.0)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing/2.0, bottom: 0, right: 0)
        case .imageTopAndTitleBottom:
            imageEdgeInsets = UIEdgeInsets(top: -titleHeight-spacing/2.0, left: (base.frame.size.width-base.contentEdgeInsets.left-base.contentEdgeInsets.right)/2.0-imageWidth/2.0, bottom: 0, right: 0)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth, bottom: -imageHeight-spacing/2.0, right: 0)
        case .imageRightAndTitleLeft:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: titleWidth+spacing/2.0, bottom: 0, right: -titleWidth-spacing/2.0)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth-spacing/2.0, bottom: 0, right: imageWidth+spacing/2.0)
        case .imageBottomAndTitleTop:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: (base.frame.size.width-base.contentEdgeInsets.left-base.contentEdgeInsets.right)/2.0-imageWidth/2.0, bottom: -titleHeight-spacing/2.0, right: 0)
            titleEdgeInsets = UIEdgeInsets(top: -imageHeight-spacing/2.0, left: -imageWidth, bottom: 0, right: 0)
        }

        base.titleEdgeInsets = titleEdgeInsets
        base.imageEdgeInsets = imageEdgeInsets

    }

}
