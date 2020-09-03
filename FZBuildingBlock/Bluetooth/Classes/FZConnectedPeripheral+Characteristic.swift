//
//  FZConnectedPeripheral+Characteristic.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2020/9/3.
//

import Foundation
import CoreBluetooth

// MARK: - Characteristic
/// Characteristic
extension FZConnectedPeripheral {

    /**
     *  @method discoverCharacteristics:forService:
     *
     *  @param characteristicUUIDs  A list of <code>CBUUID</code> objects representing the characteristic types to be discovered. If <i>nil</i>,
     *                              all characteristics of <i>service</i> will be discovered.
     *  @param service              A GATT service.
     *
     *  @discussion                 Discovers the specified characteristic(s) of <i>service</i>.
     *
     *  @see                        peripheral:didDiscoverCharacteristicsForService:error:
     */
    public func discoverCharacteristics(_ characteristicUUIDs: [CBUUID]?, for service: CBService) {
        peripheral.discoverCharacteristics(characteristicUUIDs, for: service)
    }

    /**
     *  @method readValueForCharacteristic:
     *
     *  @param characteristic   A GATT characteristic.
     *
     *  @discussion             Reads the characteristic value for <i>characteristic</i>.
     *
     *  @see                    peripheral:didUpdateValueForCharacteristic:error:
     */
    public func readValue(for characteristic: CBCharacteristic) {
        peripheral.readValue(for: characteristic)
    }

    /**
     *  @method     maximumWriteValueLengthForType:
     *
     *  @discussion The maximum amount of data, in bytes, that can be sent to a characteristic in a single write type.
     *
     *  @see        writeValue:forCharacteristic:type:
     */
    @available(iOS 9.0, *)
    public func maximumWriteValueLength(for type: CBCharacteristicWriteType) -> Int {
        return peripheral.maximumWriteValueLength(for: type)
    }

    /**
     *  @method writeValue:forCharacteristic:type:
     *
     *  @param data             The value to write.
     *  @param characteristic   The characteristic whose characteristic value will be written.
     *  @param type             The type of write to be executed.
     *
     *  @discussion             Writes <i>value</i> to <i>characteristic</i>'s characteristic value.
     *                          If the <code>CBCharacteristicWriteWithResponse</code> type is specified, {@link peripheral:didWriteValueForCharacteristic:error:}
     *                          is called with the result of the write request.
     *                          If the <code>CBCharacteristicWriteWithoutResponse</code> type is specified, and canSendWriteWithoutResponse is false, the delivery
     *                          of the data is best-effort and may not be guaranteed.
     *
     *  @see                    peripheral:didWriteValueForCharacteristic:error:
     *  @see                    peripheralIsReadyToSendWriteWithoutResponse:
     *  @see                    canSendWriteWithoutResponse
     *  @see                    CBCharacteristicWriteType
     */
    public func writeValue(_ data: Data, for characteristic: CBCharacteristic, type: CBCharacteristicWriteType) {
        peripheral.writeValue(data, for: characteristic, type: type)
    }

    /**
     *  @method setNotifyValue:forCharacteristic:
     *
     *  @param enabled          Whether or not notifications/indications should be enabled.
     *  @param characteristic   The characteristic containing the client characteristic configuration descriptor.
     *
     *  @discussion             Enables or disables notifications/indications for the characteristic value of <i>characteristic</i>. If <i>characteristic</i>
     *                          allows both, notifications will be used.
     *                          When notifications/indications are enabled, updates to the characteristic value will be received via delegate method
     *                          @link peripheral:didUpdateValueForCharacteristic:error: @/link. Since it is the peripheral that chooses when to send an update,
     *                          the application should be prepared to handle them as long as notifications/indications remain enabled.
     *
     *  @see                    peripheral:didUpdateNotificationStateForCharacteristic:error:
     *  @seealso                CBConnectPeripheralOptionNotifyOnNotificationKey
     */
    public func setNotifyValue(_ enabled: Bool, for characteristic: CBCharacteristic) {
        peripheral.setNotifyValue(enabled, for: characteristic)
    }

}
