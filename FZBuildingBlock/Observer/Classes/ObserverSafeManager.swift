//
//  ObserverSafeManager.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/2/19.
//

import Foundation

/// 观察者管理器, 提供安全的操作方式
open class ObserverSafeManager<T>: NSObject {

    /// 所有的观察者集合
    var observerArray = Array<Observer<T>>()

    /// 观察者管理队列，在该队列中管理观察者对象；新增或者删除使用barrier执行，阻塞其他操作；监听触发时，使用异步执行
    private var manageQueue = DispatchQueue(label: "com.fzbuildingblock.ObserverSafeManagerQueue", attributes: DispatchQueue.Attributes.concurrent)

    /// default = DispatchQueue.main；触发执行的执行队列,会在该队列上异步执行观察者回调
    public var fireQueue: DispatchQueue = DispatchQueue.main

    public func isEmpty() -> Bool {
        return observerArray.isEmpty
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
            // 对全部监听者对象进行一次copy
            let observerArray = Array<Observer<T>>(self.observerArray)
            // 在触发队列触发监听者监控操作
            self.fireQueue.async {
                observerArray.forEach({observer in
                    observer.action((old: oldValue, new: newValue))
                })
            }
        }
    }

    /// 添加观察者对象
    ///
    /// - Parameter observer:
    public func append(observer: Observer<T>) {
        self.manageQueue.async(flags: .barrier) { [weak self] in
            guard let `self` = self else {
                return
            }

            guard let index = self.observerArray.firstIndex(where: { (o: Observer<T>) -> Bool in
                return o == observer
            }) else {
                self.observerArray.append(observer)
                return
            }
            self.observerArray.remove(at: index)
            self.observerArray.append(observer)
        }
    }

    /// 移除指定观察者
    ///
    /// - Parameter key: 唯一标示
    public func removeObserver(key: String) {
        self.manageQueue.async(flags: .barrier) { [weak self] in
            guard let `self` = self else {
                return
            }

            guard let index = self.observerArray.firstIndex(where: { (o: Observer<T>) -> Bool in
                return o.key == key
            }) else {
                return
            }
            self.observerArray.remove(at: index)
        }
    }

    /// 移除所有观察者
    public func removeAll() {
        self.manageQueue.async(flags: .barrier) { [weak self] in
            guard let `self` = self else {
                return
            }
            self.observerArray.removeAll(keepingCapacity: false)
        }
    }

}
