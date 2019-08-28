//
//  UIControl+Block.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/8/7.
//

import Foundation

fileprivate struct FZUIControlEventBlockAssociatedKey{
    static var associatedKeys: UnsafeRawPointer = UnsafeRawPointer(bitPattern: "FZUIControlEventBlockAssociatedKey_associatedKeys".hashValue)!
}

// MARK: - private action blocks
extension FZBuildingBlockWrapper where Base: UIControl{
    
    fileprivate var controlEventBlocks:[UIControl.Event.RawValue: [FZUIControlEventBlock]]?{
        get{
            if let controlEvents = objc_getAssociatedObject(base, FZUIControlEventBlockAssociatedKey.associatedKeys) as? [UIControl.Event.RawValue: [FZUIControlEventBlock]]{
                return controlEvents
            }
            return nil
        }
        set{
            objc_setAssociatedObject(base, FZUIControlEventBlockAssociatedKey.associatedKeys, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
}

// MARK: block handler
extension FZBuildingBlockWrapper where Base: UIControl{
    
    
    /// 保存event对应的block
    ///
    /// - Parameters:
    ///   - block: event触发后执行的block
    ///   - controlEvent: event
    fileprivate mutating func store(block: @escaping FZUIControlEventBlock, for controlEvent: UIControl.Event){
        var controlEventBlocks: [UIControl.Event.RawValue: [FZUIControlEventBlock]] = [:]
        
        // 获取已经存储的所有事件对应的处理block
        if let storedEventBlocks = self.controlEventBlocks{
            controlEventBlocks.merge(storedEventBlocks) { (current, new) -> [FZUIControlEventBlock] in
                return new
            }
        }
        
        // 查找当前正在添加controlEvent的已经添加的blocks
        var eventBlocks: [FZUIControlEventBlock] = []
        if let storedBlocks = controlEventBlocks[controlEvent.rawValue]{
            // 记录已经添加过的blocks
            eventBlocks.append(contentsOf: storedBlocks)
        }else{
            // 第一次添加时，添加处理事件, 在这里处理可以保证每个事件只添加一次
            addHandler(for: controlEvent)
        }
        // 记录正在添加的block
        eventBlocks.append(block)
        
        // 保存
        controlEventBlocks[controlEvent.rawValue] = eventBlocks
        self.controlEventBlocks = controlEventBlocks
        
    }
    
    
    /// 为event添加对应的事件处理
    ///
    /// - Parameter event: event
    fileprivate func addHandler(for event: UIControl.Event){
        let sharedTarget = FZUIControlTargetHandler.sharedTarget
        switch event {
        case .touchDown:
            base.addTarget(sharedTarget, action: #selector(FZUIControlTargetHandler.touchDown(control:)), for: event)
        case .touchDownRepeat:
            base.addTarget(sharedTarget, action: #selector(FZUIControlTargetHandler.touchDownRepeat(control:)), for: event)
        case .touchDragInside:
            base.addTarget(sharedTarget, action: #selector(FZUIControlTargetHandler.touchDragInside(control:)), for: event)
        case .touchDragOutside:
            base.addTarget(sharedTarget, action: #selector(FZUIControlTargetHandler.touchDragOutside(control:)), for: event)
        case .touchDragEnter:
            base.addTarget(sharedTarget, action: #selector(FZUIControlTargetHandler.touchDragEnter(control:)), for: event)
        case .touchDragExit:
            base.addTarget(sharedTarget, action: #selector(FZUIControlTargetHandler.touchDragExit(control:)), for: event)
        case .touchUpInside:
            base.addTarget(sharedTarget, action: #selector(FZUIControlTargetHandler.touchUpInside(control:)), for: event)
        case .touchUpOutside:
            base.addTarget(sharedTarget, action: #selector(FZUIControlTargetHandler.touchUpOutside(control:)), for: event)
        case .touchCancel:
            base.addTarget(sharedTarget, action: #selector(FZUIControlTargetHandler.touchCancel(control:)), for: event)
        case .valueChanged:
            base.addTarget(sharedTarget, action: #selector(FZUIControlTargetHandler.valueChanged(control:)), for: event)
        case .editingDidBegin:
            base.addTarget(sharedTarget, action: #selector(FZUIControlTargetHandler.editingDidBegin(control:)), for: event)
        case .editingChanged:
            base.addTarget(sharedTarget, action: #selector(FZUIControlTargetHandler.editingChanged(control:)), for: event)
        case .editingDidEnd:
            base.addTarget(sharedTarget, action: #selector(FZUIControlTargetHandler.editingDidEnd(control:)), for: event)
        case .editingDidEndOnExit:
            base.addTarget(sharedTarget, action: #selector(FZUIControlTargetHandler.editingDidEndOnExit(control:)), for: event)
        case .allTouchEvents:
            base.addTarget(sharedTarget, action: #selector(FZUIControlTargetHandler.allTouchEvents(control:)), for: event)
        case .allEditingEvents:
            base.addTarget(sharedTarget, action: #selector(FZUIControlTargetHandler.allEditingEvents(control:)), for: event)
        case .applicationReserved:
            base.addTarget(sharedTarget, action: #selector(FZUIControlTargetHandler.applicationReserved(control:)), for: event)
        case .systemReserved:
            base.addTarget(sharedTarget, action: #selector(FZUIControlTargetHandler.systemReserved(control:)), for: event)
        case .allEvents:
            base.addTarget(sharedTarget, action: #selector(FZUIControlTargetHandler.allEvents(control:)), for: event)
        default:
            if #available(iOS 9.0, *) {
                if event == .primaryActionTriggered{
                    base.addTarget(sharedTarget, action: #selector(FZUIControlTargetHandler.primaryActionTriggered(control:)), for: event)
                }
            } else {
                // Fallback on earlier versions
            }
            break
        }
    }
    
    /// 获取event对应的blocks
    ///
    /// - Parameter event: event
    /// - Returns: blocks
    fileprivate func actionBlocks(forEvent event: UIControl.Event) -> [FZUIControlEventBlock]{
        var controlEventBlocks: [UIControl.Event.RawValue: [FZUIControlEventBlock]] = [:]
        
        // 获取已经存储的所有事件对应的处理block
        if let storedEventBlocks = self.controlEventBlocks{
            controlEventBlocks.merge(storedEventBlocks) { (current, new) -> [FZUIControlEventBlock] in
                return new
            }
        }
        
        // 查找当前controlEvent的已经添加的blocks
        var eventBlocks: [FZUIControlEventBlock] = []
        if let storedBlocks = controlEventBlocks[event.rawValue]{
            // 记录已经添加过的blocks
            eventBlocks.append(contentsOf: storedBlocks)
        }
        
        return eventBlocks
    }
    
    
    /// 获取events对应的blocks集合
    ///
    /// - Parameter events: events
    /// - Returns: blocks集合
    fileprivate func actionBlocks(forEvents events: [UIControl.Event]) -> [FZUIControlEventBlock]{
        var eventBlocks: [FZUIControlEventBlock] = []
        
        for event in events {
            let blocks = actionBlocks(forEvent: event)
            eventBlocks.append(contentsOf: blocks)
        }
        
        return eventBlocks
    }
}

// MARK: - UIControl+Block for event
extension FZBuildingBlockWrapper where Base: UIControl{
    
    public typealias FZUIControlEventBlock = (UIControl) -> Void
    
    
    /**
     support Event:
     - touchDown: UIControl.Event
     - touchDownRepeat: UIControl.Event
     - touchDragInside: UIControl.Event
     - touchDragOutside: UIControl.Event
     - touchDragEnter: UIControl.Event
     - touchDragExit: UIControl.Event
     - touchUpInside: UIControl.Event
     - touchUpOutside: UIControl.Event
     - touchCancel: UIControl.Event
     - valueChanged: UIControl.Event
     - primaryActionTriggered: UIControl.Event
     - editingDidBegin: UIControl.Event
     - editingChanged: UIControl.Event
     - editingDidEnd: UIControl.Event
     - editingDidEndOnExit: UIControl.Event
     - allTouchEvents: UIControl.Event
     - allEditingEvents: UIControl.Event
     - applicationReserved: UIControl.Event
     - systemReserved: UIControl.Event
     - allEvents: UIControl.Event
     
     */
    public mutating func addAction(block: @escaping FZUIControlEventBlock, for controlEvent: UIControl.Event = .touchUpInside){
        store(block: block, for: controlEvent)
    }
    
    
    /// 移除所有的action block
    public mutating func removeAllAction(){
        self.controlEventBlocks = nil
    }
    
    
    /// 移除与event相关的action block
    ///
    /// - Parameter event: 需要移除action block的event
    public mutating func removeAction(forEvent event: UIControl.Event){
        
        var controlEventBlocks: [UIControl.Event.RawValue: [FZUIControlEventBlock]] = [:]
        if let storedEventBlocks = self.controlEventBlocks{
            controlEventBlocks.merge(storedEventBlocks) { (current, new) -> [FZUIControlEventBlock] in
                return new
            }
        }
        
        // 清空event对应的action block
        controlEventBlocks[event.rawValue] = []
        
        self.controlEventBlocks = controlEventBlocks
    }
    
}


// MARK: - event target SEL
@objc fileprivate class FZUIControlTargetHandler: NSObject{
    
    static let sharedTarget: FZUIControlTargetHandler = FZUIControlTargetHandler()
    
    @objc func touchDown(control: UIControl){
        for block in control.fz.actionBlocks(forEvents: [.touchDown]) {
            block(control)
        }
    }
    
    @objc func touchDownRepeat(control: UIControl){
        for block in control.fz.actionBlocks(forEvents: [.touchDownRepeat]) {
            block(control)
        }
    }
    
    @objc func touchDragInside(control: UIControl){
        for block in control.fz.actionBlocks(forEvents: [.touchDragInside]) {
            block(control)
        }
    }
    
    @objc func touchDragOutside(control: UIControl){
        for block in control.fz.actionBlocks(forEvents: [.touchDragOutside]) {
            block(control)
        }
    }
    
    @objc func touchDragEnter(control: UIControl){
        for block in control.fz.actionBlocks(forEvents: [.touchDragEnter]) {
            block(control)
        }
    }
    
    @objc func touchDragExit(control: UIControl){
        for block in control.fz.actionBlocks(forEvents: [.touchDragExit]) {
            block(control)
        }
    }
    
    @objc func touchUpInside(control: UIControl){
        for block in control.fz.actionBlocks(forEvents: [.touchUpInside]) {
            block(control)
        }
    }
    
    @objc func touchUpOutside(control: UIControl){
        for block in control.fz.actionBlocks(forEvents: [.touchUpOutside]) {
            block(control)
        }
    }
    
    @objc func touchCancel(control: UIControl){
        for block in control.fz.actionBlocks(forEvents: [.touchCancel]) {
            block(control)
        }
    }
    
    @objc func valueChanged(control: UIControl){
        for block in control.fz.actionBlocks(forEvents: [.valueChanged]) {
            block(control)
        }
    }
    
    @objc func primaryActionTriggered(control: UIControl){
        if #available(iOS 9.0, *) {
            for block in control.fz.actionBlocks(forEvents: [.primaryActionTriggered]) {
                block(control)
            }
        } else {
            
        }
    }
    
    @objc func editingDidBegin(control: UIControl){
        for block in control.fz.actionBlocks(forEvents: [.editingDidBegin]) {
            block(control)
        }
    }
    
    @objc func editingChanged(control: UIControl){
        for block in control.fz.actionBlocks(forEvents: [.editingChanged]) {
            block(control)
        }
    }
    
    @objc func editingDidEnd(control: UIControl){
        for block in control.fz.actionBlocks(forEvents: [.editingDidEnd]) {
            block(control)
        }
    }
    
    @objc func editingDidEndOnExit(control: UIControl){
        for block in control.fz.actionBlocks(forEvents: [.editingDidEndOnExit]) {
            block(control)
        }
    }
    
    @objc func allTouchEvents(control: UIControl){
        for block in control.fz.actionBlocks(forEvents: [.allTouchEvents]) {
            block(control)
        }
    }
    
    @objc func allEditingEvents(control: UIControl){
        for block in control.fz.actionBlocks(forEvents: [.allEditingEvents]) {
            block(control)
        }
    }
    
    @objc func applicationReserved(control: UIControl){
        for block in control.fz.actionBlocks(forEvents: [.applicationReserved]) {
            block(control)
        }
    }
    
    @objc func systemReserved(control: UIControl){
        for block in control.fz.actionBlocks(forEvents: [.systemReserved]) {
            block(control)
        }
    }
    
    @objc func allEvents(control: UIControl){
        for block in control.fz.actionBlocks(forEvents: [.allEvents]) {
            block(control)
        }
    }
}
