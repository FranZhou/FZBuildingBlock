//
//  FZCentralManager+Connect.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2020/9/3.
//

import Foundation
import CoreBluetooth

// MARK: - Connect

/// Connect
extension FZCentralManager {

    /**
     *  @method connectPeripheral:options:
     *
     *  @param peripheral   The <code>CBPeripheral</code> to be connected.
     *  @param options      An optional dictionary specifying connection behavior options.
     *
     *  @discussion         Initiates a connection to <i>peripheral</i>. Connection attempts never time out and, depending on the outcome, will result
     *                      in a call to either {@link centralManager:didConnectPeripheral:} or {@link centralManager:didFailToConnectPeripheral:error:}.
     *                      Pending attempts are cancelled automatically upon deallocation of <i>peripheral</i>, and explicitly via {@link cancelPeripheralConnection}.
     *
     *  @see                centralManager:didConnectPeripheral:
     *  @see                centralManager:didFailToConnectPeripheral:error:
     *  @seealso            CBConnectPeripheralOptionNotifyOnConnectionKey
     *  @seealso            CBConnectPeripheralOptionNotifyOnDisconnectionKey
     *  @seealso            CBConnectPeripheralOptionNotifyOnNotificationKey
     *  @seealso            CBConnectPeripheralOptionEnableTransportBridgingKey
     *  @seealso            CBConnectPeripheralOptionRequiresANCS
     *
     */
    public func connect(_ peripheral: CBPeripheral, options: [String: Any]? = nil) {
        centralManager.connect(peripheral, options: options)
    }

    /**
     *  @method cancelPeripheralConnection:
     *
     *  @param peripheral   A <code>CBPeripheral</code>.
     *
     *  @discussion         Cancels an active or pending connection to <i>peripheral</i>. Note that this is non-blocking, and any <code>CBPeripheral</code>
     *                      commands that are still pending to <i>peripheral</i> may or may not complete.
     *
     *  @see                centralManager:didDisconnectPeripheral:error:
     *
     */
    public func cancelPeripheralConnection(_ peripheral: CBPeripheral) {
        centralManager.cancelPeripheralConnection(peripheral)
    }

    /**
     *  @method registerForConnectionEventsWithOptions:
     *
     *  @param options      A dictionary specifying connection event options.
     *
     *  @discussion         Calls {@link centralManager:connectionEventDidOccur:forPeripheral:} when a connection event occurs matching any of the given options.
     *                      Passing nil in the option parameter clears any prior registered matching options.
     *
     *  @see                centralManager:connectionEventDidOccur:forPeripheral:
     *  @seealso            CBConnectionEventMatchingOptionServiceUUIDs
     *  @seealso            CBConnectionEventMatchingOptionPeripheralUUIDs
     */
    @available(iOS 13.0, *)
    public func registerForConnectionEvents(options: [CBConnectionEventMatchingOption: Any]? = nil) {
        centralManager.registerForConnectionEvents(options: options)
    }

}
