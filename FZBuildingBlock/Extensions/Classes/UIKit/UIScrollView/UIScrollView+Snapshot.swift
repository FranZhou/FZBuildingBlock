//
//  UIScrollView+Snapshot.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/2/16.
//

import Foundation

extension FZBuildingBlockWrapper where Base: UIScrollView {

    public func snapshotImage() -> UIImage? {
        let originFrame = base.frame
        let originContentOffset = base.contentOffset

        base.frame = CGRect(x: 0, y: 0, width: base.contentSize.width, height: base.contentSize.height)
        base.contentOffset = CGPoint.zero

        UIGraphicsBeginImageContextWithOptions(base.frame.size, false, UIScreen.main.scale)

        // IOS7及其后续版本
        if base.responds(to: #selector(UIScrollView.drawHierarchy(in:afterScreenUpdates:))) {
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

        base.frame = originFrame
        base.contentOffset = originContentOffset

        return snapshotImage
    }
}
