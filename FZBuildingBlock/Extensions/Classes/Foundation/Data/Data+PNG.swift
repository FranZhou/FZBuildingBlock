//
//  Data+PNG.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/8/22.
//

import Foundation

extension Data{
    
    /// PNG图片Data数据头
    public var fz_PNGHeader: [UInt8]{
        return [0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A]
    }
    
    
    /// 当前Data是否是PNG图片
    public var fz_isPNG: Bool{
        guard self.count > 8
            else {
                return false
        }
        
        let count = fz_PNGHeader.count
        let buffer: UnsafeMutablePointer<UInt8> = UnsafeMutablePointer<UInt8>.allocate(capacity: count)
        defer {
            buffer.deallocate()
        }
        
        self.copyBytes(to: buffer, count: count)
        
        var isPNG = true
        for i in 0..<count {
            if buffer.advanced(by: i).pointee != fz_PNGHeader[i]{
                isPNG = false
                break
            }
        }
        
        return isPNG
    }
    
}
