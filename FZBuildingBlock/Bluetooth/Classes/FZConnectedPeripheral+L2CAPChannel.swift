//
//  FZConnectedPeripheral+L2CAPChannel.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2020/9/3.
//

import Foundation
import CoreBluetooth

extension FZConnectedPeripheral {

    /**
     *  @method openL2CAPChannel:
     *
     *  @param PSM          The PSM of the channel to open
     *
     *  @discussion         Attempt to open an L2CAP channel to the peripheral using the supplied PSM.
     *
     *  @see                peripheral:didWriteValueForCharacteristic:error:
     */
    @available(iOS 11.0, *)
    public func openL2CAPChannel(_ PSM: CBL2CAPPSM) {
        peripheral.openL2CAPChannel(PSM)
    }

}
