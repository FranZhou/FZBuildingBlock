//
//  FZConnectedPeripheral+RSSI.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2020/9/3.
//

import Foundation
import CoreBluetooth

extension FZConnectedPeripheral {

    /**
     *  @method readRSSI
     *
     *  @discussion While connected, retrieves the current RSSI of the link.
     *
     *  @see        peripheral:didReadRSSI:error:
     */
    public func readRSSI() {
        peripheral.readRSSI()
    }

    /**
     *  @property RSSI
     *
     *  @discussion The most recently read RSSI, in decibels.
     *
     *  @deprecated Use {@link peripheral:didReadRSSI:error:} instead.
     */
    @available(iOS, introduced: 5.0, deprecated: 8.0)
    public var rssi: NSNumber? {
        get {
            return peripheral.rssi
        }
    }

}
