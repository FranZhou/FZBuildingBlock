//
//  UIButton+Block.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/8/6.
//

import Foundation

// MARK: - private
extension UIButton{
    
    fileprivate struct FZUIButtonAssociatedKeyStruct{
        static var associatedKeys: UnsafeRawPointer = UnsafeRawPointer(bitPattern: "FZUIButtonAssociatedKeyStruct_associatedKeys".hashValue)!
    }
    
    
    fileprivate var fz_controlEventBlocks:[UIControl.Event.RawValue: [FZButtonBlock]]?{
        get{
            if let controlEvents = objc_getAssociatedObject(self, FZUIButtonAssociatedKeyStruct.associatedKeys) as? [UIControl.Event.RawValue: [FZButtonBlock]]{
                return controlEvents
            }
            return nil
        }
        set{
            objc_setAssociatedObject(self, FZUIButtonAssociatedKeyStruct.associatedKeys, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
}

extension UIButton{
    
    fileprivate func fz_store(block: @escaping FZButtonBlock, for controlEvent: UIControl.Event){
        var controlEventBlocks: [UIControl.Event.RawValue: [FZButtonBlock]] = [:]
        
        // 获取已经存储的所有事件对应的处理block
        if let storedEventBlocks = fz_controlEventBlocks{
            controlEventBlocks.merge(storedEventBlocks) { (current, new) -> [UIButton.FZButtonBlock] in
                return new
            }
        }
        
        // 查找当前正在添加controlEvent的已经添加的blocks
        var eventBlocks: [FZButtonBlock] = []
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
    
    fileprivate func fz_addHandler(for event: UIControl.Event){
        switch event {
        case .touchDown:
            self.addTarget(self, action: #selector(UIButton.fz_touchDown(button:)), for: event)
        case .touchDownRepeat:
            self.addTarget(self, action: #selector(UIButton.fz_touchDownRepeat(button:)), for: event)
        case .touchDragInside:
            self.addTarget(self, action: #selector(UIButton.fz_touchDragInside(button:)), for: event)
        case .touchDragOutside:
            self.addTarget(self, action: #selector(UIButton.fz_touchDragOutside(button:)), for: event)
        case .touchDragEnter:
            self.addTarget(self, action: #selector(UIButton.fz_touchDragEnter(button:)), for: event)
        case .touchDragExit:
            self.addTarget(self, action: #selector(UIButton.fz_touchDragExit(button:)), for: event)
        case .touchUpInside:
            self.addTarget(self, action: #selector(UIButton.fz_touchUpInside(button:)), for: event)
        case .touchUpOutside:
            self.addTarget(self, action: #selector(UIButton.fz_touchUpOutside(button:)), for: event)
        case .touchCancel:
            self.addTarget(self, action: #selector(UIButton.fz_touchCancel(button:)), for: event)
        default:
            break
        }
    }
    
    fileprivate func fz_actionBlocks(forEvent event: UIControl.Event) -> [FZButtonBlock]{
        var controlEventBlocks: [UIControl.Event.RawValue: [FZButtonBlock]] = [:]
        
        // 获取已经存储的所有事件对应的处理block
        if let storedEventBlocks = fz_controlEventBlocks{
            controlEventBlocks.merge(storedEventBlocks) { (current, new) -> [UIButton.FZButtonBlock] in
                return new
            }
        }
        
        // 查找当前controlEvent的已经添加的blocks
        var eventBlocks: [FZButtonBlock] = []
        if let storedBlocks = controlEventBlocks[event.rawValue]{
            // 记录已经添加过的blocks
            eventBlocks.append(contentsOf: storedBlocks)
        }
        
        return eventBlocks
    }
}


extension UIButton{
    
    @objc fileprivate func fz_touchDown(button: UIButton){
        for block in fz_actionBlocks(forEvent: .touchDown) {
            block(button)
        }
    }
    
    @objc fileprivate func fz_touchDownRepeat(button: UIButton){
        for block in fz_actionBlocks(forEvent: .touchDownRepeat) {
            block(button)
        }
    }
    
    @objc fileprivate func fz_touchDragInside(button: UIButton){
        for block in fz_actionBlocks(forEvent: .touchDragInside) {
            block(button)
        }
    }
    
    @objc fileprivate func fz_touchDragOutside(button: UIButton){
        for block in fz_actionBlocks(forEvent: .touchDragOutside) {
            block(button)
        }
    }
    
    @objc fileprivate func fz_touchDragEnter(button: UIButton){
        for block in fz_actionBlocks(forEvent: .touchDragEnter) {
            block(button)
        }
    }
    
    @objc fileprivate func fz_touchDragExit(button: UIButton){
        for block in fz_actionBlocks(forEvent: .touchDragExit) {
            block(button)
        }
    }
    
    @objc fileprivate func fz_touchUpInside(button: UIButton){
        for block in fz_actionBlocks(forEvent: .touchUpInside) {
            block(button)
        }
    }
    
    @objc fileprivate func fz_touchUpOutside(button: UIButton){
        for block in fz_actionBlocks(forEvent: .touchUpOutside) {
            block(button)
        }
    }
    
    @objc fileprivate func fz_touchCancel(button: UIButton){
        for block in fz_actionBlocks(forEvent: .touchCancel) {
            block(button)
        }
    }
    
}

// MARK: - fz_addAction
extension UIButton{
    
    public typealias FZButtonBlock = (UIButton) -> Void
    
    
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
     
     */
    public func fz_addAction(block: @escaping FZButtonBlock, for controlEvent: UIControl.Event = .touchUpInside){
        
        switch controlEvent {
        case .touchDown,.touchDownRepeat,.touchDragInside, .touchDragOutside,.touchDragEnter,.touchDragExit,.touchUpInside,.touchUpOutside,.touchCancel:
            fz_store(block: block, for: controlEvent)
        default:
            break
        }
    }
    
    
    /// 移除所有的action block
    public func fz_removeAllAction(){
        fz_controlEventBlocks = nil
    }
    
    
    /// 移除与event相关的action block
    ///
    /// - Parameter event: 需要移除action block的event
    public func fz_removeAction(forEvent event: UIControl.Event){
        
        var controlEventBlocks: [UIControl.Event.RawValue: [FZButtonBlock]] = [:]
        if let storedEventBlocks = fz_controlEventBlocks{
            controlEventBlocks.merge(storedEventBlocks) { (current, new) -> [UIButton.FZButtonBlock] in
                return new
            }
        }
        
        // 清空event对应的action block
        controlEventBlocks[event.rawValue] = []
        
        fz_controlEventBlocks = controlEventBlocks
    }
    
}
