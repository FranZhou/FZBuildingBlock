//
//  FZUIBarButtonItemClosureHandler.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/9/18.
//

import Foundation

public final class FZUIBarButtonItemClosureHandler: NSObject {

    public typealias  FZUIBarButtonItemClosure = (UIBarButtonItem) -> Void

    var closure: FZUIBarButtonItemClosure?
    weak var sender: UIBarButtonItem?

    init(closure: FZUIBarButtonItemClosure?, sender: UIBarButtonItem? = nil) {
        self.closure = closure
        self.sender = sender
    }

    @objc func handle() {
        if let sender = self.sender {
            closure?(sender)
        }
    }

}
