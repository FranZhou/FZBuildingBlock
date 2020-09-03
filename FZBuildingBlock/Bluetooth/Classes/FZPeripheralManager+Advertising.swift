//
//  FZPeripheralManager+Advertising.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2020/9/3.
//

import Foundation
import CoreBluetooth

// MARK: -
///
extension FZPeripheralManager {

    /**
     *  @property isAdvertising
     *
     *  @discussion Whether or not the peripheral is currently advertising data.
     *
     */
    public var isAdvertising: Bool {
        get {
            return peripheralManager.isAdvertising
        }
    }

    /**
     *  @method startAdvertising:
     *
     *  @discussion                 Starts advertising. Supported advertising data types are <code>CBAdvertisementDataLocalNameKey</code>
     *                              and <code>CBAdvertisementDataServiceUUIDsKey</code>.
     *                              When in the foreground, an application can utilize up to 28 bytes of space in the initial advertisement data for
     *                              any combination of the supported advertising data types. If this space is used up, there are an additional 10 bytes of
     *                              space in the scan response that can be used only for the local name. Note that these sizes do not include the 2 bytes
     *                              of header information that are required for each new data type. Any service UUIDs that do not fit in the allotted space
     *                              will be added to a special "overflow" area, and can only be discovered by an iOS device that is explicitly scanning
     *                              for them.
     *                              While an application is in the background, the local name will not be used and all service UUIDs will be placed in the
     *                              "overflow" area. However, applications that have not specified the "bluetooth-peripheral" background mode will not be able
     *                              to advertise anything while in the background.
     *
     *  @see                        peripheralManagerDidStartAdvertising:error:
     *  @seealso                    CBAdvertisementData.h
     *
     */
    public func startAdvertising() {
        peripheralManager.startAdvertising([CBAdvertisementDataLocalNameKey: localName, CBAdvertisementDataServiceUUIDsKey: uuids])
    }

    /**
     *  @method stopAdvertising
     *
     *  @discussion Stops advertising.
     *
     */
    public func stopAdvertising() {
        peripheralManager.stopAdvertising()
    }

    /// iOS App作为外设（从设备）设置广播间隙和连接间隙最大值最小值
    /**
     *  @method setDesiredConnectionLatency:forCentral:
     *
     *  @param latency  The desired connection latency.
     *  @param central  A connected central.
     *
     *  @discussion     Sets the desired connection latency for an existing connection to <i>central</i>. Connection latency changes are not guaranteed, so the
     *                  resultant latency may vary. If a desired latency is not set, the latency chosen by <i>central</i> at the time of connection establishment
     *                  will be used. Typically, it is not necessary to change the latency.
     *
     *  @see            CBPeripheralManagerConnectionLatency
     *
     */
    public func setDesiredConnectionLatency(_ latency: CBPeripheralManagerConnectionLatency, for central: CBCentral) {
        peripheralManager.setDesiredConnectionLatency(latency, for: central)
    }

}
