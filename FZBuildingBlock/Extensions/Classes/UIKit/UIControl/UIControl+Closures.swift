//
//  UIControl+Closures.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/8/7.
//

import Foundation

private struct FZUIControlEventClosureAssociatedKey {
    static var associatedKeys: UnsafeRawPointer = UnsafeRawPointer(bitPattern: "FZUIControlEventClosureAssociatedKey_associatedKeys".hashValue)!
}

// MARK: - property
extension FZBuildingBlockWrapper where Base: UIControl {

    fileprivate var controlEventHandlers: [UIControl.Event.RawValue: [FZUIControlClosureHandler]]? {
        get {
            if let controlEventHandlers = objc_getAssociatedObject(base, FZUIControlEventClosureAssociatedKey.associatedKeys) as? [UIControl.Event.RawValue: [FZUIControlClosureHandler]] {
                return controlEventHandlers
            }
            return nil
        }
        set {
            objc_setAssociatedObject(base, FZUIControlEventClosureAssociatedKey.associatedKeys, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

}

// MARK: private
extension FZBuildingBlockWrapper where Base: UIControl {

    /// 保存event对应的handler
    ///
    /// - Parameters:
    ///   - handler: event触发后执行的handler
    ///   - controlEvent: event
    fileprivate mutating func storeHandler(handler: FZUIControlClosureHandler, for controlEvent: UIControl.Event) {
        var controlEventHandlers: [UIControl.Event.RawValue: [FZUIControlClosureHandler]] = [:]

        // 获取已经存储的所有事件对应的处理Handlers
        if let storedEventHandlers = self.controlEventHandlers {
            controlEventHandlers.merge(storedEventHandlers) { (_, new) -> [FZUIControlClosureHandler] in
                return new
            }
        }

        // 查找当前正在添加controlEvent的已经添加的Handlers
        var eventHandlers: [FZUIControlClosureHandler] = []
        if let storedHandlers = controlEventHandlers[controlEvent.rawValue] {
            // 记录已经添加过的Handlers
            eventHandlers.append(contentsOf: storedHandlers)
        }

        // 记录正在添加的handler
        eventHandlers.append(handler)

        // 保存
        controlEventHandlers[controlEvent.rawValue] = eventHandlers
        self.controlEventHandlers = controlEventHandlers

    }

    /// 获取event对应的Handlers
    ///
    /// - Parameter event: event
    /// - Returns: handlers
    fileprivate func actionHandlers(forEvent event: UIControl.Event) -> [FZUIControlClosureHandler] {
        var controlEventHandlers: [UIControl.Event.RawValue: [FZUIControlClosureHandler]] = [:]

        // 获取已经存储的所有事件对应的处理Handlers
        if let storedEventHandlers = self.controlEventHandlers {
            controlEventHandlers.merge(storedEventHandlers) { (_, new) -> [FZUIControlClosureHandler] in
                return new
            }
        }

        // 查找当前controlEvent的已经添加的Handlers
        var eventHandlers: [FZUIControlClosureHandler] = []
        if let storedHandlers = controlEventHandlers[event.rawValue] {
            // 记录已经添加过的Handlers
            eventHandlers.append(contentsOf: storedHandlers)
        }

        return eventHandlers
    }

    /// 获取events对应的Handlers集合
    ///
    /// - Parameter events: events
    /// - Returns: handlers
    fileprivate func actionHandlers(forEvents events: [UIControl.Event]) -> [FZUIControlClosureHandler] {
        var eventHandlers: [FZUIControlClosureHandler] = []

        for event in events {
            let handlers = actionHandlers(forEvent: event)
            eventHandlers.append(contentsOf: handlers)
        }

        return eventHandlers
    }
}

// MARK: - public
extension FZBuildingBlockWrapper where Base: UIControl {

    ///
    /// support Event:
    /// - touchDown: UIControl.Event
    /// - touchDownRepeat: UIControl.Event
    /// - touchDragInside: UIControl.Event
    /// - touchDragOutside: UIControl.Event
    /// - touchDragEnter: UIControl.Event
    /// - touchDragExit: UIControl.Event
    /// - touchUpInside: UIControl.Event
    /// - touchUpOutside: UIControl.Event
    /// - touchCancel: UIControl.Event
    /// - valueChanged: UIControl.Event
    /// - primaryActionTriggered: UIControl.Event
    /// - editingDidBegin: UIControl.Event
    /// - editingChanged: UIControl.Event
    /// - editingDidEnd: UIControl.Event
    /// - editingDidEndOnExit: UIControl.Event
    /// - allTouchEvents: UIControl.Event
    /// - allEditingEvents: UIControl.Event
    /// - applicationReserved: UIControl.Event
    /// - systemReserved: UIControl.Event
    /// - allEvents: UIControl.Event
    ///
    /// - Parameters:
    ///   - closure: handler closure
    ///   - controlEvent: event
    /// - Returns: FZUIControlClosureHandler
    @discardableResult
    public mutating func addHandler(closure: @escaping FZUIControlClosureHandler.FZUIControlClosure, for controlEvent: UIControl.Event) -> FZUIControlClosureHandler {

        // create handler
        let handler = FZUIControlClosureHandler(closure: closure, sender: base, event: controlEvent)

        // add target
        base.addTarget(handler, action: #selector(handler.handle), for: controlEvent)

        // store handler
        storeHandler(handler: handler, for: controlEvent)

        return handler
    }

    /// 移除指定的FZUIControlClosureHandler
    ///
    /// - Parameter handler: FZUIControlClosureHandler to remove
    public mutating func removeHandler(handler: FZUIControlClosureHandler) {
        var controlEventHandlers: [UIControl.Event.RawValue: [FZUIControlClosureHandler]] = [:]

        if let storedEventHandlers = self.controlEventHandlers {
            controlEventHandlers.merge(storedEventHandlers) { (_, new) -> [FZUIControlClosureHandler] in
                return new
            }
        }

        // contain remove handler
        let filterHandlers = controlEventHandlers.filter { (eventhandlers: (key: UIControl.Event.RawValue, value: [FZUIControlClosureHandler])) -> Bool in
            return eventhandlers.value.contains(handler)
        }

        for filterHandler in filterHandlers {
            let event = filterHandler.key

            // remove handler
            let handlers = filterHandler.value.filter { (closureHandler: FZUIControlClosureHandler) -> Bool in
                return handler != closureHandler
            }

            controlEventHandlers[event] = handlers
        }

        self.controlEventHandlers = controlEventHandlers
    }

    /// 移除所有的event Handlers
    public mutating func removeAllHandlers() {
        if let controlEventHandlers = self.controlEventHandlers {
            let events = controlEventHandlers.keys
            for event in events {
                removeHandlers(forEvent: UIControl.Event(rawValue: event))
            }
        }
    }

    /// 移除与event相关的Handlers
    ///
    /// - Parameter event: 需要移除Handlers的event
    public mutating func removeHandlers(forEvent event: UIControl.Event) {

        var controlEventHandlers: [UIControl.Event.RawValue: [FZUIControlClosureHandler]] = [:]

        if let storedEventHandlers = self.controlEventHandlers {
            controlEventHandlers.merge(storedEventHandlers) { (_, new) -> [FZUIControlClosureHandler] in
                return new
            }
        }

        // 清空event对应的Handlers
        if let removeHandlers = controlEventHandlers[event.rawValue] {
            for handler in removeHandlers {
                base.removeTarget(handler, action: #selector(handler.handle), for: handler.event ?? event)
            }
        }

        controlEventHandlers[event.rawValue] = []

        self.controlEventHandlers = controlEventHandlers
    }

}
