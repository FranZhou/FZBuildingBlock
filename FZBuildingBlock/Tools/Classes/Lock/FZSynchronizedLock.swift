//
//  FZSynchronizedLock.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2020/9/24.
//

import Foundation

/// @synchronized
/// - Parameters:
///   - synchronizedTarget: synchronizedTarget
///   - synchronizedBlock: synchronizedBlock
public func FZSynchronizedLock<Result>(_ synchronizedTarget: Any, _ synchronizedBlock: () throws -> Result) rethrows -> Result {
    objc_sync_enter(synchronizedTarget)
    defer {
        objc_sync_exit(synchronizedTarget)
    }

    return try synchronizedBlock()
}
