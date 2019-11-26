//
//  Data+GIF.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/8/21.
//

import Foundation

extension FZBuildingBlockWrapper where Base == Data {

    /// GIF图片Data数据头
    public var GIFHeader: [UInt8] {
        return [0x47, 0x49, 0x46]
    }

    /// 当前Data是否是GIF图片
    public var isGIF: Bool {
        guard base.count > 8
            else {
                return false
        }

        let count = GIFHeader.count
        let buffer: UnsafeMutablePointer<UInt8> = UnsafeMutablePointer<UInt8>.allocate(capacity: count)
        defer {
            buffer.deallocate()
        }

        base.copyBytes(to: buffer, count: count)

        var isGIF = true
        for i in 0..<count {
            if buffer.advanced(by: i).pointee != GIFHeader[i] {
                isGIF = false
                break
            }
        }

        return isGIF
    }

}
