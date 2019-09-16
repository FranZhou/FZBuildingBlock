//
//  FZUIGestureRecognizerClosureHandler.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/9/16.
//

import Foundation

class FZUIGestureRecognizerClosureHandler<T: UIGestureRecognizer>: NSObject {

    var closure: ((T) -> Void)?
    weak var control: T?
    
    init(closure: @escaping (T) -> Void, control: T? = nil) {
        self.closure = closure
        self.control = control
    }
    
    @objc func handle() {
        if let control = self.control {
            closure?(control)
        }
    }
    
}
