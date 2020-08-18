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

    /// 创建新的责任链handelr，并拼接到当前责任链上。
    /// 该方法创建的责任链不需要调用setNextHandler方法，内部已经按照创建顺序进行了处理。
    /// - Returns: 责任链handler
    public func createResponsibilityChainHandler(fallThrough: Bool = false) -> FZResponsibilityHandler<T> {
        let handler = FZResponsibilityHandler<T>(fallThrough: fallThrough)

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

    /// 创建责任链匹配失败处理handler，不会拼接责任链上。当责任链执行全部无法匹配时，会执行该handler。
    /// 仅由FZResponsibilityChainContext管理的责任链有该功能
    /// - Returns: 匹配失败handler
    public func createMatchingFailureHandler() -> FZResponsibilityHandler<T> {
        let handler = FZResponsibilityHandler<T>(fallThrough: false)

        self.matchingFailureHandler = handler

        return handler
    }

    /// 开始执行责任链处理流程。
    /// 当责任链都匹配不了时，会去执行MatchingFailureHandler，仅FZResponsibilityChainContext执行责任链时会有该步骤。
    /// - Parameter data: 责任链数据
    /// - Returns: 处理责任链数据的handler
    @discardableResult
    public func handlerExecute(with data: T) -> [FZResponsibilityHandler<T>] {
        var handlersResult: [FZResponsibilityHandler<T>] = []
        if let handlerExecutes = self.topHandler?.handlerExecute(withData: data) {
            handlersResult.append(contentsOf: handlerExecutes)
        }

        // 责任链匹配匹配失败handler执行时，不用判断执行条件
        if handlersResult.count == 0,
            let matchingFailureHandler = matchingFailureHandler {
            matchingFailureHandler.execute(data)
            handlersResult.append(matchingFailureHandler)
        }

        return handlersResult
    }

}
