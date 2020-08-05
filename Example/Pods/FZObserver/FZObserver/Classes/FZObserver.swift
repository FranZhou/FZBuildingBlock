//
//  FZObserver.swift
//  FZObserver
//
//  Created by FranZhou on 2020/7/31.
//

import Foundation

/// 观察者

@propertyWrapper
open class FZObserver<T> {
    
    /// value change tuple
    public typealias Change = (old: T, new: T)
    
    /// observer action
    public typealias ObserveAction = (Change) -> Void
    
    /// 过滤Action,返回true表示允许修改
    public typealias FilterAction = (Change) -> Bool
    
    /// setter Action
    public typealias SetterAction = ObserveAction
    
    /// value 为最新的值,这里没有oldValue，old和new都传递当前的value；finish 闭包是终止观察的，调用 finish() 则会 remove
    public typealias OptionalEscapeingAction = (_ value: Change, _ finish: @escaping () -> Void) -> Void
    
    // MARK: -
    
    /// 所有观察者的管理器
    private var observerManager = FZObserverSafeManager<T>()
    
    /// 观察者管理队列，在该队列中管理观察者对象；新增或者删除使用barrier执行，阻塞其他操作；监听触发时，使用异步执行
    public var manageQueue: DispatchQueue{
        set{
            observerManager.manageQueue = newValue
        }
        get{
            return observerManager.manageQueue
        }
    }
    
    /// default = DispatchQueue.main；触发执行的执行队列,会在该队列上异步执行观察者回调
    public var fireQueue: DispatchQueue{
        set{
            observerManager.fireQueue = newValue
        }
        get{
            observerManager.fireQueue
        }
    }
    
    /// 通过了过滤器，数据才会更新， 默认允许执行更新
    public var updateFilter: FilterAction = { _ in true }
    
    /// 外部的setter方法， 默认什么都不做
    public var setterAction: SetterAction = { _ in }
    
    /// value
    private var value: T {
        didSet {
            // 代用外部的setter
            setterAction((old: oldValue, new: value))
            
            // 触发观察者监听
            observerManager.fireObserver(oldValue: oldValue, newValue: value)
        }
    }
    
    /// wrapperValue计算属性对value进行包装，控制对value的修改。
    /// 相应的观察者监听事件触发在 value 的 didSet 中进行。
    /// 不直接用 value ，是因为 value  的 willSet 中不能阻断赋值操作。
    public var wrappedValue: T {
        set {
            // 新数据能够进行更新
            guard updateFilter((old: value, new: newValue)) else {
                return
            }
            value = newValue
        }
        get {
            return value
        }
    }
    
    /// 初始化
    ///
    /// - Parameters:
    ///   - value: 给一个初始值
    ///   - updateFilter: 设置一个 guard 用来判断是否能够更新
    ///   - setter: 初始化绑定的更新回调
    public init(wrappedValue: T, updateFilter: @escaping FilterAction = { _ in true }, setter: @escaping SetterAction = { _ in }) {
        // value最先赋值 setterAction 和 updateFilter此时都还不能执行
        self.value = wrappedValue
        
        self.setterAction = setter
        self.updateFilter = updateFilter
    }
    
}

// MARK: - 观察者管理操作
extension FZObserver {
    
    /// 是否没有观察者了
    public var isEmpty: Bool {
        return observerManager.isEmpty()
    }
    
    /// 根据唯一标示和生命周期绑定对象移除指定观察者.
    /// 当key和target都为nil时，移除所有观察者
    ///
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
                removeAll()
            }
        }
    }
    
    /// 移除所有观察者
    public func removeAll() {
        observerManager.removeAll()
    }
    
}

// MARK: - 添加观察者模式触发后的执行操作
extension FZObserver {
    
    /// 添加观察者
    ///
    /// - Parameters:
    ///   - key: key
    ///   - target: 观察者生命周期绑定对象，为nil时会绑定到当前观察者对象上，作用是当target被释放时，相应的观察者也会自动释放
    ///   - count: 观察者监听触发次数， <= 0 时代表没有限制，默认值为 0
    ///   - action: 监听触发后执行action
    public func addObserver(key: String, target: AnyObject? = nil, count: Int64 = 0, action: @escaping ObserveAction) {
        // 默认target为当前Observer
        let _observerTarget = target ?? self
        
        guard count > 0 else {
            // count <= 0，不限次数触发
            observerManager.append(observer: FZObservable<T>(key: key, action: action), target: _observerTarget)
            return
        }
        
        // count > 0，需要计数器辅助控制触发次数
        
        // 计数器
        let counter = createCounter(start: count)
        
        observerManager.append(observer: FZObservable<T>(key: key, action: { [weak self, weak _observerTarget] t in
            action(t)
            
            // 每次触发更新，如果 count <= 0 则 remove, counter 会自减
            if counter() <= 0 {
                self?.removeObserver(key: key, target: _observerTarget)
            }
        }), target: _observerTarget)
        
    }
    
    /// 绑定观察者并且立即触发一次回调，立即触发的这次回调不会改变剩余触发次数
    ///
    /// - Parameters:
    ///   - key: key
    ///   - target: 观察者生命周期绑定对象，为nil时会绑定到当前观察者对象上，作用是当target被释放时，相应的观察者也会自动释放
    ///   - count: 观察者监听触发次数， <=0 时代表没有限制，默认值为 0
    ///   - action: (监听数据改变, 是否为立即触发的回调)
    public func addAndFireObserver(key: String, target: AnyObject? = nil, count: Int64 = 0, action: @escaping (Change, Bool) -> Void) {
        // true 说明这次是立即触发的
        action((old: value, new: value), true)
        
        addObserver(key: key, target: target, count: count) { 
            // 观察者监听触发的，都是false
            action($0, false)
        }
    }
    
    
    /// OptionalEscapeingAction 闭包与 FZObserver<T>.ObserveAction 的区别是多了一个 finish 参数,  它的作用是 removeObserver。
    /// 调用时机自己控制，设计的使用场景是，需要满足一定条件的值，一旦得到这个值之后就不需要监听了，此时执行 finish 然后 remove。
    ///
    /// - Parameters:
    ///   - key: key
    ///   - target: 观察者生命周期绑定对象，为nil时会绑定到当前观察者对象上，作用是当target被释放时，相应的观察者也会自动释放
    ///   - count: 观察者监听触发次数， <=0 时代表没有限制，默认值为 0
    ///   - immediately: 是否立即触发一次回调(当前值), 默认false
    ///   - action: 监听触发后执行action
    public func fireUntilCompleted(key: String, target: AnyObject? = nil, count: Int64 = 0, immediately: Bool = false, action: @escaping OptionalEscapeingAction) {
        // 默认target为当前Observer
        let _observerTarget = target ?? self
        
        // 只要 finish 回调一次就 remove， finish的触发由注册的地方来实现
        let finish = { [weak self, weak _observerTarget] in
            guard let `self` = self ,
                let target = _observerTarget else {
                    return
            }
            self.removeObserver(key: key, target: target)
        }
        
        addObserver(key: key, target: _observerTarget, count: count) {
            action($0, finish)
        }
        
        if immediately {
            action((old: value, new: value), finish)
        }
    }
    
    /// 创建一个计数器，每调用一次计数都会减一
    fileprivate func createCounter(start: Int64) -> (() -> Int64) {
        var startCount = start
        return {
            startCount -= 1
            return startCount
        }
    }
}
