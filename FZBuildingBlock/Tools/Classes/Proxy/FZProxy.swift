//
//  FZProxy.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/12/5.
//

import Foundation

public final class FZProxy: NSObject {

    weak private(set) var target: NSObject?

    public init(target: NSObject?) {
        self.target = target
        super.init()
    }

    public override func isKind(of aClass: AnyClass) -> Bool {
        return target?.isKind(of: aClass) == true
    }

    public override func isMember(of aClass: AnyClass) -> Bool {
        return target?.isMember(of: aClass) == true
    }

    public override func conforms(to aProtocol: Protocol) -> Bool {
        return target?.conforms(to: aProtocol) == true
    }

    public override func responds(to aSelector: Selector!) -> Bool {
        return target?.responds(to: aSelector) == true
    }

    public override func forwardingTarget(for aSelector: Selector!) -> Any? {
        if target?.responds(to: aSelector) == true {
            return target
        }
        return nil
    }

}
