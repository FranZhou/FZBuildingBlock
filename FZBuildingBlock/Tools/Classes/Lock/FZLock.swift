//
//  FZLock.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2020/9/24.
//

import Foundation

public protocol FZLock {

    func lock()

    func tryLock() -> Bool

    func unlock()

    func performLocked<Result>(_ action: () throws -> Result) rethrows -> Result

}

extension FZLock {

    @inline(__always)
    public func performLocked<Result>(_ action: () throws -> Result) rethrows -> Result {
        if tryLock() {
            lock()
        }
        defer {
            unlock()
        }
        return try action()
    }

}
