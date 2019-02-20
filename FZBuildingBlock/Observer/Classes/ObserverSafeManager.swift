//
//  ObserverSafeManager.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/2/19.
//

import Foundation


/// 观察者管理器, 提供安全的操作方式
public class ObserverSafeManager<T>{
    
    /// 所有的观察者集合
    var observerArray = Array<Observer<T>>()
    
    /// 并发队列，触发执行时，使用异步执行，观察者有变动时，使用barrier执行
    fileprivate let queue = DispatchQueue(label: "ObserverManagerQueue", attributes: DispatchQueue.Attributes.concurrent)
    
    public func isEmpty() -> Bool {
        return observerArray.isEmpty
    }
    
    
    /// 触发监听方法，按照添加顺序执行
    ///
    /// - Parameter value:
    public func fireObserver(with value: T) -> Void{
        self.queue.async { [weak self] in
            guard let `self` = self else {
                return
            }
            self.observerArray.forEach({
                $0.action(value)
            })
        }
    }
    
    
    /// 添加观察者对象
    ///
    /// - Parameter observer:
    public func append(observer: Observer<T>){
        self.queue.async(flags: .barrier) { [weak self] in
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
    public func removeObserver(key: String){
        self.queue.async(flags: .barrier) { [weak self] in
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
    public func removeAll(){
        self.queue.async(flags: .barrier) { [weak self] in
            guard let `self` = self else {
                return
            }
            self.observerArray.removeAll(keepingCapacity: false)
        }
    }
    
}

