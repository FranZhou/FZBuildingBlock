//
//  FZCentralManager+Retrieve.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2020/9/3.
//

import Foundation
import CoreBluetooth

// MARK: - Retrieve

/// Retrieve
extension FZCentralManager {

    /**
     *  @method retrievePeripheralsWithIdentifiers:
     *
     *  @param identifiers  A list of <code>NSUUID</code> objects.
     *
     *  @discussion         Attempts to retrieve the <code>CBPeripheral</code> object(s) with the corresponding <i>identifiers</i>.
     *
     *  @return             A list of <code>CBPeripheral</code> objects.
     *
     */
    @available(iOS 7.0, *)
    public func retrievePeripherals(withIdentifiers identifiers: [UUID]) -> [CBPeripheral] {
        return centralManager.retrievePeripherals(withIdentifiers: identifiers)
    }

    /**
     *  @method retrieveConnectedPeripheralsWithServices
     *
     *  @discussion Retrieves all peripherals that are connected to the system and implement any of the services listed in <i>serviceUUIDs</i>.
     *              Note that this set can include peripherals which were connected by other applications, which will need to be connected locally
     *              via {@link connectPeripheral:options:} before they can be used.
     *
     *  @return     A list of <code>CBPeripheral</code> objects.
     *
     */
    @available(iOS 7.0, *)
    public func retrieveConnectedPeripherals(withServices serviceUUIDs: [CBUUID]) -> [CBPeripheral] {
        return centralManager.retrieveConnectedPeripherals(withServices: serviceUUIDs)
    }

}
