//
//  UIView+Snapshot.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/2/16.
//

import Foundation


extension UIView {
    
    
    /// 最普通的截图，针对一般的视图上添加视图的情况，基本都可以使用
    ///
    /// - Returns:
    @objc public func fz_normalSnapshotImage() -> UIImage?{
        UIGraphicsBeginImageContextWithOptions(self.fz_size, false, UIScreen.main.scale)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        self.layer.render(in: context)
        let snapshotImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return snapshotImage
    }
    
    
    /// 针对openGL渲染出来的视图
    ///
    /// - Returns:
    @objc public func fz_openGLSnapshotImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.fz_size, false, UIScreen.main.scale)
        self.drawHierarchy(in: self.frame, afterScreenUpdates: true)
        let snapshotImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return snapshotImage
    }
    
}
