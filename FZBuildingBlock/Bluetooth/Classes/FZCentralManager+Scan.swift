//
//  FZCentralManager+Scan.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2020/9/3.
//

import Foundation
import CoreBluetooth

// MARK: - Scan

/// Scan
extension FZCentralManager {

    /**
     *  @property isScanning
     *
     *  @discussion Whether or not the central is currently scanning.
     *
     */
    @available(iOS 9.0, *)
    public var isScanning: Bool {
        get {
            return centralManager.isScanning
        }
    }

    /**
     *  @method scanForPeripheralsWithServices:options:
     *
     *  @param serviceUUIDs A list of <code>CBUUID</code> objects representing the service(s) to scan for.
     *  @param options      An optional dictionary specifying options for the scan.
     *
     *  @discussion         Starts scanning for peripherals that are advertising any of the services listed in <i>serviceUUIDs</i>. Although strongly discouraged,
     *                      if <i>serviceUUIDs</i> is <i>nil</i> all discovered peripherals will be returned. If the central is already scanning with different
     *                      <i>serviceUUIDs</i> or <i>options</i>, the provided parameters will replace them.
     *                      Applications that have specified the <code>bluetooth-central</code> background mode are allowed to scan while backgrounded, with two
     *                      caveats: the scan must specify one or more service types in <i>serviceUUIDs</i>, and the <code>CBCentralManagerScanOptionAllowDuplicatesKey</code>
     *                      scan option will be ignored.
     *
     *  @see                centralManager:didDiscoverPeripheral:advertisementData:RSSI:
     *  @seealso            CBCentralManagerScanOptionAllowDuplicatesKey
     *  @seealso            CBCentralManagerScanOptionSolicitedServiceUUIDsKey
     *
     */
    public func scanForPeripherals(withServices serviceUUIDs: [CBUUID]?, options: [String: Any]? = nil) {
        centralManager.scanForPeripherals(withServices: serviceUUIDs, options: options)
    }

    /**
     *  @method stopScan:
     *
     *  @discussion Stops scanning for peripherals.
     *
     */
    public func stopScan() {
        centralManager.stopScan()
    }

}
