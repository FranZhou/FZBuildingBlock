//
//  FZPermissionBluetooth.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/11/4.
//

import UIKit
import CoreBluetooth

public class FZPermissionBluetooth: NSObject {

    public static let shared = FZPermissionBluetooth()

    private var bluetoothManagerArray: [FZPermissionBluetoothManager] = []

    public var status: FZPermissionStatus {
        if #available(iOS 13.1, *) {
            let status = CBPeripheralManager.authorization

            switch status {
            case .allowedAlways:
                return .authorized
            case .denied:
                return .denied
            case .restricted:
                return .restricted
            case .notDetermined:
                return .notDetermined
            @unknown default:
                return .disabled("unknown CBPeripheralManager authorizationStatus : \(status)")
            }

        } else {
            let status = CBPeripheralManager.authorizationStatus()

            switch status {
            case .authorized:
                return .authorized
            case .denied:
                return .denied
            case .restricted:
                return .restricted
            case .notDetermined:
                return .notDetermined
            @unknown default:
                return .disabled("unknown CBPeripheralManager authorizationStatus : \(status)")
            }
        }
    }

    public func requestBluetoothPermission(callback: @escaping FZPermission.FZPermissionCallBack) {
        guard FZPermissionType.bluetooth.containsAllUsageDescriptionKeyInInfoPlist else {
            callback(.disabled("WARNING: \(FZPermissionType.bluetooth.missingKeysDescription ?? "") not found in Info.plist"))
            return
        }

        if self.status == .authorized {
            callback(self.status)
        } else {
            let bluetoothManager = FZPermissionBluetoothManager { [weak self](manager, status) in
                guard let `self` = self else {
                        return
                }

                DispatchQueue.main.async {
                    callback(status)
                }

                DispatchQueue.main.async {
                    manager.stopAdvertising()
                    self.bluetoothManagerArray.removeAll { $0 == manager }
                }
            }

            bluetoothManager.startAdvertising(nil)
            self.bluetoothManagerArray.append(bluetoothManager)
        }
    }

}

// MARK: - FZPermissionBluetoothManager
private class FZPermissionBluetoothManager: NSObject {

    typealias FZPermissionBluetoothManagerCallBack = (FZPermissionBluetoothManager, FZPermissionStatus) -> Void

    let callback: FZPermissionBluetoothManagerCallBack

    lazy var bluetoothManager: CBPeripheralManager = {
        let bm = CBPeripheralManager(delegate: self, queue: DispatchQueue.main, options: [CBPeripheralManagerOptionShowPowerAlertKey: true])
        return bm
    }()

    init(callback: @escaping FZPermissionBluetoothManagerCallBack) {
        self.callback = callback
        super.init()
    }

    public func startAdvertising(_ advertisementData: [String: Any]?) {
        self.bluetoothManager.startAdvertising(advertisementData)
    }

    public func stopAdvertising() {
        self.bluetoothManager.stopAdvertising()
    }

}

extension FZPermissionBluetoothManager: CBPeripheralManagerDelegate {

    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        callback(self, FZPermissionBluetooth.shared.status)
    }

}
