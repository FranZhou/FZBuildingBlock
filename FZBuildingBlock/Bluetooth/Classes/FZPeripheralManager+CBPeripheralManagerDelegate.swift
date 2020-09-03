//
//  FZPeripheralManager+CBPeripheralManagerDelegate.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2020/9/2.
//

import Foundation
import CoreBluetooth
import FZWeakProxy

extension FZPeripheralManager: CBPeripheralManagerDelegate {

    /**
     *  @method peripheralManagerDidUpdateState:
     *
     *  @param peripheral   The peripheral manager whose state has changed.
     *
     *  @discussion         Invoked whenever the peripheral manager's state has been updated. Commands should only be issued when the state is
     *                      <code>CBPeripheralManagerStatePoweredOn</code>. A state below <code>CBPeripheralManagerStatePoweredOn</code>
     *                      implies that advertisement has paused and any connected centrals have been disconnected. If the state moves below
     *                      <code>CBPeripheralManagerStatePoweredOff</code>, advertisement is stopped and must be explicitly restarted, and the
     *                      local database is cleared and all services must be re-added.
     *
     *  @see                state
     *
     */
    @available(iOS 6.0, *)
    public func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        if #available(iOS 10.0, *) {
            peripheralManagerState.wrappedValue = (FZWeakProxy(target: self), peripheral.state)
            FZBluetoothConfiguration.bluetoothState?(peripheral.state)
        } else {
            // Fallback on earlier versions
        }
    }

    /**
     *  @method peripheralManager:willRestoreState:
     *
     *  @param peripheral    The peripheral manager providing this information.
     *  @param dict            A dictionary containing information about <i>peripheral</i> that was preserved by the system at the time the app was terminated.
     *
     *  @discussion            For apps that opt-in to state preservation and restoration, this is the first method invoked when your app is relaunched into
     *                        the background to complete some Bluetooth-related task. Use this method to synchronize your app's state with the state of the
     *                        Bluetooth system.
     *
     *  @seealso            CBPeripheralManagerRestoredStateServicesKey;
     *  @seealso            CBPeripheralManagerRestoredStateAdvertisementDataKey;
     *
     */
    @available(iOS 6.0, *)
    public func peripheralManager(_ peripheral: CBPeripheralManager, willRestoreState dict: [String: Any]) {
         peripheralManagerRestoreState.wrappedValue = (FZWeakProxy(target: self), dict)
    }

    /**
     *  @method peripheralManagerDidStartAdvertising:error:
     *
     *  @param peripheral   The peripheral manager providing this information.
     *  @param error        If an error occurred, the cause of the failure.
     *
     *  @discussion         This method returns the result of a @link startAdvertising: @/link call. If advertisement could
     *                      not be started, the cause will be detailed in the <i>error</i> parameter.
     *
     */
    @available(iOS 6.0, *)
    public func peripheralManagerDidStartAdvertising(_ peripheral: CBPeripheralManager, error: Error?) {
         peripheralManagerStartAdvertising.wrappedValue = (FZWeakProxy(target: self), FZBluetoothError(error: error))
    }

    /**
     *  @method peripheralManager:didAddService:error:
     *
     *  @param peripheral   The peripheral manager providing this information.
     *  @param service      The service that was added to the local database.
     *  @param error        If an error occurred, the cause of the failure.
     *
     *  @discussion         This method returns the result of an @link addService: @/link call. If the service could
     *                      not be published to the local database, the cause will be detailed in the <i>error</i> parameter.
     *
     */
    @available(iOS 6.0, *)
    public func peripheralManager(_ peripheral: CBPeripheralManager, didAdd service: CBService, error: Error?) {
         peripheralManagerAddService.wrappedValue = (FZWeakProxy(target: self), service, FZBluetoothError(error: error))
    }

    /**
     *  @method peripheralManager:central:didSubscribeToCharacteristic:
     *
     *  @param peripheral       The peripheral manager providing this update.
     *  @param central          The central that issued the command.
     *  @param characteristic   The characteristic on which notifications or indications were enabled.
     *
     *  @discussion             This method is invoked when a central configures <i>characteristic</i> to notify or indicate.
     *                          It should be used as a cue to start sending updates as the characteristic value changes.
     *
     */
    @available(iOS 6.0, *)
    public func peripheralManager(_ peripheral: CBPeripheralManager, central: CBCentral, didSubscribeTo characteristic: CBCharacteristic) {
         peripheralManagerSubscribeCharacteristic.wrappedValue = (FZWeakProxy(target: self), central, characteristic)
    }

    /**
     *  @method peripheralManager:central:didUnsubscribeFromCharacteristic:
     *
     *  @param peripheral       The peripheral manager providing this update.
     *  @param central          The central that issued the command.
     *  @param characteristic   The characteristic on which notifications or indications were disabled.
     *
     *  @discussion             This method is invoked when a central removes notifications/indications from <i>characteristic</i>.
     *
     */
    @available(iOS 6.0, *)
    public func peripheralManager(_ peripheral: CBPeripheralManager, central: CBCentral, didUnsubscribeFrom characteristic: CBCharacteristic) {
         peripheralManagerUnsubscribeCharacteristic.wrappedValue = (FZWeakProxy(target: self), central, characteristic)
    }

    /**
     *  @method peripheralManager:didReceiveReadRequest:
     *
     *  @param peripheral   The peripheral manager requesting this information.
     *  @param request      A <code>CBATTRequest</code> object.
     *
     *  @discussion         This method is invoked when <i>peripheral</i> receives an ATT request for a characteristic with a dynamic value.
     *                      For every invocation of this method, @link respondToRequest:withResult: @/link must be called.
     *
     *  @see                CBATTRequest
     *
     */
    @available(iOS 6.0, *)
    public func peripheralManager(_ peripheral: CBPeripheralManager, didReceiveRead request: CBATTRequest) {
         peripheralManagerReceiveRead.wrappedValue = (FZWeakProxy(target: self), request)
    }

    /**
     *  @method peripheralManager:didReceiveWriteRequests:
     *
     *  @param peripheral   The peripheral manager requesting this information.
     *  @param requests     A list of one or more <code>CBATTRequest</code> objects.
     *
     *  @discussion         This method is invoked when <i>peripheral</i> receives an ATT request or command for one or more characteristics with a dynamic value.
     *                      For every invocation of this method, @link respondToRequest:withResult: @/link should be called exactly once. If <i>requests</i> contains
     *                      multiple requests, they must be treated as an atomic unit. If the execution of one of the requests would cause a failure, the request
     *                      and error reason should be provided to <code>respondToRequest:withResult:</code> and none of the requests should be executed.
     *
     *  @see                CBATTRequest
     *
     */
    @available(iOS 6.0, *)
    public func peripheralManager(_ peripheral: CBPeripheralManager, didReceiveWrite requests: [CBATTRequest]) {
         peripheralManagerReceiveWrite.wrappedValue = (FZWeakProxy(target: self), requests)
    }

    /**
     *  @method peripheralManagerIsReadyToUpdateSubscribers:
     *
     *  @param peripheral   The peripheral manager providing this update.
     *
     *  @discussion         This method is invoked after a failed call to @link updateValue:forCharacteristic:onSubscribedCentrals: @/link, when <i>peripheral</i> is again
     *                      ready to send characteristic value updates.
     *
     */
    @available(iOS 6.0, *)
    public func peripheralManagerIsReady(toUpdateSubscribers peripheral: CBPeripheralManager) {
         peripheralManagerIsReadyToUpdateSubscribers.wrappedValue = FZWeakProxy(target: self)
    }

    /**
     *  @method peripheralManager:didPublishL2CAPChannel:error:
     *
     *  @param peripheral   The peripheral manager requesting this information.
     *  @param PSM            The PSM of the channel that was published.
     *  @param error        If an error occurred, the cause of the failure.
     *
     *  @discussion         This method is the response to a  @link publishL2CAPChannel: @/link call.  The PSM will contain the PSM that was assigned for the published
     *                        channel
     *
     */
    @available(iOS 6.0, *)
    public func peripheralManager(_ peripheral: CBPeripheralManager, didPublishL2CAPChannel PSM: CBL2CAPPSM, error: Error?) {
         peripheralManagerPublishL2CAPChannel.wrappedValue = (FZWeakProxy(target: self), PSM, FZBluetoothError(error: error))
    }

    /**
     *  @method peripheralManager:didUnublishL2CAPChannel:error:
     *
     *  @param peripheral   The peripheral manager requesting this information.
     *  @param PSM            The PSM of the channel that was published.
     *  @param error        If an error occurred, the cause of the failure.
     *
     *  @discussion         This method is the response to a  @link unpublishL2CAPChannel: @/link call.
     *
     */
    @available(iOS 6.0, *)
    public func peripheralManager(_ peripheral: CBPeripheralManager, didUnpublishL2CAPChannel PSM: CBL2CAPPSM, error: Error?) {
         peripheralManagerUnpublishL2CAPChannel.wrappedValue = (FZWeakProxy(target: self), PSM, FZBluetoothError(error: error))
    }

    /**
     *  @method peripheral:didOpenL2CAPChannel:error:
     *
     *  @param peripheral        The peripheral providing this information.
     *  @param channel            A <code>CBL2CAPChannel</code> object.
     *    @param error            If an error occurred, the cause of the failure.
     *
     *  @discussion                This method returns the result of a @link openL2CAPChannel: @link call.
     */
    /*!
     *  @method peripheralManager:didOpenL2CAPChannel:error:
     *
     *  @param peripheral       The peripheral manager requesting this information.
     *  @param channel              A <code>CBL2CAPChannel</code> object.
     *    @param error        If an error occurred, the cause of the failure.
     *
     *  @discussion            This method returns the result of establishing an incoming L2CAP channel , following publishing a channel using @link publishL2CAPChannel: @link call.
     *
     */
    @available(iOS 11.0, *)
    public func peripheralManager(_ peripheral: CBPeripheralManager, didOpen channel: CBL2CAPChannel?, error: Error?) {
         peripheralManagerOpenL2CAPChannel.wrappedValue = (FZWeakProxy(target: self), channel, FZBluetoothError(error: error))
    }

}
