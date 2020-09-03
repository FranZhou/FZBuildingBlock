//
//  FZPeripheralManager.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2020/9/2.
//

import Foundation
import CoreBluetooth
import FZObserver
import FZWeakProxy

/**
 * 蓝牙外设模式实现类.
 */
public final class FZPeripheralManager: NSObject {

    /// 蓝牙状态
    @available(iOS 10.0, *)
    public lazy var peripheralManagerState: FZObserver<(FZWeakProxy<FZPeripheralManager>, CBManagerState)?> = FZObserver(wrappedValue: nil)

    /// 复原peripheral manager
    public lazy var peripheralManagerRestoreState: FZObserver<(FZWeakProxy<FZPeripheralManager>, [String: Any])?> = FZObserver(wrappedValue: nil)

    /// 开启广播
    public lazy var peripheralManagerStartAdvertising: FZObserver<(FZWeakProxy<FZPeripheralManager>, FZBluetoothError?)?> = FZObserver(wrappedValue: nil)

    /// 添加服务
    public lazy var peripheralManagerAddService: FZObserver<(FZWeakProxy<FZPeripheralManager>, CBService, FZBluetoothError?)?> = FZObserver(wrappedValue: nil)

    /// 订阅特征值
    public lazy var peripheralManagerSubscribeCharacteristic: FZObserver<(FZWeakProxy<FZPeripheralManager>, CBCentral, CBCharacteristic)?> = FZObserver(wrappedValue: nil)

    /// 取消订阅特征值
    public lazy var peripheralManagerUnsubscribeCharacteristic: FZObserver<(FZWeakProxy<FZPeripheralManager>, CBCentral, CBCharacteristic)?> = FZObserver(wrappedValue: nil)

    /// 响应已连接的central的读请求
    public lazy var peripheralManagerReceiveRead: FZObserver<(FZWeakProxy<FZPeripheralManager>, CBATTRequest)?> = FZObserver(wrappedValue: nil)

    /// 响应已连接的central的写请求
    public lazy var peripheralManagerReceiveWrite: FZObserver<(FZWeakProxy<FZPeripheralManager>, [CBATTRequest])?> = FZObserver(wrappedValue: nil)

    /// 重新发送数据
    public lazy var peripheralManagerIsReadyToUpdateSubscribers: FZObserver<(FZWeakProxy<FZPeripheralManager>)?> = FZObserver(wrappedValue: nil)

    /// PublishL2CAPChannel
    public lazy var peripheralManagerPublishL2CAPChannel: FZObserver<(FZWeakProxy<FZPeripheralManager>, CBL2CAPPSM, FZBluetoothError?)?> = FZObserver(wrappedValue: nil)

    /// UnpublishL2CAPChannel
    public lazy var peripheralManagerUnpublishL2CAPChannel: FZObserver<(FZWeakProxy<FZPeripheralManager>, CBL2CAPPSM, FZBluetoothError?)?> = FZObserver(wrappedValue: nil)

    /// OpenL2CAPChannel
    @available(iOS 11.0, *)
    public lazy var peripheralManagerOpenL2CAPChannel: FZObserver<(FZWeakProxy<FZPeripheralManager>, CBL2CAPChannel?, FZBluetoothError?)?> = FZObserver(wrappedValue: nil)

    // MARK: - init property

    /// CBAdvertisementDataLocalNameKey
    public let localName: String

    /// CBAdvertisementDataServiceUUIDsKey
    public let uuids: [CBUUID]

    /// 蓝牙外设设备
    public private(set) var peripheralManager: CBPeripheralManager!

    public init(localName: String, uuids: [CBUUID], queue: DispatchQueue? = nil, peripheralManager options: [String: Any]? = nil) {
        self.localName = localName
        self.uuids = uuids

        super.init()

        self.peripheralManager = CBPeripheralManager(delegate: self, queue: queue, options: options)
    }

    deinit {
        FZBluetoothConfiguration.bluetoothLog?("FZPeripheralManager deinit")
    }

}
