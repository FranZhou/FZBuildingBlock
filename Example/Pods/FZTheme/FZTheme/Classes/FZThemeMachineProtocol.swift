//
//  FZThemeMachineProtocol.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2020/9/8.
//

import Foundation

/// 主题机，管理主题实现
public protocol FZThemeMachineProtocol {

    var themeStyle: FZThemeStyle { get }

    func themeColor(withIdentifier identifier: String, themeStyle: FZThemeStyle, defaultColor: UIColor?) -> UIColor?

    func themeImage(withIdentifier identifier: String, themeStyle: FZThemeStyle, defaultImage: UIImage?) -> UIImage?

}

extension FZThemeMachineProtocol {

    public func themeColor(withIdentifier identifier: String, themeStyle: FZThemeStyle, defaultColor: UIColor? = nil) -> UIColor? {
        return defaultColor
    }

    public func themeImage(withIdentifier identifier: String, themeStyle: FZThemeStyle, defaultImage: UIImage? = nil) -> UIImage? {
        return defaultImage
    }

}
