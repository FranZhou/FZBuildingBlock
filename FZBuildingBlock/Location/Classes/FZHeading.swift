//
//  FZHeading.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2020/8/28.
//

import Foundation
import CoreLocation

open class FZHeading: NSObject {

    public let heading: CLHeading

    public init(heading: CLHeading) {
        self.heading = heading
        super.init()
    }

    /**
     *  magneticHeading
     *
     *  Discussion:
     *    Represents the direction in degrees, where 0 degrees is magnetic North. The direction is referenced from the top of the device regardless of device orientation as well as the orientation of the user interface.
     *
     *  Range:
     *    0.0 - 359.9 degrees, 0 being magnetic North
     */
    open var magneticHeading: CLLocationDirection {
        get {
            return heading.magneticHeading
        }
    }

    /**
     *  trueHeading
     *
     *  Discussion:
     *    Represents the direction in degrees, where 0 degrees is true North. The direction is referenced
     *    from the top of the device regardless of device orientation as well as the orientation of the
     *    user interface.
     *
     *  Range:
     *    0.0 - 359.9 degrees, 0 being true North
     */
    open var trueHeading: CLLocationDirection {
        get {
            return heading.trueHeading
        }
    }

    /**
     *  headingAccuracy
     *
     *  Discussion:
     *    Represents the maximum deviation of where the magnetic heading may differ from the actual geomagnetic heading in degrees. A negative value indicates an invalid heading.
     */
    open var headingAccuracy: CLLocationDirection {
        get {
            return heading.headingAccuracy
        }
    }

    /**
     *  x
     *
     *  Discussion:
     *    Returns a raw value for the geomagnetism measured in the x-axis.
     *
     */
    open var x: CLHeadingComponentValue {
        get {
            return heading.x
        }
    }

    /**
     *  y
     *
     *  Discussion:
     *    Returns a raw value for the geomagnetism measured in the y-axis.
     *
     */
    open var y: CLHeadingComponentValue {
        get {
            return heading.y
        }
    }

    /**
     *  z
     *
     *  Discussion:
     *    Returns a raw value for the geomagnetism measured in the z-axis.
     *
     */
    open var z: CLHeadingComponentValue {
        get {
            return heading.z
        }
    }

    /**
     *  timestamp
     *
     *  Discussion:
     *    Returns a timestamp for when the magnetic heading was determined.
     */
    open var timestamp: Date {
        get {
            return heading.timestamp
        }
    }
}
