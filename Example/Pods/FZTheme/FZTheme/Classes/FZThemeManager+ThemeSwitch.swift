//
//  FZThemeManager+ThemeSwitch.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2020/9/8.
//

import Foundation

/// 切换主题
extension FZThemeManager {

    /// 切换当前主题（自定义主题）
    /// - Parameter style: 最新的主题
    public func switchCurrentTheme(to style: FZThemeStyle) {
        currentThemeStyle = style
    }

    /// 切换当前主题（系统注意）
    /// - Parameter style: 系统最新主题
    @available(iOS 12.0, *)
    public func switchCurrentSystemTheme(to style: UIUserInterfaceStyle) {
        if FZThemeConfiguration.isFlowSystemThemeStyle {
            let style = convertSystemThemeStyle(style)
            currentThemeStyle = style
        }
    }

    /// 系统主题转换
    /// - Parameter style: 系统主题
    /// - Returns: FZThemeStyle
    @available(iOS 12.0, *)
    public func convertSystemThemeStyle(_ style: UIUserInterfaceStyle) -> FZThemeStyle {
        switch style {
        case .unspecified, .light:
            return .light
        case .dark:
            return .dark
        default:
            return .light
        }
    }

}
