//
//  FZConnectedPeripheral+Descriptor.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2020/9/3.
//

import Foundation
import CoreBluetooth

// MARK: - Descriptor
/// Descriptor
extension FZConnectedPeripheral {

    /**
     *  @method discoverDescriptorsForCharacteristic:
     *
     *  @param characteristic   A GATT characteristic.
     *
     *  @discussion             Discovers the characteristic descriptor(s) of <i>characteristic</i>.
     *
     *  @see                    peripheral:didDiscoverDescriptorsForCharacteristic:error:
     */
    public func discoverDescriptors(for characteristic: CBCharacteristic) {
        peripheral.discoverDescriptors(for: characteristic)
    }

    /**
     *  @method readValueForDescriptor:
     *
     *  @param descriptor   A GATT characteristic descriptor.
     *
     *  @discussion         Reads the value of <i>descriptor</i>.
     *
     *  @see                peripheral:didUpdateValueForDescriptor:error:
     */
    public func readValue(for descriptor: CBDescriptor) {
        peripheral.readValue(for: descriptor)
    }

    /**
     *  @method writeValue:forDescriptor:
     *
     *  @param data         The value to write.
     *  @param descriptor   A GATT characteristic descriptor.
     *
     *  @discussion         Writes <i>data</i> to <i>descriptor</i>'s value. Client characteristic configuration descriptors cannot be written using
     *                      this method, and should instead use @link setNotifyValue:forCharacteristic: @/link.
     *
     *  @see                peripheral:didWriteValueForCharacteristic:error:
     */
    public func writeValue(_ data: Data, for descriptor: CBDescriptor) {
        peripheral.writeValue(data, for: descriptor)
    }

}
