//
//  FZConnectedPeripheral+Service.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2020/9/3.
//

import Foundation
import CoreBluetooth

// MARK: - Service
/// Service
extension FZConnectedPeripheral {

    /**
     *  @property services
     *
     *  @discussion A list of <code>CBService</code> objects that have been discovered on the peripheral.
     */
    public var services: [CBService]? {
        get {
            return peripheral.services
        }
    }

    /**
     *  @method discoverServices:
     *
     *  @param serviceUUIDs A list of <code>CBUUID</code> objects representing the service types to be discovered. If <i>nil</i>,
     *                      all services will be discovered.
     *
     *  @discussion         Discovers available service(s) on the peripheral.
     *
     *  @see                peripheral:didDiscoverServices:
     */
    public func discoverServices(_ serviceUUIDs: [CBUUID]?) {
        peripheral.discoverServices(serviceUUIDs)
    }

    /**
     *  @method discoverIncludedServices:forService:
     *
     *  @param includedServiceUUIDs A list of <code>CBUUID</code> objects representing the included service types to be discovered. If <i>nil</i>,
     *                              all of <i>service</i>s included services will be discovered, which is considerably slower and not recommended.
     *  @param service              A GATT service.
     *
     *  @discussion                 Discovers the specified included service(s) of <i>service</i>.
     *
     *  @see                        peripheral:didDiscoverIncludedServicesForService:error:
     */
    public func discoverIncludedServices(_ includedServiceUUIDs: [CBUUID]?, for service: CBService) {
        peripheral.discoverCharacteristics(includedServiceUUIDs, for: service)
    }

}
