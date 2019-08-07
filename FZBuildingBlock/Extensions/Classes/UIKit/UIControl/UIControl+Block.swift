//
//  UIControl+Block.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/8/7.
//

import Foundation

// MARK: - private action blocks
extension UIControl{
    
    fileprivate struct FZUIControlEventBlockAssociatedKey{
        static var associatedKeys: UnsafeRawPointer = UnsafeRawPointer(bitPattern: "FZUIControlEventBlockAssociatedKey_associatedKeys".hashValue)!
    }
    
    
    fileprivate var fz_controlEventBlocks:[UIControl.Event.RawValue: [FZUIControlEventBlock]]?{
        get{
            if let controlEvents = objc_getAssociatedObject(self, FZUIControlEventBlockAssociatedKey.associatedKeys) as? [UIControl.Event.RawValue: [FZUIControlEventBlock]]{
                return controlEvents
            }
            return nil
        }
        set{
            objc_setAssociatedObject(self, FZUIControlEventBlockAssociatedKey.associatedKeys, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
}

// MARK: block handler
extension UIControl{
    
    
    /// 保存event对应的block
    ///
    /// - Parameters:
    ///   - block: event触发后执行的block
    ///   - controlEvent: event
    fileprivate func fz_store(block: @escaping FZUIControlEventBlock, for controlEvent: UIControl.Event){
        var controlEventBlocks: [UIControl.Event.RawValue: [FZUIControlEventBlock]] = [:]
        
        // 获取已经存储的所有事件对应的处理block
        if let storedEventBlocks = fz_controlEventBlocks{
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
            fz_addHandler(for: controlEvent)
        }
        // 记录正在添加的block
        eventBlocks.append(block)
        
        // 保存
        controlEventBlocks[controlEvent.rawValue] = eventBlocks
        fz_controlEventBlocks = controlEventBlocks
        
    }
    
    
    /// 为event添加对应的事件处理
    ///
    /// - Parameter event: event
    fileprivate func fz_addHandler(for event: UIControl.Event){
        switch event {
        case .touchDown:
            self.addTarget(self, action: #selector(UIControl.fz_touchDown(control:)), for: event)
        case .touchDownRepeat:
            self.addTarget(self, action: #selector(UIControl.fz_touchDownRepeat(control:)), for: event)
        case .touchDragInside:
            self.addTarget(self, action: #selector(UIControl.fz_touchDragInside(control:)), for: event)
        case .touchDragOutside:
            self.addTarget(self, action: #selector(UIControl.fz_touchDragOutside(control:)), for: event)
        case .touchDragEnter:
            self.addTarget(self, action: #selector(UIControl.fz_touchDragEnter(control:)), for: event)
        case .touchDragExit:
            self.addTarget(self, action: #selector(UIControl.fz_touchDragExit(control:)), for: event)
        case .touchUpInside:
            self.addTarget(self, action: #selector(UIControl.fz_touchUpInside(control:)), for: event)
        case .touchUpOutside:
            self.addTarget(self, action: #selector(UIControl.fz_touchUpOutside(control:)), for: event)
        case .touchCancel:
            self.addTarget(self, action: #selector(UIControl.fz_touchCancel(control:)), for: event)
        case .valueChanged:
            self.addTarget(self, action: #selector(UIControl.fz_valueChanged(control:)), for: event)
        case .editingDidBegin:
            self.addTarget(self, action: #selector(UIControl.fz_editingDidBegin(control:)), for: event)
        case .editingChanged:
            self.addTarget(self, action: #selector(UIControl.fz_editingChanged(control:)), for: event)
        case .editingDidEnd:
            self.addTarget(self, action: #selector(UIControl.fz_editingDidEnd(control:)), for: event)
        case .editingDidEndOnExit:
            self.addTarget(self, action: #selector(UIControl.fz_editingDidEndOnExit(control:)), for: event)
        case .allTouchEvents:
            self.addTarget(self, action: #selector(UIControl.fz_allTouchEvents(control:)), for: event)
        case .allEditingEvents:
            self.addTarget(self, action: #selector(UIControl.fz_allEditingEvents(control:)), for: event)
        case .applicationReserved:
            self.addTarget(self, action: #selector(UIControl.fz_applicationReserved(control:)), for: event)
        case .systemReserved:
            self.addTarget(self, action: #selector(UIControl.fz_systemReserved(control:)), for: event)
        case .allEvents:
            self.addTarget(self, action: #selector(UIControl.fz_allEvents(control:)), for: event)
        default:
            if #available(iOS 9.0, *) {
                if event == .primaryActionTriggered{
                    self.addTarget(self, action: #selector(UIControl.fz_primaryActionTriggered(control:)), for: event)
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
    fileprivate func fz_actionBlocks(forEvent event: UIControl.Event) -> [FZUIControlEventBlock]{
        var controlEventBlocks: [UIControl.Event.RawValue: [FZUIControlEventBlock]] = [:]
        
        // 获取已经存储的所有事件对应的处理block
        if let storedEventBlocks = fz_controlEventBlocks{
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
    fileprivate func fz_actionBlocks(forEvents events: [UIControl.Event]) -> [FZUIControlEventBlock]{
        var eventBlocks: [FZUIControlEventBlock] = []
        
        for event in events {
            let blocks = fz_actionBlocks(forEvent: event)
            eventBlocks.append(contentsOf: blocks)
        }
        
        return eventBlocks
    }
}

// MARK: - event target SEL
extension UIControl{
    
    @objc fileprivate func fz_touchDown(control: UIControl){
        for block in fz_actionBlocks(forEvents: [.touchDown]) {
            block(control)
        }
    }
    
    @objc fileprivate func fz_touchDownRepeat(control: UIControl){
        for block in fz_actionBlocks(forEvents: [.touchDownRepeat]) {
            block(control)
        }
    }
    
    @objc fileprivate func fz_touchDragInside(control: UIControl){
        for block in fz_actionBlocks(forEvents: [.touchDragInside]) {
            block(control)
        }
    }
    
    @objc fileprivate func fz_touchDragOutside(control: UIControl){
        for block in fz_actionBlocks(forEvents: [.touchDragOutside]) {
            block(control)
        }
    }
    
    @objc fileprivate func fz_touchDragEnter(control: UIControl){
        for block in fz_actionBlocks(forEvents: [.touchDragEnter]) {
            block(control)
        }
    }
    
    @objc fileprivate func fz_touchDragExit(control: UIControl){
        for block in fz_actionBlocks(forEvents: [.touchDragExit]) {
            block(control)
        }
    }
    
    @objc fileprivate func fz_touchUpInside(control: UIControl){
        for block in fz_actionBlocks(forEvents: [.touchUpInside]) {
            block(control)
        }
    }
    
    @objc fileprivate func fz_touchUpOutside(control: UIControl){
        for block in fz_actionBlocks(forEvents: [.touchUpOutside]) {
            block(control)
        }
    }
    
    @objc fileprivate func fz_touchCancel(control: UIControl){
        for block in fz_actionBlocks(forEvents: [.touchCancel]) {
            block(control)
        }
    }
    
    @objc fileprivate func fz_valueChanged(control: UIControl){
        for block in fz_actionBlocks(forEvents: [.valueChanged]) {
            block(control)
        }
    }
    
    @objc fileprivate func fz_primaryActionTriggered(control: UIControl){
        if #available(iOS 9.0, *) {
            for block in fz_actionBlocks(forEvents: [.primaryActionTriggered]) {
                block(control)
            }
        } else {

        }
    }
    
    @objc fileprivate func fz_editingDidBegin(control: UIControl){
        for block in fz_actionBlocks(forEvents: [.editingDidBegin]) {
            block(control)
        }
    }
    
    @objc fileprivate func fz_editingChanged(control: UIControl){
        for block in fz_actionBlocks(forEvents: [.editingChanged]) {
            block(control)
        }
    }
    
    @objc fileprivate func fz_editingDidEnd(control: UIControl){
        for block in fz_actionBlocks(forEvents: [.editingDidEnd]) {
            block(control)
        }
    }
    
    @objc fileprivate func fz_editingDidEndOnExit(control: UIControl){
        for block in fz_actionBlocks(forEvents: [.editingDidEndOnExit]) {
            block(control)
        }
    }
    
    @objc fileprivate func fz_allTouchEvents(control: UIControl){
        for block in fz_actionBlocks(forEvents: [.allTouchEvents]) {
            block(control)
        }
    }
    
    @objc fileprivate func fz_allEditingEvents(control: UIControl){
        for block in fz_actionBlocks(forEvents: [.allEditingEvents]) {
            block(control)
        }
    }
    
    @objc fileprivate func fz_applicationReserved(control: UIControl){
        for block in fz_actionBlocks(forEvents: [.applicationReserved]) {
            block(control)
        }
    }
    
    @objc fileprivate func fz_systemReserved(control: UIControl){
        for block in fz_actionBlocks(forEvents: [.systemReserved]) {
            block(control)
        }
    }
    
    @objc fileprivate func fz_allEvents(control: UIControl){
        for block in fz_actionBlocks(forEvents: [.allEvents]) {
            block(control)
        }
    }
    
}

// MARK: - UIControl+Block for event
extension UIControl{
    
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
    public func fz_addAction(block: @escaping FZUIControlEventBlock, for controlEvent: UIControl.Event = .touchUpInside){
        fz_store(block: block, for: controlEvent)
    }
    
    
    /// 移除所有的action block
    public func fz_removeAllAction(){
        fz_controlEventBlocks = nil
    }
    
    
    /// 移除与event相关的action block
    ///
    /// - Parameter event: 需要移除action block的event
    public func fz_removeAction(forEvent event: UIControl.Event){
        
        var controlEventBlocks: [UIControl.Event.RawValue: [FZUIControlEventBlock]] = [:]
        if let storedEventBlocks = fz_controlEventBlocks{
            controlEventBlocks.merge(storedEventBlocks) { (current, new) -> [FZUIControlEventBlock] in
                return new
            }
        }
        
        // 清空event对应的action block
        controlEventBlocks[event.rawValue] = []
        
        fz_controlEventBlocks = controlEventBlocks
    }
    
}
