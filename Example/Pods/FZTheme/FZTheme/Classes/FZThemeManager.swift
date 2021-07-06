//
//  FZThemeManager.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2020/9/8.
//

import Foundation
import UIKit

public class FZThemeManager: NSObject {

    public static let manager = FZThemeManager()

    // MARK: - Property

    /**
     * 当前主题，default = FZThemeConfiguration.defaultThemeStyle{。
     * 内部不会记录主题变化，需要外部进行记录。
     * app启动是可以调用 switchCurrentTheme or switchCurrentSystemTheme 进行设置
     */
    public internal(set) var currentThemeStyle: FZThemeStyle = FZThemeConfiguration.defaultThemeStyle {
        didSet {
            if oldValue.themeName != currentThemeStyle.themeName {
                fireAllThemeBlock()
            }
        }
    }

    /// 主题机缓存
    private lazy var themeMachineCache: Dictionary<FZThemeStyle, (Bool, FZThemeMachineProtocol?)> = {
        let dic = Dictionary<FZThemeStyle, (Bool, FZThemeMachineProtocol?)>()
        return dic
    }()

    /// 界面主题执行方法
    internal lazy var themeBlockManager: NSMapTable<NSObject, NSMutableArray> = {
        let mapTable =  NSMapTable<NSObject, NSMutableArray>.weakToStrongObjects()
        return mapTable
    }()

    /// 主题管理队列
    public var themeBlockManagerQueue = DispatchQueue(label: "com.fztheme.themeManagerQueue", attributes: DispatchQueue.Attributes.concurrent)

    /// 主题执行队列
    public var themeBlockFireQueue = DispatchQueue.main

    /// 主题加载器
    public var themeLoader: ((FZThemeStyle) -> (Bool, FZThemeMachineProtocol?)?)?

    // MARK: - init
    private override init() {
        super.init()

        observerUserInterfaceStyleChange()
    }
}

/// internal
extension FZThemeManager {

    /// 执行主题block
    /// - Parameters:
    ///   - block: block
    ///   - style: 当前的主题
    ///   - themeMachine: 当前的主题机
    internal func fireThemeBlock(_ block: FZThemeBlock, style: FZThemeStyle, themeMachine: FZThemeMachineProtocol?) {
        themeBlockFireQueue.async {
            block.themeBlock(style, themeMachine)
        }
    }

}

/// private
extension FZThemeManager {

    /// 系统主题监控
    private func observerUserInterfaceStyleChange() {
        // runtime method swizz

        let clz: AnyClass = UIWindow.classForCoder()
        let originalSelector = #selector(UIWindow.traitCollectionDidChange(_:))
        let swizzledSelector = #selector(UIWindow.fz_traitCollectionDidChange(_:))
        guard let originalMethod = class_getInstanceMethod(clz, originalSelector),
            let swizzledMethod = class_getInstanceMethod(clz, swizzledSelector)
            else {
                return
        }

        let didAddMethod =  class_addMethod(clz, originalSelector, swizzledMethod, method_getTypeEncoding(swizzledMethod))
        if didAddMethod {
            class_replaceMethod(clz, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }

    /// 获取当前主题机
    /// - Returns: FZThemeMachineProtocol
    internal func getCurrentThemeMachine() -> FZThemeMachineProtocol? {
        // cache
        var themeMachine: FZThemeMachineProtocol?
        var cached = false

        // 直接从cache取
        if let cacheResult = themeMachineCache[currentThemeStyle] {
            cached = cacheResult.0
            themeMachine = cacheResult.1
        } else {
            // cache中没有，调用加载方法
            if let themeLoader = themeLoader,
                let loadReault = themeLoader(currentThemeStyle) {

                cached = loadReault.0
                themeMachine = loadReault.1

                // 如果需要缓存，这里做缓存处理
                if cached {
                    themeMachineCache[currentThemeStyle] = (cached, themeMachine)
                }

            }
        }

        return themeMachine
    }

    /// 执行主题绑定block
    private func fireAllThemeBlock() {
        FZThemeConfiguration.themeStyleUpdate?(currentThemeStyle)

        let themeMachine = getCurrentThemeMachine()
        let currentStyle = currentThemeStyle

        themeBlockManagerQueue.async(flags: .barrier) { [weak self] in
            guard let `self` = self
                else {
                    return
            }

            self.themeBlockManager.objectEnumerator()?.allObjects.forEach({ (array) in
                if let array = array as? NSMutableArray {
                    array.forEach { (themeBlock) in
                        if let themeBlock = themeBlock as? FZThemeBlock {
                            self.fireThemeBlock(themeBlock, style: currentStyle, themeMachine: themeMachine)
                        }
                    }
                }
            })
        }
    }

}
