//
//  Data+GIF.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/8/21.
//

import Foundation


extension Data{
    
    /// GIF图片Data数据头
    public var fz_GIFHeader: [UInt8]{
        return [0x47, 0x49, 0x46]
    }
    
    
    /// 当前Data是否是GIF图片
    public var fz_isGIF: Bool{
        guard self.count > 8
            else {
                return false
        }
        
        let count = fz_GIFHeader.count
        let buffer: UnsafeMutablePointer<UInt8> = UnsafeMutablePointer<UInt8>.allocate(capacity: count)
        defer {
            buffer.deallocate()
        }
        
        self.copyBytes(to: buffer, count: count)
        
        var isGIF = true
        for i in 0..<count {
            if buffer.advanced(by: i).pointee != fz_GIFHeader[i]{
                isGIF = false
                break
            }
        }
        
        return isGIF
    }
    
}
