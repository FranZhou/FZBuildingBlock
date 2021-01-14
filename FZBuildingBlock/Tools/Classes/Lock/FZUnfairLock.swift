//
//  FZUnfairLock.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2020/9/24.
//

import Foundation

/**
 os_unfair_lock用于取代不安全的OSSpinLock,从iOS10开始才支持.
 从底层调用看,等待os_unfair_lock锁的线程会处于休眠状态,并非忙等
 */

@available(iOS 10.0, *)
public class FZUnfairLock {

    private lazy var unfairLock = os_unfair_lock_s()

}

@available(iOS 10.0, *)
extension FZUnfairLock: FZLock {

    public func lock() {
        os_unfair_lock_lock(&unfairLock)
    }

    public func tryLock() -> Bool {
        return os_unfair_lock_trylock(&unfairLock)
    }

    public func unlock() {
        os_unfair_lock_unlock(&unfairLock)
    }

}
