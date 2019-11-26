//
//  FZUIControlClosureHandler.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/9/16.
//

import Foundation

public final class FZUIControlClosureHandler: NSObject {

    public typealias FZUIControlClosure = (UIControl) -> Void

    let closure: FZUIControlClosure
    weak var sender: UIControl?
    var event: UIControl.Event?

    init(closure: @escaping FZUIControlClosure, sender: UIControl? = nil, event: UIControl.Event? = nil) {
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
