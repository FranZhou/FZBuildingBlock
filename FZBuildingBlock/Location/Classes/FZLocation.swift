//
//  FZLocation.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2020/8/28.
//

import UIKit
import CoreLocation

open class FZLocation: NSObject {

    public let location: CLLocation

    public init(location: CLLocation) {
        self.location = location
        super.init()
    }

    /**
     *  initWithLatitude:longitude:
     *
     *  Discussion:
     *    Initialize with the specified latitude and longitude.
     */
    convenience public init(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        self.init(location: location)
    }

    /**
     *  initWithCoordinate:altitude:horizontalAccuracy:verticalAccuracy:timestamp:
     *
     *  Discussion:
     *    Initialize with the specified parameters.
     */
    convenience public init(coordinate: CLLocationCoordinate2D, altitude: CLLocationDistance, horizontalAccuracy hAccuracy: CLLocationAccuracy, verticalAccuracy vAccuracy: CLLocationAccuracy, timestamp: Date) {
        let location = CLLocation(coordinate: coordinate, altitude: altitude, horizontalAccuracy: hAccuracy, verticalAccuracy: vAccuracy, timestamp: timestamp)
        self.init(location: location)
    }

    /**
     *  initWithCoordinate:altitude:horizontalAccuracy:verticalAccuracy:course:speed:timestamp:
     *
     *  Discussion:
     *    Initialize with the specified parameters.
     */
    @available(iOS 4.2, *)
    convenience public init(coordinate: CLLocationCoordinate2D, altitude: CLLocationDistance, horizontalAccuracy hAccuracy: CLLocationAccuracy, verticalAccuracy vAccuracy: CLLocationAccuracy, course: CLLocationDirection, speed: CLLocationSpeed, timestamp: Date) {
        let location = CLLocation(coordinate: coordinate, altitude: altitude, horizontalAccuracy: hAccuracy, verticalAccuracy: vAccuracy, course: course, speed: speed, timestamp: timestamp)
        self.init(location: location)
    }

    /**
     *  initWithCoordinate:altitude:horizontalAccuracy:verticalAccuracy:course:courseAccuracy:speed:speedAccuracy:timestamp:
     *
     *  Discussion:
     *    Initialize with the specified parameters.
     */
    @available(iOS 13.4, *)
    convenience public init(coordinate: CLLocationCoordinate2D, altitude: CLLocationDistance, horizontalAccuracy hAccuracy: CLLocationAccuracy, verticalAccuracy vAccuracy: CLLocationAccuracy, course: CLLocationDirection, courseAccuracy: CLLocationDirectionAccuracy, speed: CLLocationSpeed, speedAccuracy: CLLocationSpeedAccuracy, timestamp: Date) {
        let location = CLLocation(coordinate: coordinate, altitude: altitude, horizontalAccuracy: hAccuracy, verticalAccuracy: vAccuracy, course: course, courseAccuracy: courseAccuracy, speed: speed, speedAccuracy: speedAccuracy, timestamp: timestamp)
        self.init(location: location)
    }

    /**
     *  coordinate
     *
     *  Discussion:
     *    Returns the coordinate of the current location.
     */
    open var coordinate: CLLocationCoordinate2D {
        get {
            return location.coordinate
        }
    }

    /**
     *  altitude
     *
     *  Discussion:
     *    Returns the altitude of the location. Can be positive (above sea level) or negative (below sea level).
     */
    open var altitude: CLLocationDistance {
        get {
            return location.altitude
        }
    }

    /**
     *  horizontalAccuracy
     *
     *  Discussion:
     *    Returns the horizontal accuracy of the location. Negative if the lateral location is invalid.
     */
    open var horizontalAccuracy: CLLocationAccuracy {
        get {
            return location.horizontalAccuracy
        }
    }

    /**
     *  verticalAccuracy
     *
     *  Discussion:
     *    Returns the vertical accuracy of the location. Negative if the altitude is invalid.
     */
    open var verticalAccuracy: CLLocationAccuracy {
        get {
            return location.verticalAccuracy
        }
    }

    /**
     *  course
     *
     *  Discussion:
     *    Returns the course of the location in degrees true North. Negative if course is invalid.
     *
     *  Range:
     *    0.0 - 359.9 degrees, 0 being true North
     */
    @available(iOS 2.2, *)
    open var course: CLLocationDirection {
        get {
            return location.course
        }
    }

    /**
     *  courseAccuracy
     *
     *  Discussion:
     *    Returns the course accuracy of the location in degrees.  Returns negative if course is invalid.
     */
    @available(iOS 13.4, *)
    open var courseAccuracy: CLLocationDirectionAccuracy {
        get {
            return location.courseAccuracy
        }
    }

    /**
     *  speed
     *
     *  Discussion:
     *    Returns the speed of the location in m/s. Negative if speed is invalid.
     */
    @available(iOS 2.2, *)
    open var speed: CLLocationSpeed {
        get {
            return location.speed
        }
    }

    /**
     *  speedAccuracy
     *
     *  Discussion:
     *    Returns the speed accuracy of the location in m/s. Returns -1 if invalid.
     */
    @available(iOS 10.0, *)
    open var speedAccuracy: CLLocationSpeedAccuracy {
        get {
            return location.speedAccuracy
        }
    }

    /**
     *  timestamp
     *
     *  Discussion:
     *    Returns the timestamp when this location was determined.
     */
    open var timestamp: Date {
        get {
            return location.timestamp
        }
    }

    /**
     *  floor
     *
     *  Discussion:
     *    Contains information about the logical floor that you are on
     *    in the current building if you are inside a supported venue.
     *    This will be nil if the floor is unavailable.
     */
    @available(iOS 8.0, *)
    open var floor: CLFloor? {
        get {
            return location.floor
        }
    }

    /**
     *  distanceFromLocation:
     *
     *  Discussion:
     *    Returns the lateral distance between two locations.
     */
    @available(iOS 3.2, *)
    open func distance(from location: CLLocation) -> CLLocationDistance {
        return location.distance(from: location)
    }
}
