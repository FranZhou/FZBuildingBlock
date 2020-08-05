//
//  FZObserverSafeManager.swift
//  FZObserver
//
//  Created by FranZhou on 2020/7/31.
//

import Foundation

/// 观察者管理器, 提供安全的操作方式
final class FZObserverSafeManager<T> {

    /// 所有观察者的持有者。
    /// 观察者会和一个target做生命周期绑定，当target释放时，绑定到target上的观察者也会释放。
    /// 这里用NSMutableArray而不是NSMutableSet的原因是为了保证执行顺序。
    private let observerHolder: NSMapTable<AnyObject, NSMutableArray> = {
        let observerMap = NSMapTable<AnyObject, NSMutableArray>.weakToStrongObjects()
        return observerMap
    }()

    /// 观察者管理队列，在该队列中管理观察者对象；新增或者删除使用barrier执行，阻塞其他操作；监听触发时，使用异步执行
    var manageQueue: DispatchQueue = DispatchQueue(label: "com.fzbuildingblock.ObserverSafeManagerQueue", attributes: DispatchQueue.Attributes.concurrent)

    /// default = DispatchQueue.main；触发执行的执行队列,会在该队列上异步执行观察者回调
    var fireQueue: DispatchQueue = DispatchQueue.main

    public func isEmpty() -> Bool {
        if observerHolder.count == 0 {
            return true
        } else {
            // 获取所有观察者对象
            guard let allObservers = self.observerHolder.objectEnumerator()?.allObjects.flatMap({ (obj) -> Array<FZObservable<T>> in
                if let objArray = obj as? NSMutableArray,
                    let observerArray = Array(objArray) as? Array<FZObservable<T>> {
                    return observerArray
                }
                return []
            }) else {
                return true
            }
            return allObservers.count == 0
        }
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
            let allObservers = self.observerHolder.objectEnumerator()?.allObjects.flatMap({ (obj) -> Array<FZObservable<T>> in
                if let objArray = obj as? NSMutableArray,
                    let observerArray = Array(objArray) as? Array<FZObservable<T>> {
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
    public func append(observer: FZObservable<T>, target: AnyObject) {
        self.manageQueue.async(flags: .barrier) { [weak self, weak target] in
            guard let `self` = self,
                let target = target else {
                    return
            }

            if let observerArrayForTarget = self.observerHolder.object(forKey: target),
                let observerArray = observerArrayForTarget as? Array<FZObservable<T>> {

                // 移除同一target下相同key的观察者
                observerArray.forEach { (_observer: FZObservable<T>) in
                    if observer.key == _observer.key {
                        observerArrayForTarget.remove(_observer)
                    }
                }

                // 记录最新添加的观察者对象
                observerArrayForTarget.add(observer)
            } else {
                let objArray = NSMutableArray()
                objArray.add(observer)

                self.observerHolder.setObject(objArray, forKey: target)
            }

        }
    }

    /// 根据唯一标示和生命周期绑定对象移除指定观察者
    /// - Parameter key: 唯一标示
    /// - Parameter target: 观察者生命周期绑定对象，当target被释放时，相应的观察者也会自动释放
    public func removeObserver(key: String, target: AnyObject) {
        self.manageQueue.async(flags: .barrier) { [weak self, weak target] in
            guard let `self` = self,
                let target = target else {
                    return
            }

            if let observerArrayForTarget = self.observerHolder.object(forKey: target),
                let observerArray = observerArrayForTarget as? Array<FZObservable<T>> {

                observerArray.forEach { (observer: FZObservable<T>) in
                    if observer.key == key {
                        observerArrayForTarget.remove(observer)
                    }
                }

            }

        }
    }

    /// 根据唯一标示移除指定观察者
    /// - Parameter key: 唯一标示
    public func removeObserver(key: String) {
        self.manageQueue.async(flags: .barrier) { [weak self] in
            guard let `self` = self else {
                return
            }

            self.observerHolder.keyEnumerator().allObjects.forEach { (obj) in
                if let observerArrayForTarget = self.observerHolder.object(forKey: obj as AnyObject),
                    let observerArray = observerArrayForTarget as? Array<FZObservable<T>> {

                    observerArray.forEach { (observer: FZObservable<T>) in
                        if observer.key == key {
                            observerArrayForTarget.remove(observer)
                        }
                    }

                }
            }
        }
    }

    /// 根据生命周期绑定对象移除指定观察者
    /// - Parameter target: 观察者生命周期绑定对象，当target被释放时，相应的观察者也会自动释放
    public func removeObserver(target: AnyObject) {
        self.manageQueue.async(flags: .barrier) { [weak self, weak target] in
            guard let `self` = self,
                let target = target else {
                    return
            }

            self.observerHolder.removeObject(forKey: target)

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
