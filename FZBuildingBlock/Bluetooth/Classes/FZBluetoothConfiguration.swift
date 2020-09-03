//
//  FZBluetoothConfiguration.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2020/9/2.
//

import Foundation
import CoreBluetooth

public struct FZBluetoothConfiguration {

    /// 蓝牙状态
    @available(iOS 10.0, *)
    public static var bluetoothState: ((CBManagerState) -> Void)?

    /// 日志打印
    public static var bluetoothLog: ((_ items: Any...) -> Void)?
}
