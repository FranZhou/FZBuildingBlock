//
//  FZBeacon.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2020/8/28.
//

import Foundation
import CoreLocation

open class FZBeacon: NSObject {

    public let beacon: CLBeacon

    public init(beacon: CLBeacon) {
        self.beacon = beacon
        super.init()
    }

    /**
     *  timestamp
     *
     *  Discussion:
     *    The time when this beacon was observed.
     *
     */
    @available(iOS 13.0, *)
    open var timestamp: Date {
        get {
            return beacon.timestamp
        }
    }

    /**
     *  UUID
     *
     *  Discussion:
     *    UUID associated with the beacon.
     *
     */
    @available(iOS 13.0, *)
    open var uuid: UUID {
        get {
            return beacon.uuid
        }
    }

    @available(iOS, introduced: 7.0, deprecated: 13.0)
    open var proximityUUID: UUID {
        get {
            return beacon.proximityUUID
        }
    }

    /**
     *  major
     *
     *  Discussion:
     *    Most significant value associated with the beacon.
     *
     */
    open var major: NSNumber {
        get {
            return beacon.major
        }
    }

    /**
     *  minor
     *
     *  Discussion:
     *    Least significant value associated with the beacon.
     *
     */
    open var minor: NSNumber {
        get {
            return beacon.minor
        }
    }

    /**
     *  proximity
     *
     *  Discussion:
     *    Proximity of the beacon from the device.
     *
     */
    open var proximity: CLProximity {
        get {
            return beacon.proximity
        }
    }

    /**
     *  accuracy
     *
     *  Discussion:
     *    Represents an one sigma horizontal accuracy in meters where the measuring device's location is
     *    referenced at the beaconing device. This value is heavily subject to variations in an RF environment.
     *    A negative accuracy value indicates the proximity is unknown.
     *
     */
    open var accuracy: CLLocationAccuracy {
        get {
            return beacon.accuracy
        }
    }

    /**
     *  rssi
     *
     *  Discussion:
     *    Received signal strength in decibels of the specified beacon.
     *    This value is an average of the RSSI samples collected since this beacon was last reported.
     *
     */
    open var rssi: Int {
        get {
            beacon.rssi
        }
    }
}
