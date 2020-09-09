//
//  FZThemeManager+ThemeLoad.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2020/9/8.
//

import Foundation

/// 主题加载
extension FZThemeManager {

    /// 绑定主题加载器
    /// - Parameter loader: block retuen  (Bool, FZThemeProtocol?) = (是否被缓存， 主题机具体实现)
    public func themeLoader(_ loader: @escaping (FZThemeStyle) -> (Bool, FZThemeMachineProtocol?)?) {
        self.themeLoader = loader
    }

}
