//
//  Bundle+Find.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/2/14.
//

import Foundation

extension Bundle.fz {

    /// 根据bundle名获得相应bundle
    ///
    /// - Parameters:
    ///   - classInBundle: bundle所在module中的一个关联的class
    ///   - name: bundle name
    /// - Returns:
    public static func bundle(classInBundle: AnyClass, name: String) -> Bundle? {
        if name.count == 0 {
            return nil
        }
        guard let bundlePath = Bundle(for: classInBundle).path(forResource: name, ofType: "bundle") else { return nil }
        return Bundle(path: bundlePath)
    }

}
