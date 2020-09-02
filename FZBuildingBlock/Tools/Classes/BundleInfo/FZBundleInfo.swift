//
//  FZBundleInfo.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2020/9/1.
//

import Foundation

/**
 
 Demo:
 ```
 struct FZBundleInfoConfig {

     @FZBundleInfo(key: "CFBundleDisplayName", defaultValue: "")
     static var bundleDisplayName: String
     
     @FZBundleInfo(key: "CFBundleVersion", defaultValue: "")
     static var bundleVersion: String
     
     @FZBundleInfo(key: "CFBundleShortVersionString", defaultValue: "")
     static var bundleShortVersionString: String
 }
 
 print(FZBundleInfoConfig.bundleDisplayName)
 print(FZBundleInfoConfig.bundleVersion)
 print(FZBundleInfoConfig.bundleShortVersionString)

 ```
 
 if you want change targetBundle, you can use it like this:
 ```
 let targetBundleInfo = FZBundleInfo(key: "CFBundleVersion", defaultValue: "")
 targetBundleInfo.targetBundle = XXX
 print(targetBundleInfo.wrappedValue)
 
 ```
 
 */
@propertyWrapper
public struct FZBundleInfo<T> {

    /// default = Bundle.main
    public var targetBundle: Bundle = Bundle.main

    let key: String
    let defaultValue: T

    /// init
    /// - Parameters:
    ///   - key: key
    ///   - defaultValue: defaultValue
    ///   - targetBundle: targetBundle , default = Bundle.main
    public init(key: String, defaultValue: T, targetBundle: Bundle = Bundle.main) {
        self.key = key
        self.defaultValue = defaultValue
        self.targetBundle = targetBundle
    }

    /// wrappedValue是@propertyWrapper必须要实现的属性
    /// 当操作我们要包裹的属性时  其具体set get方法实际上走的都是wrappedValue 的set get 方法。
    /// FZBundleInfo实际是从bundle的infoDictionary里面获取数据，这里不能写入数据
    public var wrappedValue: T {
        get {
            return targetBundle.infoDictionary?[key] as? T ?? defaultValue
        }
    }

}
