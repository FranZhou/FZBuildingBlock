//
//  Data+JPEG.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/8/22.
//

import Foundation

extension FZBuildingBlockWrapper where Base == Data {

    /// JPEG图片Data数据头
    public var JPEGHeaderSOI: [UInt8] {
        return [0xFF, 0xD8]
    }

    public var JPEGHeaderIF: [UInt8] {
        return [0xFF]
    }

    /// 当前Data是否是JPEG图片
    public var isJPEG: Bool {
        guard base.count > 8
            else {
                return false
        }

        let count = JPEGHeaderSOI.count + JPEGHeaderIF.count
        let buffer: UnsafeMutablePointer<UInt8> = UnsafeMutablePointer<UInt8>.allocate(capacity: count)
        defer {
            buffer.deallocate()
        }

        base.copyBytes(to: buffer, count: count)

        var isJPEG = true

        if buffer.advanced(by: 0).pointee != JPEGHeaderSOI[0],
            buffer.advanced(by: 1).pointee != JPEGHeaderSOI[1],
            buffer.advanced(by: 2).pointee != JPEGHeaderIF[0] {
            isJPEG = false
        }

        return isJPEG
    }

}
