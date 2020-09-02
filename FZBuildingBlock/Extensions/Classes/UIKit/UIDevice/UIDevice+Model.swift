//
//  UIDevice+Model.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2020/9/1.
//

import Foundation

extension FZBuildingBlockWrapper where Base: UIDevice {

    /// 获取设备型号
    /// - Returns: 设备型号
    public func getModelName() -> String {

        func getDeviceModelName(machine: String) -> String {
            var modelName = base.model

            switch machine {
            case "iPod1,1":
                modelName = "iPod Touch 1G"
            case "iPod2,1":
                modelName = "iPod Touch 2G"
            case "iPod3,1":
                modelName = "iPod Touch 3G"
            case "iPod4,1":
                modelName = "iPod Touch 4G"
            case "iPod5,1":
                modelName = "iPod Touch 5G"
            case "iPod6,1":
                modelName = "iPod Touch 6G"
            case "iPod7,1":
                modelName = "iPod Touch 7G"

            case "iPad1,1":
                modelName = "iPad"
            case "iPad2,1":
                modelName = "iPad 2 (WiFi)"
            case "iPad2,2":
                modelName = "iPad 2 (GSM)"
            case "iPad2,3":
                modelName = "iPad 2 (CDMA)"
            case"iPad2,4":
                modelName = "iPad 2 (WiFi)"
            case "iPad2,5":
                modelName = "iPad Mini (WiFi)"
            case "iPad2,6":
                modelName = "iPad Mini (GSM)"
            case "iPad2,7":
                modelName = "iPad Mini (CDMA)"
            case "iPad3,1":
                modelName = "iPad 3 (WiFi)"
            case "iPad3,2":
                modelName = "iPad 3 (CDMA)"
            case "iPad3,3":
                modelName = "iPad 3 (GSM)"
            case "iPad3,4":
                modelName = "iPad 4 (WiFi)"
            case "iPad3,5":
                modelName = "iPad 4 (GSM)"
            case "iPad3,6":
                modelName = "iPad 4 (CDMA)"
            case "iPad4,1":
                modelName = "iPad Air (WiFi)"
            case "iPad4,2":
                modelName = "iPad Air (GSM)"
            case "iPad4,3":
                modelName = "iPad Air (CDMA)"
            case "iPad4,4":
                modelName = "iPad Mini 2 (WiFi)"
            case "iPad4,5":
                modelName = "iPad Mini 2 (Cellular)"
            case "iPad4,6":
                modelName = "iPad Mini 2 (Cellular)"
            case "iPad4,7":
                modelName = "iPad Mini 3 (WiFi)"
            case "iPad4,8":
                modelName = "iPad Mini 3 (Cellular)"
            case "iPad4,9":
                modelName = "iPad Mini 3 (Cellular)"
            case "iPad5,1":
                modelName = "iPad Mini 4 (WiFi)"
            case "iPad5,2":
                modelName = "iPad Mini 4 (Cellular)"
            case "iPad5,3":
                modelName = "iPad Air 2 (WiFi)"
            case "iPad5,4":
                modelName = "iPad Air 2 (Cellular)"
            case "iPad6,3":
                modelName = "iPad Pro 9.7-inch (WiFi)"
            case "iPad6,4":
                modelName = "iPad Pro 9.7-inch (Cellular)"
            case "iPad6,7":
                modelName = "iPad Pro 12.9-inch (WiFi)"
            case "iPad6,8":
                modelName = "iPad Pro 12.9-inch (Cellular)"
            case "iPad6,11":
                modelName = "iPad 5 (WiFi)"
            case "iPad6,12":
                modelName = "iPad 5 (Cellular)"
            case "iPad7,1":
                modelName = "iPad Pro 12.9-inch 2 (WiFi)"
            case "iPad7,2":
                modelName = "iPad Pro 12.9-inch 2 (Cellular)"
            case "iPad7,3":
                modelName = "iPad Pro 10.5-inch (WiFi)"
            case "iPad7,4":
                modelName = "iPad Pro 10.5-inch (Cellular)"
            case "iPad7,5":
                modelName = "iPad 6 (WiFi)"
            case "iPad7,6":
                modelName = "iPad 6 (Cellular)"
            case "iPad8,1":
                modelName = "iPad Pro 11-inch (WiFi)"
            case "iPad8,2":
                modelName = "iPad Pro 11-inch (WiFi, 1TB)"
            case "iPad8,3":
                modelName = "iPad Pro 11-inch (Cellular)"
            case "iPad8,4":
                modelName = "iPad Pro 11-inch (Cellular, 1TB)"
            case "iPad8,5":
                modelName = "iPad Pro 12.9-inch 3 (WiFi)"
            case "iPad8,6":
                modelName = "iPad Pro 12.9-inch 3 (WiFi, 1TB)"
            case "iPad8,7":
                modelName = "iPad Pro 12.9-inch 3 (Cellular)"
            case "iPad8,8":
                modelName = "iPad Pro 12.9-inch 3 (Cellular, 1TB)"
            case "iPad11,1":
                modelName = "iPad Mini 5 (WiFi)"
            case "iPad11,2":
                modelName = "iPad Mini 5 (Cellular)"
            case "iPad11,3":
                modelName = "iPad Air 3 (WiFi)"
            case "iPad11,4":
                modelName = "iPad Air 3 (Cellular)"

            case "iPhone1,1":
                modelName = "iPhone 1G"
            case "iPhone1,2":
                modelName = "iPhone 3G"
            case "iPhone2,1":
                modelName = "iPhone 3GS"
            case "iPhone3,1":
                modelName = "iPhone 4 (GSM)"
            case "iPhone3,3":
                modelName = "iPhone 4 (CDMA)"
            case "iPhone4,1":
                modelName = "iPhone 4S"
            case "iPhone5,1":
                modelName = "iPhone 5 (GSM)"
            case "iPhone5,2":
                modelName = "iPhone 5 (CDMA)"
            case "iPhone5,3":
                modelName = "iPhone 5c"
            case "iPhone5,4":
                modelName = "iPhone 5c"
            case "iPhone6,1":
                modelName = "iPhone 5s"
            case "iPhone6,2":
                modelName = "iPhone 5s"
            case "iPhone7,1":
                modelName = "iPhone 6 Plus"
            case "iPhone7,2":
                modelName = "iPhone 6"
            case "iPhone8,1":
                modelName = "iPhone 6s"
            case "iPhone8,2":
                modelName = "iPhone 6s Plus"
            case "iPhone8,4":
                modelName = "iPhone SE"
            case "iPhone9,1":
                modelName = "iPhone 7"
            case "iPhone9,2":
                modelName = "iPhone 7 Plus"
            case "iPhone9,3":
                modelName = "iPhone 7"
            case "iPhone9,4":
                modelName = "iPhone 7 Plus"
            case "iPhone10,1":
                modelName = "iPhone 8"
            case "iPhone10,2":
                modelName = "iPhone 8 Plus"
            case "iPhone10,3":
                modelName = "iPhone X"
            case "iPhone10,4":
                modelName = "iPhone 8"
            case "iPhone10,5":
                modelName = "iPhone 8 Plus"
            case "iPhone10,6":
                modelName = "iPhone X"
            case "iPhone11,2":
                modelName = "iPhone XS"
            case "iPhone11,4":
                modelName = "iPhone XS Max"
            case "iPhone11,6":
                modelName = "iPhone XS Max"
            case "iPhone11,8":
                modelName = "iPhone XR"
            case "iPhone12,1":
                modelName = "iPhone 11"
            case "iPhone12,3":
                modelName = "iPhone 11 Pro"
            case "iPhone12,5":
                modelName = "iPhone 11 Pro Max"

            case "i386":
                modelName = base.model + "(i386)"
            case "x86_64":
                modelName = base.model + "(x86_64)"

            default:
                modelName = base.model
            }
            return modelName
        }

        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let machine = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }

        return getDeviceModelName(machine: machine)
    }

}
