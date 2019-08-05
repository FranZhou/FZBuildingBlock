//
//  FZTableViewCellModel.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/7/31.
//

import Foundation

open class FZTableViewCellModel {
    
    public init() {
        
    }
    
    // MARK: - cell背景色
    /// 背景色， 默认 nil
    open var backgroundColor: UIColor?
    
    // MARK: - 顶部分割线
    /// topLine height
    open var topLineHeight: CGFloat = 0.0
    /// topLine left distance
    open var topLineLeftDistance: CGFloat = 0.0
    /// topLine right distance
    open var topLineRightDistance: CGFloat = 0.0
    /// topLine topLine背景色
    open var topLineBackgroundColor: UIColor?
    /// 控制topLine是否展示
    open var showTopLine = false
    
    // MARK: - 底部分割线
    /// bottomLine height
    open var bottomLineHeight: CGFloat = 0.0
    /// bottomLine left distance
    open var bottomLineLeftDistance: CGFloat = 0.0
    /// bottomLine right distance
    open var bottomLineRightDistance: CGFloat = 0.0
    /// bottomLine背景色 默认
    open var bottomLineBackgroundColor: UIColor?
    /// 控制bottomLine是否展示
    open var showBottomLine = false
    
    // MARK: - 左边icon
    /// left distance 默认16.0
    open var leftDistance: CGFloat = 16.0
    /// left icon 默认 nil
    open var leftIconImage: UIImage?
    /// left icon size, 默认{0. 0}, 为默认值时会使用leftIconImage的自有size
    open var leftIconImageSize: CGSize = .zero
    /// 控制左边边小图标显示，默认NO
    open var showLeftIcon = false
    
    // MARK: - left
    /// 距离左侧icon的距离 默认 5.0， 在showLeftIcon = true 时生效
    open var leftIconDistance: CGFloat = 5.0
    // 展示内容三选一 优先级 leftView > leftAttributedString > leftString
    open var leftString: String?
    open var leftAttributedString: NSAttributedString?
    open var leftView: UIView?
    
    // MARK: - center
    /// center left right min distance 默认 5.0,使用自定义视图时无效
    open var centerMinDistance: CGFloat = 5.0
    // 展示内容三选一 优先级 centerView > centerAttributedString > centerString
    open var centerString: String?
    open var centerAttributedString: NSAttributedString?
    open var centerView: UIView?
    
    // MARK: - right
    /// 距离右侧icon的距离 默认 5.0， 在showRightIcon = true时候生效
    open var rightIconDistance: CGFloat = 5.0
    // 展示内容三选一 优先级 rightView > rightAttributedString > rightString
    open var rightString: String?
    open var rightAttributedString: NSAttributedString?
    open var rightView: UIView?
    
    // MARK: - 右边icon
    /// right distance 默认 16.0
    open var rightDistance: CGFloat = 16.0
    /// right icon
    open var rightIconImage: UIImage?
    /// right icon size, 默认{0. 0}, 为默认值时会使用rightIconImage的自有size
    open var rightIconImageSize: CGSize = .zero
    /// 控制右边小图标显示，默认NO
    open var showRightIcon = false
    
}
