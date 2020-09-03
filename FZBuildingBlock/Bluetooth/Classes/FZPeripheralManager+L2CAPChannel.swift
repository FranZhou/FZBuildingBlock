//
//  FZPeripheralManager+L2CAPChannel.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2020/9/3.
//

import Foundation
import CoreBluetooth

// MARK: - L2CAPChannel
/// L2CAPChannel
extension FZPeripheralManager {

    /**
     *  @method publishL2CAPChannelWithEncryption:
     *
     *  @param encryptionRequired        YES if the service requires the link to be encrypted before a stream can be established.  NO if the service can be used over
     *                                    an unsecured link.
     *
     *  @discussion     Create a listener for incoming L2CAP Channel connections.  The system will determine an unused PSM at the time of publishing, which will be returned
     *                    with @link peripheralManager:didPublishL2CAPChannel:error: @/link.  L2CAP Channels are not discoverable by themselves, so it is the application's
     *                    responsibility to handle PSM discovery on the client.
     *
     */
    @available(iOS 11.0, *)
    public func publishL2CAPChannel(withEncryption encryptionRequired: Bool) {
        peripheralManager.publishL2CAPChannel(withEncryption: encryptionRequired)
    }

    /**
     *  @method unpublishL2CAPChannel:
     *
     *  @param PSM        The service PSM to be removed from the system.
     *
     *  @discussion     Removes a published service from the local system.  No new connections for this PSM will be accepted, and any existing L2CAP channels
     *                    using this PSM will be closed.
     *
     */
    @available(iOS 11.0, *)
    public func unpublishL2CAPChannel(_ PSM: CBL2CAPPSM) {
        peripheralManager.unpublishL2CAPChannel(PSM)
    }

}
