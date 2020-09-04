//
//  FZAssociationWeakValueBox.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2020/9/4.
//

import Foundation

final class FZAssociationWeakValueBox {
    private(set) weak var value: AnyObject?

    init(_ value: AnyObject?) {
        self.value = value
    }
}
