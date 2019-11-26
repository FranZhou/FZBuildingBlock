//
//  UIDevice+Disk.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/8/7.
//

import Foundation

extension UIDevice.fz {

    /// totalDiskSpace
    ///
    /// - Returns: Bytes of totalDiskSpace
    public static func totalDiskSpaceBytes() -> UInt64 {
        let buf: UnsafeMutablePointer<statfs> = UnsafeMutablePointer<statfs>.allocate(capacity: MemoryLayout<statfs>.size)
        defer {
            buf.deallocate()
        }
        buf.pointee = statfs()

        let diskInfoPath: UnsafePointer<Int8> = UnsafePointer<Int8>.init("/private/var")

        var totalSpace: UInt64 = 0
        if statfs(diskInfoPath, buf) >= 0 {
            totalSpace = UInt64(buf.pointee.f_bsize) * buf.pointee.f_blocks
        }

        return totalSpace
    }

    /// freeDiskSpace
    ///
    /// - Returns: Bytes of freeDiskSpace
    public static func freeDiskSpaceBytes() -> UInt64 {
        let buf: UnsafeMutablePointer<statfs> = UnsafeMutablePointer<statfs>.allocate(capacity: MemoryLayout<statfs>.size)
        defer {
            buf.deallocate()
        }
        buf.pointee = statfs()

        let diskInfoPath: UnsafePointer<Int8> = UnsafePointer<Int8>.init("/private/var")

        var freeSpace: UInt64 = 0
        if statfs(diskInfoPath, buf) >= 0 {
            freeSpace = UInt64(buf.pointee.f_bsize) * buf.pointee.f_bfree
        }

        return freeSpace
    }

}
