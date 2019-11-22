//
//  ObserverSafeManager.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/2/19.
//

import Foundation

/// 观察者管理器, 提供安全的操作方式
open class ObserverSafeManager<T>: NSObject {

    private let observerHolder: NSMapTable<AnyObject, NSMutableSet> = {
        let observerMap = NSMapTable<AnyObject, NSMutableSet>.weakToStrongObjects()
        return observerMap
    }()

    /// 观察者管理队列，在该队列中管理观察者对象；新增或者删除使用barrier执行，阻塞其他操作；监听触发时，使用异步执行
    private var manageQueue = DispatchQueue(label: "com.fzbuildingblock.ObserverSafeManagerQueue", attributes: DispatchQueue.Attributes.concurrent)

    /// default = DispatchQueue.main；触发执行的执行队列,会在该队列上异步执行观察者回调
    public var fireQueue: DispatchQueue = DispatchQueue.main

    public func isEmpty() -> Bool {
        return observerHolder.count == 0
    }

    /// 触发监听方法，按照添加顺序执行
    ///
    /// - Parameters:
    ///   - oldValue: 旧值
    ///   - newValue: 最新值
    public func fireObserver(oldValue: T, newValue: T) {
        self.manageQueue.async { [weak self] in
            guard let `self` = self else {
                return
            }

            // 获取所有观察者对象
            let allObservers = self.observerHolder.objectEnumerator()?.allObjects.flatMap({ (obj) -> Array<Observer<T>> in
                if let observerSet = obj as? NSMutableSet,
                    let observerArray = Array(observerSet) as? Array<Observer<T>> {
                    return observerArray
                }
                return []
            })

            // 在触发队列触发监听者监控操作
            self.fireQueue.async {
                allObservers?.forEach({observer in
                    observer.action((old: oldValue, new: newValue))
                })
            }
        }
    }

    /// 添加观察者对象
    /// - Parameter observer: 观察者
    /// - Parameter target: 观察者生命周期绑定对象，当target被释放时，相应的观察者也会自动释放
    public func append(observer: Observer<T>, target: AnyObject) {
        self.manageQueue.async(flags: .barrier) { [weak self] in
            guard let `self` = self else {
                return
            }

            if let observerForTarget = self.observerHolder.object(forKey: target) {
                observerForTarget.add(observer)
            } else {
                let observerSet = NSMutableSet()
                observerSet.add(observer)

                self.observerHolder.setObject(observerSet, forKey: target)
            }

        }
    }

    /// 移除指定观察者
    /// - Parameter key: 唯一标示
    /// - Parameter target: 观察者生命周期绑定对象，当target被释放时，相应的观察者也会自动释放
    public func removeObserver(key: String, target: AnyObject) {
        self.manageQueue.async(flags: .barrier) { [weak self] in
            guard let `self` = self else {
                return
            }

            if let observerForTarget = self.observerHolder.object(forKey: target) {
                let observerArray = observerForTarget.compactMap({ (obj) -> Observer<T>? in
                    return obj as? Observer<T>
                })

                observerArray.forEach { (observer: Observer<T>) in
                    if observer.key == key {
                        observerForTarget.remove(observer)
                    }
                }

            }

        }
    }

    /// 移除所有观察者
    public func removeAll() {
        self.manageQueue.async(flags: .barrier) { [weak self] in
            guard let `self` = self else {
                return
            }
            self.observerHolder.removeAllObjects()
        }
    }

}
