//
//  FZMutexLock.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2020/9/24.
//

import Foundation

/**
 pthread_mutex 普通锁
 mutex叫做互斥锁,等待锁的线程会处于休眠状态
 NSLock与NSRecursiveLock是对pthread_mutex锁的属性为normal与recursive的封装
 */

public enum FZMutexLockType {
    case normal
    case recursive
}

public class FZMutexLock {

    private var mutexLock: NSLocking

    public init(lockType: FZMutexLockType = .normal) {
        switch lockType {
            case .normal:
                mutexLock = NSLock()
            case .recursive:
                mutexLock = NSRecursiveLock()
            @unknown default:
                mutexLock = NSLock()
        }
    }

}

extension FZMutexLock: FZLock {

    public func lock() {
        mutexLock.lock()
    }

    public func tryLock() -> Bool {
        if let lock = mutexLock as? NSLock {
            return lock.try()
        } else if let lock = mutexLock as? NSRecursiveLock {
            return lock.try()
        } else {
            return false
        }
    }

    public func unlock() {
        mutexLock.unlock()
    }

}
