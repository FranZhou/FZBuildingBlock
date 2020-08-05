//
//  FZTableViewCellModel.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/7/31.
//

import Foundation

@objc
open class FZTableViewCellModel: NSObject {

    /// model功能标识字段，默认为nil
    /// 当你需要根据model判断当前处理什么业务时，可以设置modelIdentifier，然后根据modelIdentifier来判断
    @objc open var modelIdentifier: String?

    // MARK: - cell背景色
    /// 背景色， 默认 nil
    @objc open var backgroundColor: UIColor?

    // MARK: - 顶部分割线
    /// topLine height
    @objc open var topLineHeight: CGFloat = 0.0
    /// topLine left distance
    @objc open var topLineLeftDistance: CGFloat = 0.0
    /// topLine right distance
    @objc open var topLineRightDistance: CGFloat = 0.0
    /// topLine topLine背景色
    @objc open var topLineBackgroundColor: UIColor?
    /// 控制topLine是否展示
    @objc open var showTopLine = false

    // MARK: - 底部分割线
    /// bottomLine height
    @objc open var bottomLineHeight: CGFloat = 0.0
    /// bottomLine left distance
    @objc open var bottomLineLeftDistance: CGFloat = 0.0
    /// bottomLine right distance
    @objc open var bottomLineRightDistance: CGFloat = 0.0
    /// bottomLine背景色 默认
    @objc open var bottomLineBackgroundColor: UIColor?
    /// 控制bottomLine是否展示
    @objc open var showBottomLine = false

    // MARK: - 左边icon
    /// left distance 默认16.0
    @objc open var leftDistance: CGFloat = 16.0
    /// left icon 默认 nil
    @objc open var leftIconImage: UIImage?
    /// left icon size, 默认{0. 0}, 为默认值时会使用leftIconImage的自有size
    @objc open var leftIconImageSize: CGSize = .zero
    /// 控制左边边小图标显示，默认NO
    @objc open var showLeftIcon = false

    // MARK: - left
    /// 距离左侧icon的距离 默认 5.0， 在showLeftIcon = true 时生效
    @objc open var leftIconDistance: CGFloat = 5.0
    // 展示内容三选一 优先级 leftView > leftAttributedString > leftString
    @objc open var leftString: String?
    @objc open var leftAttributedString: NSAttributedString?
    @objc open var leftView: UIView?

    // MARK: - center
    /// center left right min distance 默认 5.0,使用自定义视图时无效
    @objc open var centerMinDistance: CGFloat = 5.0
    // 展示内容三选一 优先级 centerView > centerAttributedString > centerString
    @objc open var centerString: String?
    @objc open var centerAttributedString: NSAttributedString?
    @objc open var centerView: UIView?

    // MARK: - right
    /// 距离右侧icon的距离 默认 5.0， 在showRightIcon = true时候生效
    @objc open var rightIconDistance: CGFloat = 5.0
    // 展示内容三选一 优先级 rightView > rightAttributedString > rightString
    @objc open var rightString: String?
    @objc open var rightAttributedString: NSAttributedString?
    @objc open var rightView: UIView?

    // MARK: - 右边icon
    /// right distance 默认 16.0
    @objc open var rightDistance: CGFloat = 16.0
    /// right icon
    @objc open var rightIconImage: UIImage?
    /// right icon size, 默认{0. 0}, 为默认值时会使用rightIconImage的自有size
    @objc open var rightIconImageSize: CGSize = .zero
    /// 控制右边小图标显示，默认NO
    @objc open var showRightIcon = false

}
