//
//  NSObject+Theme.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2020/9/8.
//

import Foundation

extension NSObject: FZThemeCompatible {

}

extension FZThemeWrapper where Base: NSObject {

    /// 设置主题外观，同一对象该方法可以多次添加
    /// - Parameter themeBlock: themeBlock
    /// - Returns: 链式函数，返回当前调用对象
    @discardableResult
    public func appearance(forTheme themeBlock: @escaping ((Base, FZThemeStyle, FZThemeMachineProtocol?) -> Void)) -> Base {

        FZThemeManager.manager.bind(target: base) { [weak base](style, themeMachine) in
            guard let base = base
                else {
                    return
            }
            themeBlock(base, style, themeMachine)
        }

        return base
    }

}
