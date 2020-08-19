//
//  FZUserDefault.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2020/8/19.
//

import Foundation

/**
 Demo:
 
 ```
 ///封装一个FZUserDefault配置文件
 struct FZUserDefaultsConfig {
     ///告诉编译器 我要包裹的是hadShownGuideView这个值。
     ///实际写法就是在FZUserDefault包裹器的初始化方法前加了个@
     /// hadShownGuideView 属性的一些key和默认值已经在 FZUserDefault包裹器的构造方法中实现
     @FZUserDefault(key: "had_shown_guide_view", defaultValue: false)
     static var hadShownGuideView: Bool
 }

 ///具体的业务代码。
 UserDefaultsConfig.hadShownGuideView = false
 print(UserDefaultsConfig.hadShownGuideView) // false
 UserDefaultsConfig.hadShownGuideView = true
 print(UserDefaultsConfig.hadShownGuideView) // true

 ```
 
 */
@propertyWrapper
public struct FZUserDefault<T> {

    ///这里的属性key 和 defaultValue 还有init方法都是实际业务中的业务代码
    ///我们不需要过多关注
    let key: String
    let defaultValue: T

    public init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    ///  wrappedValue是@propertyWrapper必须要实现的属性
    /// 当操作我们要包裹的属性时  其具体set get方法实际上走的都是wrappedValue 的set get 方法。
    public var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}
