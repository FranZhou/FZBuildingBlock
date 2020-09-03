//
//  FZCentralManager.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2020/9/2.
//

import Foundation
import CoreBluetooth
import FZObserver
import FZWeakProxy

/**
 * 蓝牙中心模式实现类.
 * 中心设备：就是用来扫描周围蓝牙硬件的设备，比如通过你手机的蓝牙来扫描并连接智能手环，这时候你的手机就是中心设备。
 */
public final class FZCentralManager: NSObject {

    /// 中心设备状态
    @available(iOS 10.0, *)
    public lazy var centralManagerState: FZObserver<(FZWeakProxy<FZCentralManager>, CBManagerState)?> = FZObserver(wrappedValue: nil)

    /// 中心设备复原状态
    public lazy var centralManagerRestoreState: FZObserver<(FZWeakProxy<FZCentralManager>, [String: Any])?> = FZObserver(wrappedValue: nil)

    /// 中心设备发现外设
    public lazy var centralManagerDiscover: FZObserver<(FZWeakProxy<FZCentralManager>, CBPeripheral, [String: Any], NSNumber)?> = FZObserver(wrappedValue: nil)

    /// 中心设备连接外设
    public lazy var centralManagerConnect: FZObserver<(FZWeakProxy<FZCentralManager>, CBPeripheral)?> = FZObserver(wrappedValue: nil)

    /// 中心设备连接失败
    public lazy var centralManagerConnectFail: FZObserver<(FZWeakProxy<FZCentralManager>, CBPeripheral, FZBluetoothError?)?> = FZObserver(wrappedValue: nil)

    /// 中心设备取消连接
    public lazy var centralManagerDisconnect: FZObserver<(FZWeakProxy<FZCentralManager>, CBPeripheral, FZBluetoothError?)?> = FZObserver(wrappedValue: nil)

    /// 中心设备连接事件触发
    public lazy var centralManagerConnectionEventOccur: FZObserver<(FZWeakProxy<FZCentralManager>, CBConnectionEvent, CBPeripheral)?> = FZObserver(wrappedValue: nil)

    /// ANCS授权状态回调
    public lazy var centralManagerANCSAuthorization: FZObserver<(FZWeakProxy<FZCentralManager>, CBPeripheral)?> = FZObserver(wrappedValue: nil)

    // MARK: - init property

    /// 蓝牙中心设备
    public private(set) var centralManager: CBCentralManager!

    public init(queue: DispatchQueue? = nil, centerManager options: [String: Any]? = nil) {
        super.init()

        self.centralManager = CBCentralManager(delegate: self, queue: queue, options: options)
    }

    deinit {
        FZBluetoothConfiguration.bluetoothLog?("FZCentralManager deinit")
    }
}

// MARK: - Class Method
// Class Method
extension FZCentralManager {

    /**
     *  @method supportsFeatures
     *
     *  @param features One or more features you would like to check if supported.
     *
     *  @discussion     Returns a boolean value representing the support for the provided features.
     *
     */
    @available(iOS 13.0, *)
    public class func supports(_ features: CBCentralManager.Feature) -> Bool {
        return CBCentralManager.supports(features)
    }

}
