//
//  FZResponsibilityHandler.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2020/8/13.
//

import Foundation

/// 责任链handler
public final class FZResponsibilityHandler<T> {

    /// 责任链类型
    public let handlerType: FZResponsibilityHandlerType

    /// 责任链下一个处理者
    internal private(set) var nextHandler: FZResponsibilityHandler<T>?

    /// 当前handler执行条件，默认不满足条件
    public var condition: ((T) -> Bool) = { _ in false}

    /// 当前handler具体执行操作
    public var execute: ((T) -> Void) = { _ in }

    public init(handlerType: FZResponsibilityHandlerType = .normal) {
        self.handlerType = handlerType
    }

    @discardableResult
    func setNextHandler(_ nextHandler: FZResponsibilityHandler<T>) -> Self {
        if self !== nextHandler {
            let currentNextHandler = self.nextHandler
            self.nextHandler = nextHandler

            if let oldNext = currentNextHandler {
                var lastHandler = nextHandler
                while lastHandler.nextHandler != nil {
                    lastHandler = lastHandler.nextHandler!
                }
                lastHandler.setNextHandler(oldNext)
            }
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

    /// 执行责任链流程, 只会执行 handlerType == .normal handler，其他handlerType类型会跳过
    /// - Parameter data: 责任链数据
    /// - Returns: 处理责任链数据的handler
    @discardableResult
    public func handlerExecute(withData data: T) -> FZResponsibilityHandler<T>? {
        if condition(data) && handlerType == .normal {
            execute(data)
            return self
        } else if let next = nextHandler {
            return next.handlerExecute(withData: data)
        } else {
            return nil
        }
    }

}
