//
//  UIView+BorderLine.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/2/25.
//

import Foundation


public enum UIViewBorderSideType {
    static let top = 1 << 0
    static let left = 1 << 1
    static let bottom = 1 << 2
    static let right = 1 << 3
    
    static let all = top | left | bottom | right
}

extension UIView {
    
    
    public func ddd() {
        self.layer
    }
    
}
