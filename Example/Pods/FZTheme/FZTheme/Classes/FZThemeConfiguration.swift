//
//  FZThemeConfiguration.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2020/9/9.
//

import Foundation

public struct FZThemeConfiguration {

    /// 跟随系统主题变化，default = false, 启用时会影响到currentThemeStyle
    public static var isFlowSystemThemeStyle: Bool = false

    /// 默认主题，default = FZThemeStyle.light，修改默认主题后，会调用 switchCurrentTheme 改变当前主题
    public static var defaultThemeStyle: FZThemeStyle = .light {
        didSet {
            FZThemeManager.manager.switchCurrentTheme(to: defaultThemeStyle)
        }
    }

    /// 主题发生改变
    public static var themeStyleUpdate: ((FZThemeStyle) -> Void)?

}
