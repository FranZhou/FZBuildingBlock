//
//  Data+JPEG.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/8/22.
//

import Foundation

extension Data{
    
    /// JPEG图片Data数据头
    public var fz_JPEGHeaderSOI: [UInt8]{
        return [0xFF, 0xD8]
    }
    
    public var fz_JPEGHeaderIF: [UInt8]{
        return [0xFF]
    }
    
    
    /// 当前Data是否是JPEG图片
    public var fz_isJPEG: Bool{
        guard self.count > 8
            else {
                return false
        }
        
        let count = fz_JPEGHeaderSOI.count + fz_JPEGHeaderIF.count
        let buffer: UnsafeMutablePointer<UInt8> = UnsafeMutablePointer<UInt8>.allocate(capacity: count)
        defer {
            buffer.deallocate()
        }
        
        self.copyBytes(to: buffer, count: count)
        
        var isJPEG = true
        
        if buffer.advanced(by: 0).pointee != fz_JPEGHeaderSOI[0],
            buffer.advanced(by: 1).pointee != fz_JPEGHeaderSOI[1],
            buffer.advanced(by: 2).pointee != fz_JPEGHeaderIF[0]{
            isJPEG = false
        }
        
        return isJPEG
    }
    
}
