//
//  FZUIControlClosureHandler.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/9/16.
//

import Foundation

public final class FZUIControlClosureHandler<T: UIControl>: NSObject {

    public typealias FZUIControlClosure = (T) -> Void

    let closure: FZUIControlClosure
    weak var sender: T?
    var event: UIControl.Event

    init(closure: @escaping FZUIControlClosure, sender: T? = nil, event: UIControl.Event) {
        self.closure = closure
        self.sender = sender
        self.event = event
    }

    @objc func handle() {
        if let sender = self.sender {
            closure(sender)
        }
    }

}
