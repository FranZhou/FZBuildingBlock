//
//  FZThemeBlock.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2020/9/8.
//

import Foundation

internal class FZThemeBlock: NSObject {

    weak var target: NSObject?

    let themeBlock: (FZThemeStyle, FZThemeMachineProtocol?) -> Void

    init(target: NSObject?, themeBlock: @escaping (FZThemeStyle, FZThemeMachineProtocol?) -> Void) {
        self.target = target
        self.themeBlock = themeBlock
    }

}
