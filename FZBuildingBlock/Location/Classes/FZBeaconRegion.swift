//
//  FZBeaconRegion.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2020/8/28.
//

import Foundation
import CoreLocation

open class FZBeaconRegion: FZRegion {

    public var beaconRegion: CLBeaconRegion {
        get {
            return region as! CLBeaconRegion
        }
    }

    public init(beaconRegion: CLBeaconRegion) {
        super.init(region: beaconRegion)
    }

    /*
     *  initWithUUID:identifier:
     *
     *  Discussion:
     *    Initialize a beacon region with a UUID. Major and minor values will be wildcarded.
     *
     */
    @available(iOS 13.0, *)
    convenience public init(uuid: UUID, identifier: String) {
        let beaconRegion = CLBeaconRegion(uuid: uuid, identifier: identifier)
        self.init(beaconRegion: beaconRegion)
    }

    @available(iOS, introduced: 7.0, deprecated: 13.0)
    convenience public init(proximityUUID: UUID, identifier: String) {
        let beaconRegion = CLBeaconRegion(proximityUUID: proximityUUID, identifier: identifier)
        self.init(beaconRegion: beaconRegion)
    }

    /*
     *  initWithUUID:major:identifier:
     *
     *  Discussion:
     *    Initialize a beacon region with a UUID and major value. Minor value will be wildcarded.
     *
     */
    @available(iOS 13.0, *)
    convenience public init(uuid: UUID, major: CLBeaconMajorValue, identifier: String) {
        let beaconRegion = CLBeaconRegion(uuid: uuid, major: major, identifier: identifier)
        self.init(beaconRegion: beaconRegion)
    }

    @available(iOS, introduced: 7.0, deprecated: 13.0)
    convenience public init(proximityUUID: UUID, major: CLBeaconMajorValue, identifier: String) {
        let beaconRegion = CLBeaconRegion(proximityUUID: proximityUUID, major: major, identifier: identifier)
        self.init(beaconRegion: beaconRegion)
    }

    /*
     *  initWithUUID:major:minor:identifier:
     *
     *  Discussion:
     *    Initialize a beacon region identified by a UUID, major and minor values.
     *
     */
    @available(iOS 13.0, *)
    convenience public init(uuid: UUID, major: CLBeaconMajorValue, minor: CLBeaconMinorValue, identifier: String) {
        let beaconRegion = CLBeaconRegion(uuid: uuid, major: major, minor: minor, identifier: identifier)
        self.init(beaconRegion: beaconRegion)
    }

    @available(iOS, introduced: 7.0, deprecated: 13.0)
    convenience  public init(proximityUUID: UUID, major: CLBeaconMajorValue, minor: CLBeaconMinorValue, identifier: String) {
        let beaconRegion = CLBeaconRegion(proximityUUID: proximityUUID, major: major, minor: minor, identifier: identifier)
        self.init(beaconRegion: beaconRegion)
    }

    /*
     *  initWithBeaconIdentityConstraint:identifier:
     *
     *  Discussion:
     *    Initialize a beacon region described by a beacon identity
     *    constraint.
     *
     */
    @available(iOS 13.0, *)
    convenience public init(beaconIdentityConstraint: CLBeaconIdentityConstraint, identifier: String) {
        let beaconRegion = CLBeaconRegion(beaconIdentityConstraint: beaconIdentityConstraint, identifier: identifier)
        self.init(beaconRegion: beaconRegion)
    }

    /*
     *  peripheralDataWithMeasuredPower:
     *
     *  Discussion:
     *    This dictionary can be used to advertise the current device as a beacon when
     *    used in conjunction with CoreBluetooth's CBPeripheralManager startAdvertising: method.
     *    The dictionary will contain data that represents the current region in addition to a measured power value.
     *
     *    measuredPower is the RSSI of the device observed from one meter in its intended environment.
     *    This value is optional, but should be specified to achieve the best ranging performance.
     *    If not specified, it will default to a pre-determined value for the device.
     *
     */
    open func peripheralData(withMeasuredPower measuredPower: NSNumber?) -> NSMutableDictionary {
        return beaconRegion.peripheralData(withMeasuredPower: measuredPower)
    }

    /*
     *  beaconIdentityConstraint
     *
     *  Discussion:
     *    Returns a CLBeaconIdentityConstraint describing the beacons this region monitors.
     */
    @available(iOS 13.0, *)
    open var beaconIdentityConstraint: CLBeaconIdentityConstraint {
        get {
            return beaconRegion.beaconIdentityConstraint
        }
    }

    /*
     *  UUID
     *
     *  Discussion:
     *    UUID associated with the region.
     *
     */
    @available(iOS 13.0, *)
    open var uuid: UUID {
        get {
            return beaconRegion.uuid
        }
    }

    @available(iOS, introduced: 7.0, deprecated: 13.0)
    open var proximityUUID: UUID {
        get {
            return beaconRegion.proximityUUID
        }
    }

    /*
     *  major
     *
     *  Discussion:
     *    Most significant value associated with the region. If a major value wasn't specified, this will be nil.
     *
     */
    open var major: NSNumber? {
        get {
            return beaconRegion.major
        }
    }

    /*
     *  minor
     *
     *  Discussion:
     *    Least significant value associated with the region. If a minor value wasn't specified, this will be nil.
     *
     */
    open var minor: NSNumber? {
        get {
            return beaconRegion.minor
        }
    }

    /*
     *  notifyEntryStateOnDisplay
     *
     *  Discussion:
     *    App will be launched and the delegate will be notified via locationManager:didDetermineState:forRegion:
     *    when the device's screen is turned on and the user is in the region. By default, this is NO.
     */
    open var notifyEntryStateOnDisplay: Bool {
        get {
            return beaconRegion.notifyEntryStateOnDisplay
        }
        set {
            beaconRegion.notifyEntryStateOnDisplay = newValue
        }
    }

}
