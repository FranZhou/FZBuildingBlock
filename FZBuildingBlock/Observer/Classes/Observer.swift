//
//  Observer.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/2/19.
//

import Foundation


/// 观察者对象
public struct Observer<T>: Hashable {
    
    public typealias Action = (T) -> Void
    
    /// 观察者唯一标示
    public let key: String
    
    /// 触发监听执行的action
    public let action: Action
    
    public var hashValue: Int {
        return key.hashValue
    }
    
    
    // MARK: - Equatable protocol
    
    public static func == (lhs: Observer<T>, rhs: Observer<T>) -> Bool {
        return lhs.key == rhs.key
    }
    
}

