//
//  FZThemeManager+UIBind.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2020/9/8.
//

import Foundation

/// UI绑定
extension FZThemeManager {

    /// 绑定主题变化值监听的block
    /// - Parameters:
    ///   - block: 主题变化时执行的block
    ///   - target: 关联对象
    public func bind(target: NSObject, withThemeBlock block: @escaping (FZThemeStyle, FZThemeMachineProtocol?) -> Void) {
        themeBlockManagerQueue.async(flags: .barrier) { [weak self, weak target] in
            guard let `self` = self
                else {
                    return
            }

            var blockArray: NSMutableArray! = self.themeBlockManager.object(forKey: target)
            if blockArray == nil {
                blockArray = NSMutableArray()
                self.themeBlockManager.setObject(blockArray, forKey: target)
            }

            let themeBlock = FZThemeBlock(target: target, themeBlock: block)
            self.fireThemeBlock(themeBlock, style: self.currentThemeStyle, themeMachine: self.getCurrentThemeMachine())

            blockArray.add(themeBlock)
        }
    }

}
