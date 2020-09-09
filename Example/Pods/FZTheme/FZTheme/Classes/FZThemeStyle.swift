//
//  FZThemeStyle.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2020/9/8.
//

import Foundation

public enum FZThemeStyle {
    case light
    case dark
    case custom(String)
}

extension FZThemeStyle {

    public var themeName: String {
        get {
            switch self {
            case .light:
                return "light"
            case .dark:
                return "dark"
            case .custom(let theme):
                return theme
            }
        }
    }

    public static func getStyle(withThemeName themeName: String) -> FZThemeStyle {
        if themeName == FZThemeStyle.light.themeName {
            return .light
        } else if themeName == FZThemeStyle.dark.themeName {
            return .dark
        } else {
            return .custom(themeName)
        }
    }

}

extension FZThemeStyle: Hashable {

    public var hashValue: Int {
        return self.themeName.hashValue
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.themeName)
    }

}
