//
//  FZConnectedPeripheral.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2020/9/3.
//

import Foundation
import CoreBluetooth
import FZObserver
import FZWeakProxy

/**
 * 外设：被扫描的设备。比如当你用手机的蓝牙扫描连接智能手环的时候，智能手环就是外设。
 */
public final class FZConnectedPeripheral: NSObject {

    /// 设备的名称改变
    public lazy var peripheralUpdateName: FZObserver<FZWeakProxy<FZConnectedPeripheral>?> = FZObserver(wrappedValue: nil)

    /// 设备的服务改变
    public lazy var peripheralModifyServices: FZObserver<(FZWeakProxy<FZConnectedPeripheral>, [CBService])?> = FZObserver(wrappedValue: nil)

    /// 设备的RSSI改变
    public lazy var peripheralUpdateRSSI: FZObserver<(FZWeakProxy<FZConnectedPeripheral>, FZBluetoothError?)?> = FZObserver(wrappedValue: nil)

    /// readRSSI
    public lazy var peripheralReadRSSI: FZObserver<(FZWeakProxy<FZConnectedPeripheral>, NSNumber, FZBluetoothError?)?> = FZObserver(wrappedValue: nil)

    /// discoverServices
    public lazy var peripheralDiscoverServices: FZObserver<(FZWeakProxy<FZConnectedPeripheral>, FZBluetoothError?)?> = FZObserver(wrappedValue: nil)

    /// discoverIncludedServices
    public lazy var peripheralDiscoverIncludedServices: FZObserver<(FZWeakProxy<FZConnectedPeripheral>, CBService, FZBluetoothError?)?> = FZObserver(wrappedValue: nil)

    /// didDiscoverCharacteristicsForService
    public lazy var peripheralDiscoverCharacteristicsForService: FZObserver<(FZWeakProxy<FZConnectedPeripheral>, CBService, FZBluetoothError?)?> = FZObserver(wrappedValue: nil)

    /// didUpdateValueForCharacteristic
    public lazy var peripheralUpdateValueForCharacteristic: FZObserver<(FZWeakProxy<FZConnectedPeripheral>, CBCharacteristic, FZBluetoothError?)?> = FZObserver(wrappedValue: nil)

    /// didWriteValueForCharacteristic
    public lazy var peripheralWriteValueForCharacteristic: FZObserver<(FZWeakProxy<FZConnectedPeripheral>, CBCharacteristic, FZBluetoothError?)?> = FZObserver(wrappedValue: nil)

    /// didUpdateNotificationStateForCharacteristic
    public lazy var peripheralUpdateNotificationState: FZObserver<(FZWeakProxy<FZConnectedPeripheral>, CBCharacteristic, FZBluetoothError?)?> = FZObserver(wrappedValue: nil)

    /// didDiscoverDescriptorsForCharacteristic
    public lazy var peripheralDiscoverDescriptors: FZObserver<(FZWeakProxy<FZConnectedPeripheral>, CBCharacteristic, FZBluetoothError?)?> = FZObserver(wrappedValue: nil)

    /// didUpdateValueForDescriptor
    public lazy var peripheralUpdateValueForDscriptor: FZObserver<(FZWeakProxy<FZConnectedPeripheral>, CBDescriptor, FZBluetoothError?)?> = FZObserver(wrappedValue: nil)

    /// didWriteValueForDescriptor
    public lazy var peripheralWriteValueForDescriptor: FZObserver<(FZWeakProxy<FZConnectedPeripheral>, CBDescriptor, FZBluetoothError?)?> = FZObserver(wrappedValue: nil)

    /// peripheralIsReadyToSendWriteWithoutResponse
    public lazy var peripheralIsReadyToSendWriteWithoutResponse: FZObserver<FZWeakProxy<FZConnectedPeripheral>?> = FZObserver(wrappedValue: nil)

    /// didOpenL2CAPChannel
    @available(iOS 11.0, *)
    public lazy var peripheralOpenL2CAPChannel: FZObserver<(FZWeakProxy<FZConnectedPeripheral>, CBL2CAPChannel?, FZBluetoothError?)?> = FZObserver(wrappedValue: nil)

    // MARK: - Init Property
    public let peripheral: CBPeripheral

    public init(peripheral: CBPeripheral) {
        self.peripheral = peripheral
        super.init()

        self.peripheral.delegate = self
    }

    deinit {
        FZBluetoothConfiguration.bluetoothLog?("FZConnectedPeripheral deinit")
    }
}

// MARK: - Normal
/// Normal
extension FZConnectedPeripheral {

    /**
     *  @property name
     *
     *  @discussion The name of the peripheral.
     */
    public var name: String? {
        get {
            return peripheral.name
        }
    }

    /**
     *  @property state
     *
     *  @discussion The current connection state of the peripheral.
     */
    public var state: CBPeripheralState {
        get {
            return peripheral.state
        }
    }

    /**
     *  @property canSendWriteWithoutResponse
     *
     *  @discussion YES if the remote device has space to send a write without response. If this value is NO,
     *              the value will be set to YES after the current writes have been flushed, and
     *              <link>peripheralIsReadyToSendWriteWithoutResponse:</link> will be called.
     */
    @available(iOS 11.0, *)
    public var canSendWriteWithoutResponse: Bool {
        get {
            return peripheral.canSendWriteWithoutResponse
        }
    }

    /**
     *  @property ancsAuthorized
     *
     *  @discussion YES if the remote device has been authorized to receive data over ANCS (Apple Notification Service Center) protocol.  If this value is NO,
     *                the value will be set to YES after a user authorization occurs and
     *                <link>didUpdateANCSAuthorizationForPeripheral:</link> will be called.
     */
    @available(iOS 13.0, *)
    public var ancsAuthorized: Bool {
        get {
            return peripheral.ancsAuthorized
        }
    }

}
