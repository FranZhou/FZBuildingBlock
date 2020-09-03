//
//  FZPeripheralManager+Value.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2020/9/3.
//

import Foundation
import CoreBluetooth

// MARK: - Value
/// request response
extension FZPeripheralManager {

    /**
     *  @method respondToRequest:withResult:
     *
     *  @param request  The original request that was received from the central.
     *  @param result   The result of attempting to fulfill <i>request</i>.
     *
     *  @discussion     Used to respond to request(s) received via the @link peripheralManager:didReceiveReadRequest: @/link or
     *                  @link peripheralManager:didReceiveWriteRequests: @/link delegate methods.
     *
     *  @see            peripheralManager:didReceiveReadRequest:
     *  @see            peripheralManager:didReceiveWriteRequests:
     */
    public func respond(to request: CBATTRequest, withResult result: CBATTError.Code) {
        peripheralManager.respond(to: request, withResult: result)
    }

    /**
     *  @method updateValue:forCharacteristic:onSubscribedCentrals:
     *
     *  @param value            The value to be sent via a notification/indication.
     *  @param characteristic   The characteristic whose value has changed.
     *  @param centrals         A list of <code>CBCentral</code> objects to receive the update. Note that centrals which have not subscribed to
     *                          <i>characteristic</i> will be ignored. If <i>nil</i>, all centrals that are subscribed to <i>characteristic</i> will be updated.
     *
     *  @discussion             Sends an updated characteristic value to one or more centrals, via a notification or indication. If <i>value</i> exceeds
     *                            {@link maximumUpdateValueLength}, it will be truncated to fit.
     *
     *  @return                 <i>YES</i> if the update could be sent, or <i>NO</i> if the underlying transmit queue is full. If <i>NO</i> was returned,
     *                          the delegate method @link peripheralManagerIsReadyToUpdateSubscribers: @/link will be called once space has become
     *                          available, and the update should be re-sent if so desired.
     *
     *  @see                    peripheralManager:central:didSubscribeToCharacteristic:
     *  @see                    peripheralManager:central:didUnsubscribeFromCharacteristic:
     *  @see                    peripheralManagerIsReadyToUpdateSubscribers:
     *    @seealso                maximumUpdateValueLength
     */
    public func updateValue(_ value: Data, for characteristic: CBMutableCharacteristic, onSubscribedCentrals centrals: [CBCentral]?) -> Bool {
        return peripheralManager.updateValue(value, for: characteristic, onSubscribedCentrals: centrals)
    }

}
