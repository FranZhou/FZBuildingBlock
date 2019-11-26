//
//  FZRunTime+MethodSwizzling.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/3/25.
//

import Foundation

extension FZRuntime {

    /// Runtime交换两个方法的实现
    ///
    /// - Parameters:
    ///   - originalClass: 类类型对象
    ///   - originalSelector: 原始方法
    ///   - swizzledSelector: 交换方法
    public class func methodSwizzling(clz: AnyClass, originalSelector: Selector, swizzledSelector: Selector) {
        guard let originalMethod = class_getInstanceMethod(clz, originalSelector),
            let swizzledMethod = class_getInstanceMethod(clz, swizzledSelector)
            else {
                return
        }

        let didAddMethod = class_addMethod(clz, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))

        // 要先尝试添加原 selector 是为了做一层保护，因为如果这个类没有实现 originalSelector ，但其父类实现了，那 class_getInstanceMethod 会返回父类的方法。这样 method_exchangeImplementations 替换的是父类的那个方法，这当然不是你想要的。所以我们先尝试添加 orginalSelector ，如果已经存在，再用 method_exchangeImplementations 把原方法的实现跟新的方法实现给交换掉。
        if didAddMethod {
            class_replaceMethod(clz, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }

}
