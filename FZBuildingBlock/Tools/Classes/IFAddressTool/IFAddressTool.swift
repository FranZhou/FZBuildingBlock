//
//  IPAddressTool.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/2/23.
//

import Foundation

public struct IFAddressTool {

    /**
    As it turned out in the discussion, OP needs the interface address on a Mac and not on an iOS device as I thought initially. The code referenced in the question checks for the interface name "en0", which is the WiFi interface on the iPhone. On a Mac it makes more sense to check for any "up-and-running" interface instead. Therefore I have rewritten the answer. It is now a Swift translation of the code in Detect any connected network.
    
    getifaddrs() is defined in <ifaddrs.h>, which is not included by default. Therefore you have to create a bridging header and add
    
    #include <ifaddrs.h>
    The following function returns an array with the names of all local "up-and-running" network interfaces.
    */

    /// 获取
    ///
    /// - Parameters:
    ///   - ifaName: ifa_name
    ///   - checkIPv4Andv6: default = true, 只获取IPv4/IPv6地址
    /// - Returns:
    public static func getIFAddresses(ifaName: String? = nil, checkIPv4AndV6: Bool = true) -> [(ifaName: String, address: String)] {
        var addresses =  [(ifaName: String, address: String)]()

        // Get list of all interfaces on the local machine:
        var ifaddr: UnsafeMutablePointer<ifaddrs>?

        guard getifaddrs(&ifaddr) == 0 else { return [] }
        guard let firstAddr = ifaddr else { return [] }

        // For each interface ...
        for ptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
            let flags = Int32(ptr.pointee.ifa_flags)
            let addr = ptr.pointee.ifa_addr.pointee

            // Check for running IPv4, IPv6 interfaces. Skip the loopback interface.
            if (flags & (IFF_UP|IFF_RUNNING|IFF_LOOPBACK)) == (IFF_UP|IFF_RUNNING) {
                if !checkIPv4AndV6 || (addr.sa_family == UInt8(AF_INET) || addr.sa_family == UInt8(AF_INET6)) {

                    // Convert interface address to a human readable string:
                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    if (getnameinfo(ptr.pointee.ifa_addr, socklen_t(addr.sa_len), &hostname, socklen_t(hostname.count),
                                    nil, socklen_t(0), NI_NUMERICHOST) == 0) {
                        let name = String(validatingUTF8: ptr.pointee.ifa_name) ?? ""
                        let address = String(cString: hostname)
                        addresses.append((ifaName: name, address: address))
                    }
                }
            }
        }

        freeifaddrs(ifaddr)

        if let ifaName = ifaName {
            addresses = addresses.filter { (addressInfo: (ifaName: String, address: String)) -> Bool in
                return addressInfo.ifaName == ifaName
            }
        }

        return addresses
    }

}
