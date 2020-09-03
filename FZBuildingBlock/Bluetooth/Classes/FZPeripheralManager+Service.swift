//
//  FZPeripheralManager+Service.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2020/9/3.
//

import Foundation
import CoreBluetooth

// MARK: - Service
/// service
extension FZPeripheralManager {
    /**
     *  @method addService:
     *
     *  @param service  A GATT service.
     *
     *  @discussion     Publishes a service and its associated characteristic(s) to the local database. If the service contains included services,
     *                  they must be published first.
     *
     *  @see            peripheralManager:didAddService:error:
     */
    public func add(_ service: CBMutableService) {
        peripheralManager.add(service)
    }

    /**
     *  @method removeService:
     *
     *  @param service  A GATT service.
     *
     *  @discussion     Removes a published service from the local database. If the service is included by other service(s), they must be removed
     *                  first.
     *
     */
    public func remove(_ service: CBMutableService) {
        peripheralManager.remove(service)
    }

    /**
     *  @method removeAllServices
     *
     *  @discussion Removes all published services from the local database.
     *
     */
    public func removeAllServices() {
        peripheralManager.removeAllServices()
    }

}
