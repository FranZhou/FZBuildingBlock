//
//  FZResponsibilityHandler.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2020/8/13.
//

import Foundation

/// 责任链handler
public final class FZResponsibilityHandler<T> {

    /// fallThrough
    public let fallThrough: Bool

    /// 责任链下一个处理者
    internal private(set) var nextHandler: FZResponsibilityHandler<T>?

    /// 当前handler执行条件，默认不满足条件
    public var condition: ((T) -> Bool) = { _ in false}

    /// 当前handler具体执行操作
    public var execute: ((T) -> Void) = { _ in }

    public init(fallThrough: Bool = false) {
        self.fallThrough = fallThrough
    }

}

// MARK: - 链式语法
extension FZResponsibilityHandler {

    /// 设置责任链nextHandler
    ///
    /// - Parameter nextHandler: nextHandler
    /// - Returns: self，链式调用
    @discardableResult
    func setNextHandler(_ nextHandler: FZResponsibilityHandler<T>) -> Self {
        guard self !== nextHandler else {
            return self
        }

        // 断开循环
        breakCycle(chain: self, loopNode: nextHandler)
        breakCycle(chain: nextHandler, loopNode: self)

        let currentNextHandler = self.nextHandler
        self.nextHandler = nextHandler

        if let oldNext = currentNextHandler {
            var lastHandler = nextHandler
            while lastHandler.nextHandler != nil {
                lastHandler = lastHandler.nextHandler!
            }
            lastHandler.setNextHandler(oldNext)
        }
        return self
    }

    @discardableResult
    public func setConditioon(_ condition: @escaping ((T) -> Bool)) -> Self {
        self.condition = condition
        return self
    }

    @discardableResult
    public func setExecute(_ execute: @escaping ((T) -> Void)) -> Self {
        self.execute = execute
        return self
    }

    /// 断开循环链
    /// - Parameters:
    ///   - chain: 链式结构
    ///   - target: 判断循环指向的链节点
    private func breakCycle(chain: FZResponsibilityHandler<T>, loopNode: FZResponsibilityHandler<T>) {
        var cycleHandler: FZResponsibilityHandler<T>? = chain
        repeat {
            if let next = cycleHandler?.nextHandler,
                next === loopNode {
                cycleHandler?.nextHandler = nil
            }
            cycleHandler = cycleHandler?.nextHandler
        } while cycleHandler != nil
    }

}

// MARK: - 责任链调用
extension FZResponsibilityHandler {

    /// 执行责任链流程
    /// - Parameter data: 责任链数据
    /// - Returns: 处理责任链数据的handler
    @discardableResult
    public func handlerExecute(withData data: T) -> [FZResponsibilityHandler<T>] {
        return execute(data: data, records: [])
    }

    /// 尾递归执行责任链调用
    /// - Parameters:
    ///   - data: 责任链数据
    ///   - records: 处理该数据的handler集合
    /// - Returns: records
    private func execute(data: T, records: [FZResponsibilityHandler<T>]) -> [FZResponsibilityHandler<T>] {
        var _records = records
        if condition(data) {
            execute(data)
            _records.append(self)
            if let next = nextHandler,
                fallThrough {
                return next.execute(data: data, records: _records)
            } else {
                return _records
            }
        } else if let next = nextHandler {
            return next.execute(data: data, records: _records)
        } else {
            return _records
        }
    }

}
