//
//  FZObservable.swift
//  FZObserver
//
//  Created by FranZhou on 2020/7/31.
//

import Foundation


/// 可观察对象
final class FZObservable<T>: Equatable, Hashable {
    
    /// 观察者唯一标示
    public let key: String

    /// 触发监听执行的action
    public let action: FZObserver<T>.ObserveAction

    public init(key: String, action: @escaping FZObserver<T>.ObserveAction) {
        self.key = key
        self.action = action
    }
    
    // MARK: - Hashable
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(key.hashValue)
    }
    
    public var hashValue: Int{
        get{
            return key.hashValue
        }
    }

    // MARK: - Equatable protocol

    public static func == (lhs: FZObservable<T>, rhs: FZObservable<T>) -> Bool {
        return lhs.key == rhs.key
    }
    
}
