//
//  FZObserver.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/2/19.
//

import Foundation

/// 观察者对象
open class FZObserver<T>: NSObject {
    /// value change tuple
    public typealias Change = (old: T, new: T)

    public typealias Action = (Change) -> Void

    /// 观察者唯一标示
    public let key: String

    /// 触发监听执行的action
    public let action: Action

    // MARK: - Hashable
    public override var hash: Int {
        return key.hashValue
    }

    public init(key: String, action: @escaping Action) {
        self.key = key
        self.action = action

        super.init()
    }

    // MARK: - Equatable protocol

    public static func == (lhs: FZObserver<T>, rhs: FZObserver<T>) -> Bool {
        return lhs.key == rhs.key
    }

}
