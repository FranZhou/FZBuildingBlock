//
//  Data+PNG.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/8/22.
//

import Foundation

extension FZBuildingBlockWrapper where Base == Data {

    /// PNG图片Data数据头
    public var PNGHeader: [UInt8] {
        return [0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A]
    }

    /// 当前Data是否是PNG图片
    public var isPNG: Bool {
        guard base.count > 8
            else {
                return false
        }

        let count = PNGHeader.count
        let buffer: UnsafeMutablePointer<UInt8> = UnsafeMutablePointer<UInt8>.allocate(capacity: count)
        defer {
            buffer.deallocate()
        }

        base.copyBytes(to: buffer, count: count)

        var isPNG = true
        for i in 0..<count {
            if buffer.advanced(by: i).pointee != PNGHeader[i] {
                isPNG = false
                break
            }
        }

        return isPNG
    }

}
