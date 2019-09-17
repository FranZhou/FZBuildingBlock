//
//  Observer.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/2/19.
//

import Foundation

/// 观察者对象
public struct Observer<T>: Hashable {
    /// value change tuple
    public typealias Change = (old: T, new: T)

    public typealias Action = (Change) -> Void

    /// 观察者唯一标示
    public let key: String

    /// 触发监听执行的action
    public let action: Action

    // MARK: - Hashable
    public var hashValue: Int {
        return key.hashValue
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.key)
    }

    // MARK: - Equatable protocol

    public static func == (lhs: Observer<T>, rhs: Observer<T>) -> Bool {
        return lhs.key == rhs.key
    }

}
