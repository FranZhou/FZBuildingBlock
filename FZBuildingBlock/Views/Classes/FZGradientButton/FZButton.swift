//
//  FZButton.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2020/7/29.
//

import UIKit

open class FZButton: UIButton {
    
    private var btnEvents: Array<FZButtonEvent> = Array<FZButtonEvent>()
    
    /// 并发队列，控制对btnEvents的安全访问
    private let queue = DispatchQueue(label: "com.fzbuildingblock.FZButtonSafeManagerQueue", attributes: .concurrent)
    
    /// 允许重复点击，默认关闭
    public var allowRepeatClick: Bool = false
    
    /// 点击事件之间间隔时间(单位秒)，默认1秒
    public var timeInterval: TimeInterval = 1
}

extension FZButton{
    
    open override func sendAction(_ action: Selector, to target: Any?, for event: UIEvent?) {
        if self.allowRepeatClick {
            super.sendAction(action, to: target, for: event)
        }else{
            // 创建FZButtonEvent， 默认isIgnoreEvent = false
            let btnEvent = FZButtonEvent(target: target as AnyObject?, action: action)
            
            // 同步上次的isIgnoreEvent状态
            queue.sync { [weak self] in
                if let `self` = self,
                    let be = self.btnEvents.first(where: {
                        $0.isEqual(btnEvent)
                    }){
                    btnEvent.isIgnoreEvent = be.isIgnoreEvent
                }
            }
            
            // isIgnoreEvent=false，可以执行
            if !btnEvent.isIgnoreEvent {
                // 标记isIgnoreEvent = true
                btnEvent.isIgnoreEvent = true
                btnEvents.append(btnEvent)
                
                // 执行event
                super.sendAction(action, to: target, for: event)
                
                // 间隔时间到达之后， isIgnoreEvent置为false
                self.perform(#selector(openEventIgnoreStatus(event:)), with: btnEvent, afterDelay: self.timeInterval < 0 ? 0 : self.timeInterval)
            }
        }
    }
    
    @objc private func openEventIgnoreStatus(event: Any?){
        if let btnEvent = event as? FZButtonEvent {
            queue.async(flags: .barrier) { [weak self] in
                if let `self` = self{
                    btnEvent.isIgnoreEvent = false
                    self.btnEvents.removeAll {
                        $0.isEqual(btnEvent)
                    }
                }
            }
        }
    }
}

