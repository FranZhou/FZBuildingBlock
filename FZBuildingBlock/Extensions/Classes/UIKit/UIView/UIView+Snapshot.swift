//
//  UIView+Snapshot.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/2/16.
//

import Foundation

extension FZBuildingBlockWrapper where Base: UIView {

    /// 最普通的截图，针对一般的视图上添加视图的情况，基本都可以使用
    ///
    /// - Returns:
    public func snapshotImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)

        // IOS7及其后续版本
        if base.responds(to: #selector(UIView.drawHierarchy(in:afterScreenUpdates:))) {
            base.drawHierarchy(in: base.frame, afterScreenUpdates: true)
        } else {
            // IOS7之前的版本
            guard let context = UIGraphicsGetCurrentContext() else {
                return nil
            }
            base.layer.render(in: context)
        }

        let snapshotImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return snapshotImage
    }

}
