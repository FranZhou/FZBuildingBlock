//
//  FZButtonEvent.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2020/7/29.
//

import UIKit

class FZButtonEvent: NSObject {

    var target: AnyObject?

    var action: Selector

    var isIgnoreEvent: Bool

    init(target: AnyObject?, action: Selector, isIgnoreEvent: Bool = false) {
        self.target = target
        self.action = action
        self.isIgnoreEvent = isIgnoreEvent
        super.init()
    }

    override func isEqual(_ object: Any?) -> Bool {
        if let other = object as? FZButtonEvent {
            if let target = self.target,
                let oTarget = other.target {
                return target.isEqual(oTarget) && self.action == other.action
            } else if other.target == nil && self.target == nil {
                return self.action == other.action
            }
            return false
        }
        return false
    }

}
