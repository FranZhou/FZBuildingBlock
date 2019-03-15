//
//  Bundle+Common.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/2/14.
//

import Foundation

extension Bundle{
    
    
    /// 根据bundle名获得相应bundle
    ///
    /// - Parameter name:
    /// - Returns: 
    public class func fz_bundle(name: String) -> Bundle?{
        if name.count == 0 {
            return nil
        }
        guard let bundlePath = Bundle(for: self).path(forResource: name, ofType: "bundle") else { return nil }
        return Bundle(path: bundlePath)
    }
    
}
