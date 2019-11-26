//
//  NSAttributedString+Range.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/8/28.
//

import Foundation

extension FZBuildingBlockWrapper where Base: NSAttributedString {

    public var range: NSRange {
        return NSRange(location: 0, length: base.length)
    }

}
