//
//  FZResponsibilityChainContext.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2020/8/13.
//

import Foundation

/// 责任链模式
public final class FZResponsibilityChainContext <T> {

    /// 责任链起始点Handler
    public private(set) var topHandler: FZResponsibilityHandler<T>?

    /// 责任链匹配失败处理handler
    public private(set) var matchingFailureHandler: FZResponsibilityHandler<T>?

    public init() {

    }

    /// 创建新的责任链handelr，并拼接到当前责任链上
    /// - Returns: 责任链handler
    public func createResponsibilityChainHandler() -> FZResponsibilityHandler<T> {
        let handler = FZResponsibilityHandler<T>(handlerType: .normal)

        var lastHandler = topHandler
        while lastHandler?.nextHandler != nil {
            lastHandler = lastHandler?.nextHandler
        }
        lastHandler?.setNextHandler(handler)

        // 记录责任链起始点handler
        if topHandler == nil {
            topHandler = handler
        }

        return handler
    }

    /// 创建责任链匹配失败处理handler，不会拼接责任链上。当责任链执行全部无法匹配时，会执行该handler
    /// - Returns: 匹配失败handler
    public func createMatchingFailureHandler() -> FZResponsibilityHandler<T> {
        let handler = FZResponsibilityHandler<T>(handlerType: .matchingFailure)

        self.matchingFailureHandler = handler

        return handler
    }

    /// 开始执行责任链处理流程
    /// - Parameter data: 责任链数据
    /// - Returns: 处理责任链数据的handler
    @discardableResult
    public func handler(responsibilityData data: T) -> FZResponsibilityHandler<T>? {
        var handler = self.topHandler?.handlerExecute(withData: data)

        if handler == nil,
            let matchingFailureHandler = matchingFailureHandler,
            matchingFailureHandler.handlerType == .matchingFailure {

            matchingFailureHandler.execute(data)
            handler = matchingFailureHandler
        }

        return handler
    }

}
