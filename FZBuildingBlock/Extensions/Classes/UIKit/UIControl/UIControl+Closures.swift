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

    fileprivate var controlEventHandlers: [UIControl.Event.RawValue: [FZUIControlClosureHandler<Base>]]? {
        get {
            if let controlEventHandlers = objc_getAssociatedObject(base, FZUIControlEventClosureAssociatedKey.associatedKeys) as? [UIControl.Event.RawValue: [FZUIControlClosureHandler<Base>]] {
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
    fileprivate func store(handler: FZUIControlClosureHandler<Base>, for controlEvent: UIControl.Event) {
        var controlEventHandlers: [UIControl.Event.RawValue: [FZUIControlClosureHandler<Base>]] = [:]

        // 获取已经存储的所有事件对应的处理Handlers
        if let storedEventHandlers = self.controlEventHandlers {
            controlEventHandlers.merge(storedEventHandlers) { (_, new) -> [FZUIControlClosureHandler<Base>] in
                return new
            }
        }

        // 查找当前正在添加controlEvent的已经添加的Handlers
        var eventHandlers: [FZUIControlClosureHandler<Base>] = []
        if let storedHandlers = controlEventHandlers[controlEvent.rawValue] {
            // 记录已经添加过的Handlers
            eventHandlers.append(contentsOf: storedHandlers)
        }

        // 记录正在添加的handler
        eventHandlers.append(handler)

        // 保存
        controlEventHandlers[controlEvent.rawValue] = eventHandlers
        base.fz.controlEventHandlers = controlEventHandlers

    }

    /// 获取event对应的Handlers
    ///
    /// - Parameter event: event
    /// - Returns: handlers
    fileprivate func actionHandlers(forEvent event: UIControl.Event) -> [FZUIControlClosureHandler<Base>] {
        var controlEventHandlers: [UIControl.Event.RawValue: [FZUIControlClosureHandler<Base>]] = [:]

        // 获取已经存储的所有事件对应的处理Handlers
        if let storedEventHandlers = self.controlEventHandlers {
            controlEventHandlers.merge(storedEventHandlers) { (_, new) -> [FZUIControlClosureHandler<Base>] in
                return new
            }
        }

        // 查找当前controlEvent的已经添加的Handlers
        var eventHandlers: [FZUIControlClosureHandler<Base>] = []
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
    fileprivate func actionHandlers(forEvents events: [UIControl.Event]) -> [FZUIControlClosureHandler<Base>] {
        var eventHandlers: [FZUIControlClosureHandler<Base>] = []

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
    ///   - event: event
    ///   - closure: handler closure
    /// - Returns: FZUIControlClosureHandler
    @discardableResult
    public func add(event: UIControl.Event, withClosure closure: @escaping FZUIControlClosureHandler<Base>.FZUIControlClosure) -> FZUIControlClosureHandler<Base> {

        // create handler
        let handler = FZUIControlClosureHandler(closure: closure, sender: base, event: event)

        // add target
        base.addTarget(handler, action: #selector(handler.handle), for: event)

        // store handler
        store(handler: handler, for: event)

        return handler
    }

    /// 移除指定的FZUIControlClosureHandler
    ///
    /// - Parameter handler: FZUIControlClosureHandler to remove
    public func remove(handler: FZUIControlClosureHandler<Base>) {
        var controlEventHandlers: [UIControl.Event.RawValue: [FZUIControlClosureHandler<Base>]] = [:]

        if let storedEventHandlers = self.controlEventHandlers {
            controlEventHandlers.merge(storedEventHandlers) { (_, new) -> [FZUIControlClosureHandler<Base>] in
                return new
            }
        }

        // contain remove handler
        let filterHandlers = controlEventHandlers.filter { (eventhandlers: (key: UIControl.Event.RawValue, value: [FZUIControlClosureHandler<Base>])) -> Bool in
            return eventhandlers.value.contains(handler)
        }

        for filterHandler in filterHandlers {
            let event = filterHandler.key

            // remove handler
            let handlers = filterHandler.value.filter { (closureHandler: FZUIControlClosureHandler<Base>) -> Bool in
                return handler != closureHandler
            }

            controlEventHandlers[event] = handlers
        }

        base.fz.controlEventHandlers = controlEventHandlers
    }

    /// 移除所有的event Handlers
    public func removeAllHandlers() {
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
    public func removeHandlers(forEvent event: UIControl.Event) {

        var controlEventHandlers: [UIControl.Event.RawValue: [FZUIControlClosureHandler<Base>]] = [:]

        if let storedEventHandlers = self.controlEventHandlers {
            controlEventHandlers.merge(storedEventHandlers) { (_, new) -> [FZUIControlClosureHandler<Base>] in
                return new
            }
        }

        // 清空event对应的Handlers
        if let removeHandlers = controlEventHandlers[event.rawValue] {
            for handler in removeHandlers {
                base.removeTarget(handler, action: #selector(handler.handle), for: handler.event)
            }
        }

        controlEventHandlers[event.rawValue] = []

        base.fz.controlEventHandlers = controlEventHandlers
    }

}
