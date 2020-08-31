//
//  FZBeaconIdentityConstraint.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2020/8/28.
//

import Foundation
import CoreLocation

@available(iOS 13.0, *)
open class FZBeaconIdentityConstraint: NSObject {

    public let beaconIdentityConstraint: CLBeaconIdentityConstraint

    public init(beaconIdentityConstraint: CLBeaconIdentityConstraint) {
        self.beaconIdentityConstraint = beaconIdentityConstraint
        super.init()
    }

    /**
     *  UUID
     *
     *  Discussion:
     *    UUID associated with the beacon.
     *
     */
    open var uuid: UUID {
        get {
            return beaconIdentityConstraint.uuid
        }
    }

    /**
     *  major
     *
     *  Discussion:
     *    Most significant value associated with the beacon.
     *
     */
    open var __major: NSNumber? {
        get {
            return beaconIdentityConstraint.__major
        }
    }

    /**
     *  minor
     *
     *  Discussion:
     *    Least significant value associated with the beacon.
     *
     */
    open var __minor: NSNumber? {
        get {
            return beaconIdentityConstraint.__minor
        }
    }

    /**
     *  initWithUUID:
     *
     *  Discussion:
     *    Initialize a beacon identity constraint with a UUID. Major and
     *    minor values will be wildcarded.
     *
     */
    convenience public init(uuid: UUID) {
        let beaconIdentityConstraint = CLBeaconIdentityConstraint(uuid: uuid)
        self.init(beaconIdentityConstraint: beaconIdentityConstraint)
    }

    /**
     *  initWithUUID:major:
     *
     *  Discussion:
     *    Initialize a beacon identity constraint with a UUID and major
     *    value.  Minor value will be wildcarded.
     *
     */
    convenience public init(uuid: UUID, major: CLBeaconMajorValue) {
        let beaconIdentityConstraint = CLBeaconIdentityConstraint(uuid: uuid, major: major)
        self.init(beaconIdentityConstraint: beaconIdentityConstraint)
    }

    /**
     *  initWithUUID:major:minor:
     *
     *  Discussion:
     *    Initialize a beacon identity constraint with a UUID, major, and
     *    minor values.
     *
     */
    convenience public init(uuid: UUID, major: CLBeaconMajorValue, minor: CLBeaconMinorValue) {
        let beaconIdentityConstraint = CLBeaconIdentityConstraint(uuid: uuid, major: major, minor: minor)
        self.init(beaconIdentityConstraint: beaconIdentityConstraint)
    }
}

@available(iOS 13.0, *)
extension FZBeaconIdentityConstraint {

    open var major: UInt16? {
        get {
            return beaconIdentityConstraint.major
        }
    }

    open var minor: UInt16? {
        get {
            return beaconIdentityConstraint.minor
        }
    }

}
