//
//  FZUIGestureRecognizerClosureHandler.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/9/16.
//

import Foundation

public final class FZUIGestureRecognizerClosureHandler<T: UIGestureRecognizer>: NSObject {

    let closure: ((T) -> Void)
    weak var sender: T?

    init(closure: @escaping ((T) -> Void), sender: T? = nil) {
        self.closure = closure
        self.sender = sender
    }

    @objc func handle() {
        if let sender = self.sender {
            closure(sender)
        }
    }

}
