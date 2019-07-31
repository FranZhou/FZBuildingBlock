//
//  FZTableViewCellModel.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/7/31.
//

import Foundation

public struct FZTableViewCellModel {
    
    // MARK: - cell背景色
    /// 背景色， 默认 nil
    var backgroundColor: UIColor?
    
    // MARK: - 顶部分割线
    /// topLine height
    var topLineHeight: CGFloat = 0.0
    /// topLine left distance
    var topLineLeftDistance: CGFloat = 0.0
    /// topLine right distance
    var topLineRightDistance: CGFloat = 0.0
    /// topLine topLine背景色
    var topLineBackgroundColor: UIColor?
    /// 控制topLine是否展示
    var showTopLine = false
    
    // MARK: - 底部分割线
    /// bottomLine height
    var bottomLineHeight: CGFloat = 0.0
    /// bottomLine left distance
    var bottomLineLeftDistance: CGFloat = 0.0
    /// bottomLine right distance
    var bottomLineRightDistance: CGFloat = 0.0
    /// bottomLine背景色 默认
    var bottomLineBackgroundColor: UIColor?
    /// 控制bottomLine是否展示
    var showBottomLine = false
    
    // MARK: - 左边icon
    /// left distance 默认16.0
    var leftDistance: CGFloat = 16.0
    /// left icon 默认 nil
    var leftIconImage: UIImage?
    /// left icon size, 默认{0. 0}, 为默认值时会使用leftIconImage的自有size
    var leftIconImageSize: CGSize = .zero
    /// 控制左边边小图标显示，默认NO
    var showLeftIcon = false
    
    // MARK: - left
    /// 距离左侧icon的距离 默认 5.0， 在showLeftIcon = true 时生效
    var leftIconDistance: CGFloat = 5.0
    // 展示内容三选一 优先级 leftView > leftAttributedString > leftString
    var leftString: String?
    var leftAttributedString: NSAttributedString?
    var leftView: UIView?
    
    // MARK: - center
    /// center left right min distance 默认 5.0,使用自定义视图时无效
    var centerMinDistance: CGFloat = 5.0
    // 展示内容三选一 优先级 centerView > centerAttributedString > centerString
    var centerString: String?
    var centerAttributedString: NSAttributedString?
    var centerView: UIView?
    
    // MARK: - right
    /// 距离右侧icon的距离 默认 5.0， 在showRightIcon = true时候生效
    var rightIconDistance: CGFloat = 5.0
    // 展示内容三选一 优先级 rightView > rightAttributedString > rightString
    var rightString: String?
    var rightAttributedString: NSAttributedString?
    var rightView: UIView?
    
    // MARK: - 右边icon
    /// right distance 默认 16.0
    var rightDistance: CGFloat = 16.0
    /// right icon
    var rightIconImage: UIImage?
    /// right icon size, 默认{0. 0}, 为默认值时会使用rightIconImage的自有size
    var rightIconImageSize: CGSize = .zero
    /// 控制右边小图标显示，默认NO
    var showRightIcon = false
    
}
