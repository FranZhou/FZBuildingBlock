//
//  FZUIControlClosureHandler.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/9/16.
//

import Foundation

open class FZUIControlClosureHandler: NSObject {
    
    public typealias FZUIControlClosure = (UIControl) -> Void
    
    var closure: FZUIControlClosure?
    var event: UIControl.Event?
    weak var control: UIControl?
    
    init(closure: @escaping FZUIControlClosure, control: UIControl? = nil, event: UIControl.Event? = nil) {
        self.closure = closure
        self.control = control
    }
    
    @objc func handle() {
        if let control = self.control {
            closure?(control)
        }
    }
    
}
