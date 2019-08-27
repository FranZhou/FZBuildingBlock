//
//  UIScrollView+Snapshot.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/2/16.
//

import Foundation

extension UIScrollView {
    
    public override func fz_snapshotImage() -> UIImage? {
        let originFrame = self.frame
        let originContentOffset = self.contentOffset
        
        self.frame = CGRect(x: 0, y: 0, width: self.contentSize.width, height: self.contentSize.height)
        self.contentOffset = CGPoint.zero
        
        UIGraphicsBeginImageContextWithOptions(self.frame.size, false, UIScreen.main.scale)
        
        // IOS7及其后续版本
        if self.responds(to: #selector(drawHierarchy(in:afterScreenUpdates:))){
            self.drawHierarchy(in: self.frame, afterScreenUpdates: true)
        }else{
            // IOS7之前的版本
            guard let context = UIGraphicsGetCurrentContext() else {
                return nil
            }
            self.layer.render(in: context)
        }
        
        let snapshotImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.frame = originFrame
        self.contentOffset = originContentOffset
        
        return snapshotImage
    }
}
