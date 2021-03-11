//
//  UIDevice+Model.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2020/9/1.
//
//  https://www.theiphonewiki.com/wiki/Models#iPhone
//

import Foundation


extension FZBuildingBlockWrapper where Base: UIDevice {
    
    /// 获取设备型号
    /// - Returns: 设备型号
    public func getModelName() -> String {
        
        func getDeviceModelName(machine: String) -> String {
            var modelName = base.model
            
            switch machine {
                
                // Apple Watch
                case "Watch1,1":
                    modelName = "Apple Watch (1st generation) (38mm)"
                    
                case "Watch1,2":
                    modelName = "Apple Watch (1st generation) (42mm)"
                    
                case "Watch2,6":
                    modelName = "Apple Watch Series 1 (38mm)"
                    
                case "Watch2,7":
                    modelName = "Apple Watch Series 1 (42mm)"
                    
                case "Watch2,3":
                    modelName = "Apple Watch Series 2 (38mm)"
                    
                case "Watch2,4":
                    modelName = "Apple Watch Series 2 (42mm)"
                    
                case "Watch3,1",
                     "Watch3,3":
                    modelName = "Apple Watch Series 3 (38mm)"
                    
                case "Watch3,2",
                     "Watch3,4":
                    modelName = "Apple Watch Series 3 (42mm)"
                    
                case "Watch4,1",
                     "Watch4,3":
                    modelName = "Apple Watch Series 4 (40mm)"
                    
                case "Watch4,2",
                     "Watch4,4":
                    modelName = "Apple Watch Series 4 (44mm)"
                    
                case "Watch5,1",
                     "Watch5,3":
                    modelName = "Apple Watch Series 5 (40mm)"
                    
                case "Watch5,2",
                     "Watch5,4":
                    modelName = "Apple Watch Series 5 (44mm)"
                    
                case "Watch5,9",
                     "Watch5,11":
                    modelName = "Apple Watch SE (40mm)"
                    
                case "Watch5,10",
                     "Watch5,12":
                    modelName = "Apple Watch SE (44mm)"
                    
                case "Watch6,1",
                     "Watch6,3":
                    modelName = "Apple Watch Series 6 (40mm)"
                    
                case "Watch6,2",
                     "Watch6,4":
                    modelName = "Apple Watch Series 6 (44mm)"
                    
                    
                    
                    
                // HomePod
                case "AudioAccessory1,1",
                     "AudioAccessory1,2":
                    modelName = "HomePod"
                case "AudioAccessory5,1":
                    modelName = "HomePod mini"
                    
                    
                    
                    
                // iPad
                case "iPad1,1":
                    modelName = "iPad"
                    
                case "iPad2,1",
                     "iPad2,2",
                     "iPad2,3",
                     "iPad2,4":
                    modelName = "iPad 2"
                    
                case "iPad3,1",
                     "iPad3,2",
                     "iPad3,3":
                    modelName = "iPad (3rd generation)"
                    
                case "iPad3,4",
                     "iPad3,5",
                     "iPad3,6":
                    modelName = "iPad (4th generation)"
                    
                case "iPad6,11",
                     "iPad6,12":
                    modelName = "iPad (5th generation)"
                    
                case "iPad7,5",
                     "iPad7,6":
                    modelName = "iPad (6th generation)"
                    
                case "iPad7,11",
                     "iPad7,12":
                    modelName = "iPad (7th generation)"
                    
                case "iPad11,6",
                     "iPad11,7":
                    modelName = "iPad (8th generation)"
                         
                    
                    
                    
                    // Apple Pencil
                // identifier Unknown
                
                
                
                // Smart Keyboard
                // identifier Unknown
                
                
                
                // iPad Air
                case "iPad4,1",
                     "iPad4,2",
                     "iPad4,3":
                    modelName = "iPad Air"
                    
                case "iPad5,3",
                     "iPad5,4":
                    modelName = "iPad Air 2"
                    
                case "iPad11,3",
                     "iPad11,4":
                    modelName = "iPad Air (3rd generation)"
                    
                case "iPad13,1",
                     "iPad13,2":
                    modelName = "iPad Air (4th generation)"
                    
                    
                    
                    
                    // iPad Pro
                case "iPad6,3",
                     "iPad6,4":
                    modelName = "iPad Pro (9.7-inch)"
                    
                case "iPad6,7",
                     "iPad6,8":
                    modelName = "iPad Pro (12.9-inch)"
                    
                case "iPad7,1",
                     "iPad7,2":
                    modelName = "iPad Pro (12.9-inch) (2nd generation)"
                    
                case "iPad7,3",
                     "iPad7,4":
                    modelName = "iPad Pro (10.5-inch)"
                    
                case "iPad8,1",
                     "iPad8,2",
                     "iPad8,3",
                     "iPad8,4":
                    modelName = "iPad Pro (11-inch)"
                    
                case "iPad8,5",
                     "iPad8,6",
                     "iPad8,7",
                     "iPad8,8":
                    modelName = "iPad Pro (12.9-inch) (3rd generation)"
                    
                case "iPad8,9",
                     "iPad8,10":
                    modelName = "iPad Pro (11-inch) (2nd generation)"
                    
                case "iPad8,11",
                     "iPad8,12":
                    modelName = "iPad Pro (12.9-inch) (4th generation)"
                    
                    
                    
                    
                    // iPad mini
                case "iPad2,5",
                     "iPad2,6",
                     "iPad2,7":
                    modelName = "iPad mini"
                    
                case "iPad4,4",
                     "iPad4,5",
                     "iPad4,6":
                    modelName = "iPad mini 2"
                    
                case "iPad4,7",
                     "iPad4,8",
                     "iPad4,9":
                    modelName = "iPad mini 3"
                    
                case "iPad5,1",
                     "iPad5,2":
                    modelName = "iPad mini 4"
                    
                case "iPad11,1",
                     "iPad11,2":
                    modelName = "iPad mini (5th generation)"
                    
                    
                    
                    
                    // iPhone
                case "iPhone1,1":
                    modelName = "iPhone"
                    
                case "iPhone1,2":
                    modelName = "iPhone 3G"
                    
                case "iPhone2,1":
                    modelName = "iPhone 3GS"
                    
                case "iPhone3,1",
                     "iPhone3,2",
                     "iPhone3,3":
                    modelName = "iPhone 4"
                    
                case "iPhone4,1":
                    modelName = "iPhone 4S"
                    
                case "iPhone5,1",
                     "iPhone5,2":
                    modelName = "iPhone 5"
                    
                case "iPhone5,3",
                     "iPhone5,4":
                    modelName = "iPhone 5c"
                    
                case "iPhone6,1",
                     "iPhone6,2":
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
                    modelName = "iPhone SE (1st generation)"
                    
                case "iPhone9,1",
                     "iPhone9,3":
                    modelName = "iPhone 7"
                    
                case "iPhone9,2":
                    modelName = "iPhone 7 Plus"
                    
                case "iPhone10,1",
                     "iPhone10,4":
                    modelName = "iPhone 8"
                    
                case "iPhone10,2",
                     "iPhone10,5":
                    modelName = "iPhone 8 Plus"
                    
                case "iPhone10,3",
                     "iPhone10,6":
                    modelName = "iPhone X"
                    
                case "iPhone11,2":
                    modelName = "iPhone XS"
                    
                case "iPhone11,4",
                     "iPhone11,6":
                    modelName = "iPhone XS Max"
                    
                case "iPhone11,8":
                    modelName = "iPhone XR"
                    
                case "iPhone12,1":
                    modelName = "iPhone 11"
                    
                case "iPhone12,3":
                    modelName = "iPhone 11 Pro"
                    
                case "iPhone12,5":
                    modelName = "iPhone 11 Pro Max"
                    
                case "iPhone12,8":
                    modelName = "iPhone SE (2nd generation)"
                    
                case "iPhone13,1":
                    modelName = "iPhone 12 mini"
                    
                case "iPhone13,2":
                    modelName = "iPhone 12"
                    
                case "iPhone13,3":
                    modelName = "iPhone 12 Pro"
                    
                case "iPhone13,4":
                    modelName = "iPhone 12 Pro Max"
                    
                    
                    
                    
                    // iPod touch
                case "iPod1,1":
                    modelName = "iPod touch"
                    
                case "iPod2,1":
                    modelName = "iPod touch (2nd generation)"
                    
                case "iPod3,1":
                    modelName = "iPod touch (3rd generation)"
                    
                case "iPod4,1":
                    modelName = "iPod touch (4th generation)"
                    
                case "iPod5,1":
                    modelName = "iPod touch (5th generation)"
                    
                case "iPod7,1":
                    modelName = "iPod touch (6th generation)"
                    
                case "iPod9,1":
                    modelName = "iPod touch (7th generation)"
                    
                    
                    
                    

                    
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
