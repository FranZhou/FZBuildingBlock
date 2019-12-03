//
//  ObserverAble.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/2/19.
//

import Foundation

/// 可观察对象， T 为 value的类型
open class ObserveAble<T>: NSObject {

    /// value change tuple
    public typealias Change = (old: T, new: T)

    /// 过滤Action,返回true表示允许修改
    public typealias FilterAction = (Change) -> Bool

    /// setter Action
    public typealias SetterAction = (Change) -> Void

    /// value 为最新的值,这里没有oldValue，old和new都传递当前的value；finish 闭包是终止观察的，调用 finish() 则会 remove
    public typealias OptionalEscapeingAction = (_ value: Change, _ finish: @escaping () -> Void) -> Void

    /// 通过了过滤器，数据才会更新
    public var updateFilter: FilterAction

    /// 外部的setter方法
    public var setterAction: SetterAction

    /// 所有观察者的管理器
    public var observerManager = ObserverSafeManager<T>()

    /// 最新的 value
    public private(set) var value: T {
        didSet {
            setterAction((old: oldValue, new: value))
            observerManager.fireObserver(oldValue: oldValue, newValue: value)
        }
    }

    /// 唯一可以更新 value 的方法 需要通过 updateGuard 来判断，只有返回 true 才能更新
    ///
    /// - Parameter v: 需要更新的 value
    public func update(value: T) {
        guard updateFilter((old: self.value, new: value)) else { return }
        self.value = value
    }

    /// 初始化
    ///
    /// - Parameters:
    ///   - value: 给一个初始值
    ///   - updateGuard: 设置一个 guard 用来判断是否能够更新
    ///   - setter: 初始化绑定的更新回调
    public init(value: T, updateFilter: FilterAction? = nil, setter: @escaping SetterAction = { _ in }) {
        self.value = value
        setterAction = setter
        self.updateFilter = updateFilter ?? { _ in return true }
    }

}

// MARK: - 观察者管理操作
extension ObserveAble {

    /// 是否没有观察者了
    public var isEmpty: Bool {
        return observerManager.isEmpty()
    }

//    /// 根据唯一标示和生命周期绑定对象移除指定观察者
//    /// - Parameter key: key
//    /// - Parameter target: target
//    public func removeObserver(key: String, target: AnyObject) {
//        observerManager.removeObserver(key: key, target: target)
//    }
//
//    /// 根据唯一标示移除指定观察者
//    /// - Parameter key: key
//    public func removeObserver(key: String) {
//        observerManager.removeObserver(key: key)
//    }
//
//    /// 根据生命周期绑定对象移除指定观察者
//    /// - Parameter target: target
//    public func removeObserver(target: AnyObject) {
//        observerManager.removeObserver(target: target)
//    }

    /// 根据唯一标示和生命周期绑定对象移除指定观察者
    /// - Parameter key: key
    /// - Parameter target: target
    public func removeObserver(key: String? = nil, target: AnyObject? = nil) {
        if let key = key {
            if let target = target {
                observerManager.removeObserver(key: key, target: target)
            } else {
                observerManager.removeObserver(key: key)
            }
        } else {
            if let target = target {
                observerManager.removeObserver(target: target)
            } else {
                // no key no target, do nothing
            }
        }
    }

    /// 移除所有观察者
    public func removeAll() {
        observerManager.removeAll()
    }

}

// MARK: - 添加观察者, 添加之后需要注意移除操作
extension ObserveAble {

    /// 绑定观察者
    ///
    /// - Parameters:
    ///   - key: 唯一标示
    ///   - target: 观察者生命周期绑定对象，当target被释放时，相应的观察者也会自动释放
    ///   - count: 更新触发的次数，nil 则没有限制
    ///   - action: 观察者执行Action
    public func bindObserver(key: String, target: AnyObject, count: Int? = nil, action: @escaping Observer<T>.Action) {
        guard let count = count, count > 0 else {
            observerManager.append(observer: Observer<T>(key: key, action: action), target: target)
            return
        }

        let counter = createCounter(start: count)

        observerManager.append(observer: Observer<T>(key: key, action: { [weak self] t in
            action(t)

            // 每次触发更新，如果 count == 0 则 remove, counter 会自减
            if counter() == 0 {
                self?.removeObserver(key: key, target: target)
            }
        }), target: target)

    }

    /// 绑定观察者并且立即触发一次回调
    ///
    /// - Parameters:
    ///   - key: 唯一标示
    ///   - target: 观察者生命周期绑定对象，当target被释放时，相应的观察者也会自动释放
    ///   - count: 更新触发的次数, nil 则没有限制，立即触发的一次回调不回改变 count
    ///   - action: (观察者, 是否为立即触发的回调)
    public func bindAndFireObserver(key: String, target: AnyObject, count: Int? = nil, action: @escaping (Change, Bool) -> Void) {
        bindObserver(key: key, target: target, count: count) {
            action($0, false)
        }
        action((old: value, new: value), true)
    }

    /// 只观察下一次的 value 更新，无论是什么值，回调一次就 remove
    ///
    /// - Parameters:
    ///   - key: 唯一标示
    ///   - target: 观察者生命周期绑定对象，当target被释放时，相应的观察者也会自动释放
    ///   - action: 观察者
    public func fireOnce(key: String, target: AnyObject, action: @escaping Observer<T>.Action) {
        bindObserver(key: key, target: target, count: 1, action: action)
    }

    /// OptionalEscapeingAction 闭包与 Observer<T>.Action 的区别是多了一个 finish 参数, 这同样是一个闭包, 它的作用是 removeObserver
    /// 调用时机自己控制，设计的使用场景是，需要满足一定条件的值，一旦得到这个值之后就不需要监听了，此时执行 finish 然后 remove
    ///
    /// - Parameters:
    ///   - key: 唯一标示
    ///   - target: 观察者生命周期绑定对象，当target被释放时，相应的观察者也会自动释放
    ///   - immediate: 是否立即触发一次回调(当前值)
    ///   - action: 更新回调闭包
    public func fireUntilCompleted(key: String, target: AnyObject, immediate: Bool, action: @escaping OptionalEscapeingAction) {

        // 只要 finish 回调一次就 remove， finish的触发由注册的地方来实现
        let finish = { [weak self, weak target] in
            guard let `self` = self ,
                let target = target else {
                    return
            }
            self.removeObserver(key: key, target: target)
        }

        self.bindObserver(key: key, target: target) {
            action($0, finish)
        }

        if immediate {
            action((old: value, new: value), finish)
        }
    }

    /// 创建一个计数器，每调用一次计数都会减一
    fileprivate func createCounter(start: Int) -> (() -> Int) {
        var startCount = start
        return {
            startCount -= 1
            return startCount
        }
    }
}
